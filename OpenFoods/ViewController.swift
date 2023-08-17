//
//  ViewController.swift
//  OpenFoods
//
//  Created by Oliver Kirkland on 16/08/23.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView?
    
    struct Constants {
        static let interItemSpacing = 8.0
        static let edgeSpacing = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }
    
    private let repo = Respository()
    private var food: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidesWhenStopped = true
        self.collectionView?.dataSource = self
        self.collectionView?.register(UINib(nibName: String(describing: OpenFoodCell.self), bundle: Bundle(for: OpenFoodCell.self)), forCellWithReuseIdentifier: String(describing: OpenFoodCell.self))
        self.loadFood()
    }
    
    private func loadFood() {
        self.activityIndicator.startAnimating()
        self.repo.fetchFoods() { result in
            switch result {
            case .success(let food):
                self.food = food
                self.setLayout()
            case .failure(let error):
                self.activityIndicator.stopAnimating()
                self.presentError(error: error)
                
            }
        }
    }
    
    private func setLayout() {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(158)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(CGFloat(158 * self.food.count))), subitems: Array(repeating: item, count: self.food.count))
        group.interItemSpacing = .fixed(Constants.interItemSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.edgeSpacing
        let compLayout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = compLayout
        self.collectionView?.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    private func likeFood(like: Bool, _ id: Int, cell: OpenFoodCell?) {
        if like {
            self.repo.likeFood(id: id) { result in
                switch result {
                case .success:
                    cell?.toggleLike(like: true)
                case .failure(let failure):
                    self.presentError(error: failure)
                }
            }
        } else {
            self.repo.dislikeFood(id: id) { result in
                switch result {
                case .success:
                    cell?.toggleLike(like: false)
                case .failure(let failure):
                    self.presentError(error: failure)
                }
            }
        }
    }
    
    private func presentError(error: Error) {
        print(error.localizedDescription)
        let title = NSLocalizedString("Uh Oh!", comment: "Loading error title")
        let message = NSLocalizedString("It looks like something has gone wrong. Please try again later.", comment: "Loading error message")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.food.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OpenFoodCell.self), for: indexPath) as? OpenFoodCell
        if indexPath.row < self.food.count {
            let food = self.food[indexPath.row]
            cell?.setup(food: food)
            cell?.likeTapped = { like in
                self.likeFood(like: like, food.id, cell: cell)
            }
            self.repo.downloadImage(url: food.photoURL) { result in
                switch result {
                case .success(let image):
                    cell?.imageView?.image = image
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        return cell ?? UICollectionViewCell()
    }
}
