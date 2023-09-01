//
//  HomeTableViewController.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

class HomeTableViewController: UIViewController {
    
    var viewModel: HomeFlowViewModel!
    @IBOutlet private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        precondition(viewModel != nil, "You forgot to attach a ViewModel")

        view.accessibilityIdentifier = "homeScreen"
        navigationItem.title = "Food"

        tableView.register(cellType: FoodItemTableViewCell.self)
        tableView.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Food..")

        updateUI()
    }

    @objc func refreshData(_ sender: UIRefreshControl) {
        updateUI()
    }

    func updateUI() {
        viewModel.update { [unowned self] in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeTableViewController: UITableViewDataSource {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: FoodItemTableViewCell.self, for: indexPath)
        
        guard let cellItem = viewModel.item(at: indexPath) else { return cell }
        
        cell.mainTitle.text = "\(cellItem.name), \(cellItem.countryOfOrigin)"
        cell.mainDescription.text = cellItem.description
        cell.dateUpdated.text = "Last updated: \(viewModel.timeAgo(to: cellItem.lastUpdatedDate))"
        return cell
    }

}

extension HomeTableViewController: IBInstantiatable {}
