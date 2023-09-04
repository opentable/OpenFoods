//
//  Extensions.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

extension UIImageView {

    func load(url: URL,
              placeholder: UIImage? = UIImage(named: "placeholder"),
              cache: URLCache = .shared) {
        let request = URLRequest(url: url)

        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            self.image = placeholder

            URLSession.shared.dataTask(with: request) { [weak self] (data, response, _) in
                guard let data = data,
                        let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode,
                        let image = UIImage(data: data) else { return }

                let cachedData = CachedURLResponse(response: httpResponse, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }.resume()
        }
    }
}
