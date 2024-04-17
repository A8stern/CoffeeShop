//
//  TypesCollectionView.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//

import UIKit

class TypesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TypesCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.LightGrey
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
    
    public func configure(with name: String) {
        nameLabel.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}
