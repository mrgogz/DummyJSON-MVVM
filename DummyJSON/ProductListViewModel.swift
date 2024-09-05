//
//  MainViewModel.swift
//  DummyJSON
//
//  Created by Oğuzcan Beşerikli on 4.09.2024.
//

import Foundation
import UIKit

class ProductListViewModel   {
    
    private var products: [Product] = []
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return products.count
    }
    
    func getProduct(at indexPath: IndexPath) -> Product {
        return products[indexPath.row]
    }
    
    func fetchProducts(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                self.products = try await NetworkManager.shared.getData()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        Task {
            let image = await NetworkManager.shared.downloadImage(from: urlString)
            completion(image)
        }
    }
    
}
