//
//  HomeVC+TableView.swift
//  DummyJSON
//
//  Created by Oğuzcan Beşerikli on 4.09.2024.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 80
        
        registerCells()
    }
    
    func registerCells() {
        tableView.register(ViewCell.self, forCellReuseIdentifier: ViewCell.reuseID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewCell.reuseID, for: indexPath)
        return cell
    }
    
}
