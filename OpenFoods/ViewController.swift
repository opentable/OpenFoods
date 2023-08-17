//
//  ViewController.swift
//  OpenFoods
//
//  Created by Oliver Kirkland on 16/08/23.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView?
    
    struct Constants {
        static let interItemSpacing = 8.0
        static let edgeSpacing = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }
    
    private let repo = Respository()
    private var food: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(UINib(nibName: String(describing: OpenFoodCell.self), bundle: Bundle(for: OpenFoodCell.self)), forCellWithReuseIdentifier: String(describing: OpenFoodCell.self))
        self.loadFood()
    }
    
    private func loadFood() {
        self.repo.fetchFoods() { result in
            switch result {
            case .success(let food):
                self.food = food
                print("yay")
               // self.setLayout()
            case .failure(let error):
                print(error.localizedDescription)
                /*let title = NSLocalizedString("Uh Oh!", comment: "Loading error title")
                let message = NSLocalizedString("It looks like something has gone wrong. Please try again later.", comment: "Loading error message")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                self.present(alert, animated: true)*/
            }
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.loadFood()
    }
    
    private func setLayout() {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: Array(repeating: item, count: self.food.count))
        group.interItemSpacing = .fixed(Constants.interItemSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.edgeSpacing
        let compLayout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = compLayout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.food.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OpenFoodCell.self), for: indexPath) as? OpenFoodCell
        if indexPath.row < self.food.count {
            cell?.setup(food: self.food[indexPath.row])
        }
        return cell ?? UICollectionViewCell()
    }
}
