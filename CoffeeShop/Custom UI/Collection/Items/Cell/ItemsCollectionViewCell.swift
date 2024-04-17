//
//  ItemsTableCell.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//

import UIKit
import SnapKit

protocol ItemsCellDelegate {
    func updatePrice()
}

class ItemsCollectionViewCell: UICollectionViewCell, CartButtonDelegate {
    
    var delegate: ItemsCellDelegate?
    
    static let identifier = "ItemsCollectionViewCell"
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = AppColors.Black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = AppColors.Orange
        return label
    }()
    
    private let addToCartButton = CartButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [itemImageView, titleLabel, priceLabel, addToCartButton].forEach { contentView.addSubview($0) }
        
        addToCartButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        contentView.backgroundColor = AppColors.Brown
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        
        addToCartButton.delegate = self
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 5
        let bottomPadding: CGFloat = 25 // Reduced bottom padding for the button

        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.6)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(20)
            make.bottom.equalTo(priceLabel.snp.top).offset(-12)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(160)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
            make.right.lessThanOrEqualTo(addToCartButton.snp.left).offset(-16)
            make.left.equalToSuperview().inset(70)
        }
        
        addToCartButton.snp.makeConstraints { make in
            // Position the button a bit higher from the bottom
            make.bottom.equalToSuperview().offset(-30)
            make.trailing.equalToSuperview().offset(-30)
            // Set a fixed width and height for the button, or use content size
            // make.width.equalTo(someWidth)
            // make.height.equalTo(someHeight)
        }
    }



    
    public func configure(with item: Item) {
        //itemImageView.image = UIImage(systemName: item.imageName)
        titleLabel.text = item.name
        priceLabel.text = "\(item.price)$"
        addToCartButton.setupItem(with: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
    
    @objc func buttonTapped() {
        print("Add to cart")
    }
    
    func updatePrice() {
        delegate?.updatePrice()
    }
}

