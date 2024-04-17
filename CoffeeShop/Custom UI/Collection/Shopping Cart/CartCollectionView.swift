//
//  CartCollectionView.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import UIKit

protocol CartCollectionViewDelegate {
    func updatePrice()
}

class CartCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, CartCellDelegate{
    
    var delegateCart: CartCollectionViewDelegate?
    
    let layout = UICollectionViewFlowLayout()
    
    var cart: [CartItem] = []
    
    init() {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 353, height: 100)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .clear
        register(CartCollectionViewCell.self, forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
        dataSource = self
        delegate = self
    }
    
    func setCart(_ cart: [CartItem]) {
        self.cart = cart
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath) as? CartCollectionViewCell else {
            fatalError("Unable to dequeue CartCollectionViewCell.")
        }
        cell.delegate = self
        let item = cart[indexPath.row]
        cell.setup(with: item)
        
        return cell
    }
    
    func reachZero() {
        let indexPaths = indexPathsForVisibleItems
        for indexPath in indexPaths {
            guard let cell = cellForItem(at: indexPath) as? CartCollectionViewCell else { continue }
            if cell.stepper.value == 0 {
                let itemIndex = indexPath.row
                cart.remove(at: itemIndex)
                deleteItems(at: [indexPath])
                reloadData()
                break
            }
        }
    }


    func updatePrice() {
        delegateCart?.updatePrice()
    }
}
