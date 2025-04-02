//
//  PokeDexInteractor.swift
//  PokedexBCI
//
//  Created Irwin Bravo Oporto on 1/04/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Nishi
//

import UIKit

class PokeDexInteractor: PokeDexInteractorInputProtocol {
    weak var presenter: PokeDexInteractorOutputProtocol?
    
    
    let pokeManager = PokeManager.shared
    
    
    func fetchServiceListPokeDex(completion: @escaping (Result<ListPokedexResponse, Error>) -> Void) {
        
        let parameters = [
            "limit": "151",  // Obtenemos los primeros 151 Pokémon
            "offset": "0"    // Comenzamos desde el primero
        ]
        
        self.pokeManager.getData(
            endpoint: .listPokedex,
            parameters: parameters,
            onComplete: completion
        )
    }

}
