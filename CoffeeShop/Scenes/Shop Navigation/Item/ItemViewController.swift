//
//  ItemViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import UIKit
import SnapKit

class ItemViewController: UIViewController {
    var presenter: ItemPresenter?
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = AppColors.Black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "price"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AppColors.Brown
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "description"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = AppColors.Black
        return label
    }()
    
    private let addToCartButton = CartButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        print("Initializing")
        view.backgroundColor = AppColors.LightGrey
        [itemImageView, titleLabel, priceLabel,
         descriptionLabel, addToCartButton].forEach {  view.addSubview($0) }
        makeConstrains()
        
    }
    
    private func makeConstrains() {
        let sidePadding: CGFloat = 20
        let elementSpacing: CGFloat = 16

        itemImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 250))
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(elementSpacing)
            make.leading.trailing.equalToSuperview().inset(sidePadding)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(elementSpacing)
            make.leading.trailing.equalToSuperview().inset(sidePadding)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(elementSpacing)
            make.leading.trailing.equalToSuperview().inset(sidePadding)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(elementSpacing)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-elementSpacing)
        }
    }
    
    func setupUI(with item: Item) {
        //itemImageView.image = UIImage(systemName: item.imageName)
        titleLabel.text = item.name
        priceLabel.text = "\(item.price)$"
        descriptionLabel.text = item.description
        addToCartButton.setupItem(with: item)
    }
    
}



