//
//  NetworkDataManager.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import UIKit


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum CustomError: Error {
    case errorUrl
    case errorUnknow
    case errorServer(statusCode: Int)
    case errorDecoding
    case requestCancelled
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .errorUrl:
            return "Error de URL"
        case .errorDecoding:
            return "Error de parseo de datos"
        case .errorUnknow:
            return "Error desconocido"
        case .errorServer(let statusCode):
            return "Error de servicio: \(statusCode)"
        case .requestCancelled:
            return "Request cancelled"
        }
    }
}


protocol NetworkDataProtocol {
    func fetchData<T: Codable>(type: T.Type,
                               method: HttpMethod,
                               url: String,
                               parameters: [String: Any]?,
                               headers: [String: String]?,
                               retries: Int,
                               isCancellable: Bool) async throws -> T
    func cancelRequest()
}

class NetworkDataManager: NetworkDataProtocol {
    
    private let session: URLSession
    private var currentTask: URLSessionTask?
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Codable>(type: T.Type,
                               method: HttpMethod = .get,
                               url: String,
                               parameters: [String: Any]? = nil,
                               headers: [String: String]? = nil,
                               retries: Int = 3,
                               isCancellable: Bool = false) async throws -> T {
        
        guard var _url = URL(string: url) else {
            throw CustomError.errorUrl
        }
        
        var urlModified = _url
        if method == .get {
            urlModified = composeGetURL(url: _url, params: parameters)
        }
        
        print( "******************** COMPOSED URL: \(urlModified) ********************" )
        var request = URLRequest(url: urlModified)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if method == .post, let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let urlResponse = response as? HTTPURLResponse else {
            throw CustomError.errorUnknow
        }
        
        guard (200..<300).contains(urlResponse.statusCode) else {
            if retries > 0 {
                return try await fetchData(type: type, method: method, url: url, parameters: parameters, headers: headers, retries: retries - 1)
            } else {
                throw CustomError.errorServer(statusCode: urlResponse.statusCode)
            }
        }
        
        print( "******************** URL: \(url) ********************" )
        let decoder = JSONDecoder()
        do {
            print( String(data: data, encoding: .utf8) ?? "" )
            print( "******************************************************" )
            return try decoder.decode(type.self, from: data)
        } catch {
            print(error)
            print( "******************************************************" )
            throw CustomError.errorDecoding
        }
    }
    
    func composeGetURL( url: URL, params: [String: Any]? = nil ) -> URL {
        var urlComponets = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let params {
            urlComponets?.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value as? String )
            }
        }
        guard let completePath = urlComponets?.url else { return url }
        return completePath
    }
    
    func debouncedFetchData<T: Codable>(type: T.Type,
                                        method: HttpMethod = .get,
                                        url: String,
                                        parameters: [String: Any]? = nil,
                                        headers: [String: String]? = nil,
                                        retries: Int = 3,
                                        delay: TimeInterval = 0.5,
                                        completion: @escaping (Result<T, Error>) -> Void) {
        pendingRequestWorkItem?.cancel()
        let requestWorkItem = DispatchWorkItem {
            Task {
                do {
                    let result = try await self.fetchData(type: type, method: method, url: url, parameters: parameters, headers: headers, retries: retries)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: requestWorkItem)
    }
    
    func cancelRequest() {
        currentTask?.cancel()
        currentTask = nil
    }
}
