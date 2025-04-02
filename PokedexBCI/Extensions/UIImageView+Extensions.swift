//
//  UIImageView+Extensions.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 1/04/25.
//

import UIKit

extension UIImageView {
    func load(url: URL, placeholder: UIImage? = nil) {
        // Mostrar placeholder mientras carga
        self.image = placeholder ?? UIImage(named: "pokemon_placeholder")
        
        // Usar caché de URLSession
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: config)
        
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
