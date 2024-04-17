//
//  CartCollectionViewCell.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import UIKit

protocol CartCellDelegate {
    func reachZero()
    func updatePrice()
}

class CartCollectionViewCell: UICollectionViewCell {
    var delegate: CartCellDelegate?
    
    static let identifier = "CartCollectionViewCell"
    
    var item: CartItem?
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = AppColors.LightGrey
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AppColors.LightGrey
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.LightGrey
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
        
    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.value = 0
        return stepper
    }()
    
    var quantityChanged: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [itemImageView, nameLabel, priceLabel,
        quantityLabel, stepper].forEach {contentView.addSubview($0)}
        
        contentView.backgroundColor = AppColors.Orange
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let edgePadding: CGFloat = 16
        let interElementSpacing: CGFloat = 8

        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(edgePadding)
            make.left.equalToSuperview().offset(edgePadding)
            make.size.equalTo(CGSize(width: 90, height: 60))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(itemImageView.snp.centerY)
            make.left.equalTo(itemImageView.snp.right).offset(interElementSpacing)
            make.width.equalTo(110)
        }
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(itemImageView.snp.centerY)
            make.right.equalTo(stepper.snp.left).offset(-interElementSpacing)
        }
        stepper.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview().inset(edgePadding)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom)
            make.left.equalToSuperview().offset(edgePadding)
            make.right.equalTo(stepper.snp.right)
        }
    }
    
    private func setupActions() {
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    func setup(with cartItem: CartItem) {
        item = cartItem
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = item!.item.name
        priceLabel.text = item!.item.price
        quantityLabel.text = "\(item!.quantity)"
        stepper.value = Double(item!.quantity)
    }
    
    @objc private func stepperValueChanged(_ stepper: UIStepper) {
        let newValue = Int(stepper.value)
        guard let oldValue = Int(quantityLabel.text ?? "0") else { return }
        
        if (newValue > oldValue) {
            cartAddOneItemCount()
        } else {
            if (newValue == 0) {
                cartDidReachZeroItemCount()
                return
            } else {
                cartMinusOneItemCount()
            }
        }
        quantityLabel.text = "\(newValue)"
        quantityChanged?(newValue)
    }
    
    private func cartAddOneItemCount() {
        CartDataHandler.shared.updateItemQuantity(item: item!.item, quantity: Int(stepper.value))
        delegate?.updatePrice()
    }
    
    func cartMinusOneItemCount() {
        CartDataHandler.shared.updateItemQuantity(item: item!.item, quantity: Int(stepper.value))
        delegate?.updatePrice()
    }
    
    func cartDidReachZeroItemCount() {
        guard let item = item else { return }
        CartDataHandler.shared.removeItemFromCart(item: item.item)
        delegate?.reachZero()
        delegate?.updatePrice()
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}
