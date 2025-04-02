//
//  StatCell.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import UIKit

class StatCell: UITableViewCell {
    
    // MARK: - Components
    private let statNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let statValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.textColor = .label
        return label
    }()
    
    private let statProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .systemGray5
        progressView.progressTintColor = .systemGreen
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        return progressView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        selectionStyle = .none
        
        contentView.addSubview(statNameLabel)
        contentView.addSubview(statValueLabel)
        contentView.addSubview(statProgressView)
        
        statNameLabel.translatesAutoresizingMaskIntoConstraints = false
        statValueLabel.translatesAutoresizingMaskIntoConstraints = false
        statProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statNameLabel.widthAnchor.constraint(equalToConstant: 100),

            statValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statValueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            statProgressView.leadingAnchor.constraint(equalTo: statNameLabel.trailingAnchor, constant: 12),
            statProgressView.trailingAnchor.constraint(equalTo: statValueLabel.leadingAnchor, constant: -12),
            statProgressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statProgressView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    // MARK: - Configuration
    func configure(with stat: PokemonDetail.Stat) {
        statNameLabel.text = stat.stat.name.capitalized
        statValueLabel.text = "\(stat.baseStat)"
        
        let maxStatValue: Float = 200
        let progress = Float(stat.baseStat) / maxStatValue
        statProgressView.setProgress(progress, animated: true)
    }
}
