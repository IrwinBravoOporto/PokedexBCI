//
//  PokemonDetail.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import UIKit

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonType]
    let stats: [Stat]
    let height: Int
    let weight: Int
    let abilities: [Ability]
    
    struct Sprites: Codable {
        let frontDefault: String?
        let other: Other?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case other
        }
        
        struct Other: Codable {
            let officialArtwork: OfficialArtwork?
            
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
        }
        
        struct OfficialArtwork: Codable {
            let frontDefault: String?
            
            enum CodingKeys: String, CodingKey {
                case frontDefault = "front_default"
            }
        }
    }
    
    struct PokemonType: Codable {
        let slot: Int
        let type: PokemonTypeInfo
        
        struct PokemonTypeInfo: Codable {
            let name: String
        }
    }
    
    struct Stat: Codable {
        let baseStat: Int
        let stat: StatDetail
        
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }
    }
    
    struct StatDetail: Codable {
        let name: String
    }
    
    struct Ability: Codable {
        let ability: AbilityDetail
        let isHidden: Bool
        
        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
        }
    }
    
    struct AbilityDetail: Codable {
        let name: String
    }
}
