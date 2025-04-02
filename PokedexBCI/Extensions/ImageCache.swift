//
//  ImageCache.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import UIKit

final class ImageCache {
    private let imageCache = NSCache<NSString, UIImage>()
    static let shared = ImageCache()
    private init() {}
}

extension ImageCache {
    static func load(url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let cachedImage = self.shared.imageCache.object(forKey: url.absoluteString as NSString) {
                completion(cachedImage)
            } else {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        self.shared.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        completion(image)
                    }
                }
            }
        }
    }
}
