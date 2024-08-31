//
//  HomeVC.swift
//  DummyJSON
//
//  Created by Oğuzcan Beşerikli on 26.08.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    private var tableView: UITableView!
    private var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        Task { await getData() }
    }
    
    private func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ViewCell.self, forCellReuseIdentifier: ViewCell.reuseID)
        tableView.rowHeight = 80
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getData() async {
        do {
            let products = try await NetworkManager.shared.getData()
            self.products.append(contentsOf: products)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewCell.reuseID, for: indexPath) as! ViewCell
        cell.set(product: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        let vc = ProductDetailVC()
        vc.set(product: selectedProduct)
        navigationController?.pushViewController(vc, animated: true)
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}
