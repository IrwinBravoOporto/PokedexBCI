//
//  PokemonDetailInteractor.swift
//  PokedexBCI
//
//  Created Irwin Bravo Oporto on 2/04/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Nishi
//

import Foundation

class PokemonDetailInteractor: PokemonDetailInteractorInputProtocol {
    weak var presenter: PokemonDetailInteractorOutputProtocol?
    private let pokeManager = PokeManager.shared
    
    func fetchPokemonDetail(id: Int) {
        pokeManager.getData(endpoint: .pokemonDetail(id: id), parameters: [:]) {
            (result: Result<PokemonDetail, Error>) in
            switch result {
            case .success(let detail):
                self.presenter?.didReceiveDetail(detail)
            case .failure(let error):
                self.presenter?.onError(error)
            }
        }
    }
}
