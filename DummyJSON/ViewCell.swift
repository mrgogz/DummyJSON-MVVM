//
//  ViewCell.swift
//  DummyJSON
//
//  Created by Oğuzcan Beşerikli on 26.08.2024.
//

import UIKit

class ViewCell: UITableViewCell {
    
    static let reuseID = "ViewCell"
    private var productImageView = UIImageView()
    private var productName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(product: Product) {
        downloadImage(fromURL: product.thumbnail)
        productName.text = product.title
    }
    
    private func downloadImage(fromURL url: String) {
        Task {
            if let downloadedImage = await NetworkManager.shared.downloadImage(from: url) {
                self.productImageView.image = downloadedImage
            }
        }
    }
    
    private func configureCell() {
        addSubview(productImageView)
        addSubview(productName)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 65),
            productImageView.widthAnchor.constraint(equalToConstant: 65),
            
            productName.centerYAnchor.constraint(equalTo: centerYAnchor),
            productName.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 7),
            productName.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        productName.textAlignment = .left
        productName.lineBreakMode = .byTruncatingTail
    }
}
