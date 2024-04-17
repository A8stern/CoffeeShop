//
//  CartButton.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import UIKit
import SnapKit

protocol CartButtonDelegate {
    func updatePrice()
}

class CartButton: UIButton, CartCounterViewDelegate {
    
    var delegate: CartButtonDelegate?
    
    var item: Item?
    
    var itemCount: Int = 0 {
        didSet {
            counterView.itemCount = itemCount
        }
    }
    var isInCart: Bool = false {
        didSet {
            counterView.isInCart = isInCart
        }
    }
    
    private let counterView = CartCounterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func setupItem(with item: Item) {
        self.item = item
        if (CartDataHandler.shared.isItemInCart(item: item)) {
            isInCart = true
            itemCount = CartDataHandler.shared.getItemQuantity(item: item)
        } else {
            isInCart = false
            itemCount = 0
        }
        updateCounterView()
    }
    
    private func commonInit() {
        setupActions()
        setupCounterView()
        styleButton()
    }
    
    private func setupCounterView() {
        counterView.delegate = self
        addSubview(counterView)
        counterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        counterView.isHidden = true
    }
    
    private func setupActions() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func styleButton() {
        backgroundColor = AppColors.Green
        setTitleColor(AppColors.Black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    private func updateCounterView() {
        counterView.item = item
        counterView.itemCount = itemCount
        counterView.isInCart = isInCart
        counterView.isHidden = !isInCart || itemCount == 0
        setTitle(isInCart ? "" : "Add to cart", for: .normal)
    }
    
    @objc private func buttonTapped() {
        print("Tapped")
        guard let currItem = item else { return }
        counterView.isHidden = false
        guard item != nil else { return }
        itemCount += 1
        isInCart = true
        CartDataHandler.shared.addItemToCart(item: currItem)
        updateCounterView()
        delegate?.updatePrice()
    }
    
    func cartCounterViewAddOneItemCount() {
        itemCount += 1
        CartDataHandler.shared.updateItemQuantity(item: item!, quantity: itemCount)
        updateCounterView()
        delegate?.updatePrice()
    }
    
    func cartCounterViewMinusOneItemCount() {
        itemCount -= 1
        CartDataHandler.shared.updateItemQuantity(item: item!, quantity: itemCount)
        updateCounterView()
        delegate?.updatePrice()
    }
    
    func cartCounterViewDidReachZeroItemCount() {
        itemCount -= 1
        isInCart = false
        CartDataHandler.shared.removeItemFromCart(item: item!)
        updateCounterView()
        delegate?.updatePrice()
    }
}
