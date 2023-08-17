//
//  Repository.swift
//  OpenFoods
//
//  Created by Gabriella Aguilar on 17/08/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

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
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            } else if let data = data {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let food = try decoder.decode([Food].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(food))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
    
    public func downloadImage(url: URL?, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            } else if let data = data {
                let image =  UIImage(data: data)
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
    
    public func likeFood(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://opentable-dex-ios-test-d645a49e3287.herokuapp.com/api/v1/food/\(id)/like") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            } else if let data = data {
                let image =  UIImage(data: data)
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
    
    public func dislikeFood(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://opentable-dex-ios-test-d645a49e3287.herokuapp.com/api/v1/food/\(id)/unlike") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            } else if let data = data {
                let image =  UIImage(data: data)
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
}
