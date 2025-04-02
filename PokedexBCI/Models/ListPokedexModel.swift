//
//  ListPokedexModel.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import Foundation

// MARK: - ListPokedexModel
struct ListPokedexResponse : Codable {
    var count: Int?
    var results: [ResultPokeDex]?
}

struct ResultPokeDex: Codable {
    var name: String?
    var url: String?
    
    var id: Int? {
        guard let url = url else { return nil }
        return Int(url.split(separator: "/").last?.description ?? "")
    }
}
