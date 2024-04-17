//
//  CoffeeShopCollectionViewCell.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import UIKit

class CoffeeShopCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CoffeeShopCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = AppColors.Orange
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = contentView.bounds
    }
    
    func setupLabel(with name: String) {
        nameLabel.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}
