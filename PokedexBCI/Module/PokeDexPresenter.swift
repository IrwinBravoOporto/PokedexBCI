//
//  PokeDexPresenter.swift
//  PokedexBCI
//
//  Created Irwin Bravo Oporto on 1/04/25.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Nishi
//

import UIKit

class PokeDexPresenter {
    weak private var view: PokeDexViewProtocol?
    var interactor: PokeDexInteractorInputProtocol?
    private let router: PokeDexWireframeProtocol

    init(interface: PokeDexViewProtocol, interactor: PokeDexInteractorInputProtocol?, router: PokeDexWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

extension PokeDexPresenter: PokeDexPresenterProtocol {
    
    func viewDidLoad() {
        view?.playBackgroundAnimation()
    }
}

extension PokeDexPresenter: PokeDexInteractorOutputProtocol {
    
}
