//
//  PokeManager.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import Foundation

class PokeManager {
    static let shared = PokeManager()
    let networkingNoCipher = NetworkDataManager()
    
    func getData<T: Codable>(
        endpoint: Endpoints,
        parameters: [String: String?],
        onComplete: @escaping (Result<T, Error>) -> Void
    ) {
        Task {
            do {
                guard let url = endpoint.url.buildURL(parameters: parameters) else {
                    throw NetworkError.invalidURL
                }
                
                let response = try await self.networkingNoCipher.fetchData(type: T.self, url: url)
                DispatchQueue.main.async {
                    onComplete(.success(response))
                }
            } catch {
                DispatchQueue.main.async {
                    onComplete(.failure(error))
                }
            }
        }
    }
}
