//
//  PokemonTypeColors.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import UIKit

struct PokemonTypeColors {
    /// Devuelve el color principal para un tipo de Pokémon
    static func color(for type: String) -> UIColor {
        return colors[type.lowercased()]?.primary ?? .systemGray
    }
    
    /// Devuelve los colores del gradiente para un tipo de Pokémon
    static func colors(for type: String) -> [UIColor] {
        let typeKey = type.lowercased()
        guard let typeColors = colors[typeKey] else { return [.systemGray, .systemGray2] }
        return [typeColors.primary, typeColors.secondary]
    }
    
    private static let colors: [String: (primary: UIColor, secondary: UIColor)] = [
        "normal":   (UIColor(hex: "#A8A878"), UIColor(hex: "#C6C6A7")),
        "fire":     (UIColor(hex: "#F08030"), UIColor(hex: "#F5AC78")),
        "water":    (UIColor(hex: "#6890F0"), UIColor(hex: "#9DB7F5")),
        "electric": (UIColor(hex: "#F8D030"), UIColor(hex: "#FAE078")),
        "grass":    (UIColor(hex: "#78C850"), UIColor(hex: "#A7DB8D")),
        "ice":      (UIColor(hex: "#98D8D8"), UIColor(hex: "#BCE6E6")),
        "fighting": (UIColor(hex: "#C03028"), UIColor(hex: "#D67873")),
        "poison":   (UIColor(hex: "#A040A0"), UIColor(hex: "#C183C1")),
        "ground":   (UIColor(hex: "#E0C068"), UIColor(hex: "#EBD69D")),
        "flying":   (UIColor(hex: "#A890F0"), UIColor(hex: "#C6B7F5")),
        "psychic":  (UIColor(hex: "#F85888"), UIColor(hex: "#FA92B2")),
        "bug":      (UIColor(hex: "#A8B820"), UIColor(hex: "#C6D16E")),
        "rock":     (UIColor(hex: "#B8A038"), UIColor(hex: "#D1C17D")),
        "ghost":    (UIColor(hex: "#705898"), UIColor(hex: "#A292BC")),
        "dragon":   (UIColor(hex: "#7038F8"), UIColor(hex: "#A27DFA")),
        "dark":     (UIColor(hex: "#705848"), UIColor(hex: "#A29288")),
        "steel":    (UIColor(hex: "#B8B8D0"), UIColor(hex: "#D1D1E0")),
        "fairy":    (UIColor(hex: "#EE99AC"), UIColor(hex: "#F4BDC9"))
    ]
}
