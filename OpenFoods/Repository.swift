//
//  Repository.swift
//  OpenFoods
//
//  Created by Gabriella Aguilar on 17/08/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation

final class Respository {
    private let url = URL(string: "https://opentable-dex-ios-test-d645a49e3287.herokuapp.com/api/v1/food")
    
    public func fetchFoods(completion: @escaping (Result<[Food], Error>) -> Void) {
        guard let url = self.url else {
            completion(.failure(NSError()))
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let food = try decoder.decode([Food].self, from: data)
                    completion(.success(food))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError()))
            }
        }
        task.resume()
    }
}
