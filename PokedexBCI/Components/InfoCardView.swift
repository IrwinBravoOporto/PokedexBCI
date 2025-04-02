//
//  InfoCardView.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import UIKit

class InfoCardView: UIView {
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(height: String, weight: String, experience: String) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let heightItem = InfoItemView()
        heightItem.configure(title: "Height", value: height, icon: UIImage())
        
        let weightItem = InfoItemView()
        weightItem.configure(title: "Weight", value: weight, icon: UIImage())
        
        let expItem = InfoItemView()
        expItem.configure(title: "Experience", value: experience, icon: UIImage())
        
        stackView.addArrangedSubview(heightItem)
        stackView.addArrangedSubview(weightItem)
        stackView.addArrangedSubview(expItem)
    }
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        
        titleLabel.text = "About"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
