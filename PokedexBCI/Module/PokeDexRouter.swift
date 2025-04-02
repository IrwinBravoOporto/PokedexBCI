//
//  PokeDexRouter.swift
//  PokedexBCI
//
//  Created Irwin Bravo Oporto on 1/04/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Nishi
//

import UIKit

class PokeDexRouter: PokeDexWireframeProtocol {
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = PokeDexViewController()
        let interactor = PokeDexInteractor()
        let router = PokeDexRouter()
        let presenter = PokeDexPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
