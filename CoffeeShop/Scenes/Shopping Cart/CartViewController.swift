//
//  CartViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import UIKit
import SnapKit

class CartViewController: UIViewController, CartCollectionViewDelegate {
    var presenter: CartPresenter?
    
    var cartCollectionView = CartCollectionView()
    
    var buyButton: BigButton = {
        var button = BigButton()
        button.setTitle("Buy", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        print("Initializing")
        view.backgroundColor = AppColors.LightGrey
        [buyButton, cartCollectionView].forEach {  view.addSubview($0) }
        cartCollectionView.delegateCart = self
        makeConstrains()
        setupActions()
    }
    
    private func makeConstrains() {
        print("Made constrains")
        cartCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(80)
        }
        buyButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        buyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupCollection(with cart: [CartItem]) {
        cartCollectionView.setCart(cart)
    }
    
    func setupButton(with price: Double) {
        buyButton.setTitle("Total price: \(price)$", for: .normal)
    }
    
    func updatePrice() {
        presenter?.updatePrice()
    }
    
    @objc func buttonTapped() {
        presenter?.makeOrder()
    }
}
