//
//  HomeVC.swift
//  DummyJSON
//
//  Created by Oğuzcan Beşerikli on 26.08.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    var tableView: UITableView!
    var products: [Product] = []
    var viewModel = ProductListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        fetchProduct()
    }
    
     func configureTableView() {
        tableView = UITableView()
        setupTableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchProduct() {
        viewModel.fetchProducts { [weak self] result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch products: \(error.localizedDescription)")
            }
        }
    }
}
