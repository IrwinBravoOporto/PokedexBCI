//
//  GradientView.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//
import UIKit

class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func setGradient(for type: String) {
        let colors = PokemonTypeColors.colors(for: type)
        gradientLayer.colors = colors.map { $0.cgColor }
    }
    
    private func setupGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
