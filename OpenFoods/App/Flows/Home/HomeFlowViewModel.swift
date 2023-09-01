//
//  HomeFlowViewModel.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation
import Poppify

struct FoodListRequest: Requestable {
    let path = "/api/v1/arezanov/food"
}

final class HomeFlowViewModel {
    
    @Inject(\.clientProvider) var client: Client
    
    private var foodItems: [FoodListItem]
    weak var coodinator: HomeFlowCoordinator?
        
    init(foodItems: [FoodListItem] = [], coodinator: HomeFlowCoordinator? = nil) {
        self.foodItems = foodItems
        self.coodinator = coodinator
    }
    
    var numberOfSections: Int {
        foodItems.isEmpty ? 0 : 1
    }

    func numberOfItems(in section: Int) -> Int {
        if section < 0 || section >= numberOfSections { return 0 }
        return foodItems.count
    }

    func item(at indexPath: IndexPath) -> FoodListItem? {
        if indexPath.row < 0 || indexPath.row >= numberOfItems(in: indexPath.section) { return nil }
        return foodItems[indexPath.row]
    }

//    func cellViewModel(at indexPath: IndexPath) -> ArticleCellViewModel? {
//        guard let article = article(at: indexPath) else { return nil }
//        return ArticleCellViewModel(article)
//    }

    func update(completion: @escaping () -> Void) {

        let resource = Resource<[FoodListItem]>(request: FoodListRequest())
        
        let task = client.executeRequest(with: resource) { [unowned self] result in
            switch result {
            case .success(let items):
                self.foodItems = items
            case .failure(let error):
                print(error)
            }
            completion()
        }
        
        task?.resume()
    }
    
}
