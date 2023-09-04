//
//  MockObjects.swift
//  AppTests
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation
@testable import Poppify
@testable import OpenFoods

// MARK: - Mock Environment
extension Environment {
    static var mock = Environment(scheme: .unsecure,
                                  endpoint: "endpoint",
                                  additionalHeaders: [:],
                                  port: nil,
                                  secret: nil)
}

// MARK: - Mock Task
final class MockTask: URLSessionTaskType {
    
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        closure()
    }
}

class MockResponse {

    static func create(withCode code: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "www.google.com")!,
                               statusCode: code,
                               httpVersion: nil,
                               headerFields: nil)!
    }

    static func create() -> URLResponse {
        return URLResponse(url: URL(string: "www.google.com")!,
                           mimeType: nil,
                           expectedContentLength: 1,
                           textEncodingName: nil)
    }

}

// MARK: - Mock URLSession
final class MockURLSession: URLSessionType {

    var data: Data?
    var response: URLResponse?
    var error: Error?

    func dataTask(with request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskType {
        return MockTask {
            completion(self.data, self.response, self.error)
        }
    }

    func sendRequest(for request: URLRequest) async throws -> (Data, URLResponse) {
        return (data!, response!)
    }
}

// MARK: - Mock Client
enum State {
    case error(RequestError)
    case data
}

final class MockClient<T: Decodable>: Client {

    var state: State = .data
    var item: T!
    var environment: EnvironmentType = Environment.mock
    let urlSession: URLSessionType = MockURLSession()

    func executeRequest<T>(with resource: Resource<T>, completion: @escaping (Result<T, RequestError>) -> Void) -> URLSessionTaskType? where T : Decodable {
        
        switch state {
        case .error(let requestError):
            return MockTask{ completion(.failure(requestError)) }
        case .data:
            let coded = try! resource.decode(mockData)
            return MockTask{ completion(.success(coded)) }
        }
        
    }
    
    private var mockData: Data {
        """
        [
          {
            "id": 0,
            "name": "Pasta",
            "isLiked": false,
            "photoURL": "https://opentable-dex-ios-test-d645a49e3287.herokuapp.com/images/pasta.jpeg",
            "description": "Pasta is a type of food typically made from an unleavened dough of wheat flour mixed with water or eggs, and formed into sheets or other shapes, then cooked by boiling or baking. Rice flour, or legumes such as beans or lentils, are sometimes used in place of wheat flour to yield a different taste and texture, or as a gluten-free alternative. Pasta is a staple food of Italian 🇮🇹 cuisine.",
            "countryOfOrigin": "IT",
            "lastUpdatedDate": "2023-08-31T18:37:02Z"
          }
        ]
        """.data(using: .utf8)!
    }
    
}

// MARK: - Mock Generator
extension Int {
    
    var mockFoodItems: [FoodListItem] {
        return Array(0..<self).map {
            FoodListItem(id: $0,
                         name: String(describing: $0),
                         isLiked: true,
                         photoURL: URL(string: "apple.com")!,
                         description: "Ipsum Loerem",
                         countryOfOrigin: "GB",
                         lastUpdatedDate: .now)
        }
    }
    
}
