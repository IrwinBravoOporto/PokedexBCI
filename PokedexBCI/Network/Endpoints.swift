//
//  Endpoints.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import Foundation

public protocol EndpointsProtocols {
    var url: String { get }
    var fileName: String { get }
}

struct BaseUrl {
    static var baseURL = "https://pokeapi.co/api/v2"
}

public enum Endpoints: EndpointsProtocols {
    case listPokedex
    case pokemonDetail(id: Int)
    case pokemonSpecies(id: Int)  // Para información adicional como descripciones
    
    public var url: String {
        switch self {
        case .listPokedex:
            return BaseUrl.baseURL + "/pokemon?"
        case .pokemonDetail(let id):
            return BaseUrl.baseURL + "/pokemon/\(id)"
        case .pokemonSpecies(let id):
            return BaseUrl.baseURL + "/pokemon-species/\(id)"
        }
    }
    
    public var fileName: String {
        switch self {
        case .listPokedex:
            return "pokemon_list"
        case .pokemonDetail:
            return "pokemon_detail"
        case .pokemonSpecies:
            return "pokemon_species"
        }
    }
}
