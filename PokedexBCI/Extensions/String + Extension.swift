//
//  String+Extension.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import UIKit

extension String {
    
    func buildURL(parameters: [String: String?]) -> String? {
        var urlComponents = URLComponents(string: self)
        
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            if let value = value {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        }
        
        urlComponents?.queryItems = queryItems.isEmpty ? nil : queryItems
        
        return urlComponents?.url?.absoluteString
    }
}
