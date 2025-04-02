//
//  PokemonCollectionViewCell.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 1/04/25.
//

import UIKit

struct Pokemon {
    let name: String
    let imageUrl: String
    // Agregar más propiedades según necesidad
}

class PokemonCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PokemonCell"
    
    let pokeImage = UIImageView()
    let lblName = UILabel()
    let cardView = CardView() // Usamos tu CardView personalizada
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // Configuración de la celda transparente
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        
        
        // Mejor configuración de la imagen
        pokeImage.contentMode = .scaleAspectFit
        pokeImage.clipsToBounds = true
        pokeImage.backgroundColor = .clear
        pokeImage.layer.cornerRadius = 8
        
        // Mejor estilo para la etiqueta
        lblName.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lblName.textAlignment = .center
        lblName.textColor = .white
        lblName.numberOfLines = 2
        lblName.adjustsFontSizeToFitWidth = true
        lblName.minimumScaleFactor = 0.7
        
        // Jerarquía de vistas
        contentView.addSubview(cardView)
        cardView.addSubview(pokeImage)
        cardView.addSubview(lblName)
        
        // Constraints
        cardView.translatesAutoresizingMaskIntoConstraints = false
        pokeImage.translatesAutoresizingMaskIntoConstraints = false
        lblName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // CardView ocupa toda la celda con márgenes
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            // Imagen centrada
            pokeImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            pokeImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            pokeImage.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8),
            pokeImage.heightAnchor.constraint(equalTo: pokeImage.widthAnchor),
            
            // Etiqueta debajo de la imagen
            lblName.topAnchor.constraint(equalTo: pokeImage.bottomAnchor, constant: 4),
            lblName.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            lblName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
           
        ])
    }
    
    func configure(with pokemon: ResultPokeDex) {
        lblName.text = pokemon.name?.capitalized
        
        // Extraer el ID del Pokémon de la URL
        if let urlString = pokemon.url,
           let id = urlString.split(separator: "/").last {
            let imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
            
            if let url = URL(string: imageUrl) {
                pokeImage.load(url: url)
            }
        }
    }
}
