//
//  PokemonDetailViewController.swift
//  PokedexBCI
//
//  Created Irwin Bravo Oporto on 2/04/25.
//  Template generated by Nishi
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var presenter: PokemonDetailPresenterProtocol?
    let mainView = PokemonDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        presenter?.viewDidLoad()
    }
}

extension PokemonDetailViewController: PokemonDetailViewProtocol {
    func showPokemonDetail(_ detail: PokemonDetail) {
        DispatchQueue.main.async {
            self.mainView.configure(with: detail)
            self.title = detail.name.capitalized
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.mainView.loadingIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.mainView.loadingIndicator.stopAnimating()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
