//
//  ProductDetailVC.swift
//  DummyJSON
//
//  Created by Oğuzcan Beşerikli on 26.08.2024.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    private var productImageView = UIImageView()
    private var productName = UILabel()
    private var priceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    func set(product: Product) {
        downloadImage(fromURL: product.thumbnail)
        productName.text = product.title
        priceLabel.text = "\(product.price)"
    }
    
    private func downloadImage(fromURL url: String) {
        Task {
            if let downloadedImage = await NetworkManager.shared.downloadImage(from: url) {
                self.productImageView.image = downloadedImage
            }
        }
    }
    
    private func configureUI() {
        view.addSubview(productImageView)
        view.addSubview(productName)
        view.addSubview(priceLabel)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 250),
            productImageView.widthAnchor.constraint(equalToConstant: 250),
            
            productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 35),
            productName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 15),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
