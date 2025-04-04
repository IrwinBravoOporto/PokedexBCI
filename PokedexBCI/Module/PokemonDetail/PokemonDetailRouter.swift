//
//  PokemonDetailRouter.swift
//  PokedexBCI
//
//  Created Irwin Bravo Oporto on 2/04/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Nishi
//

import UIKit

class PokemonDetailRouter: PokemonDetailWireframeProtocol {
    static func createModule(with pokemon: ResultPokeDex) -> UIViewController {
        let view = PokemonDetailViewController()
        let interactor = PokemonDetailInteractor()
        let router = PokemonDetailRouter()
        let presenter = PokemonDetailPresenter(
            interface: view,
            interactor: interactor,
            router: router,
            pokemon: pokemon
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}
