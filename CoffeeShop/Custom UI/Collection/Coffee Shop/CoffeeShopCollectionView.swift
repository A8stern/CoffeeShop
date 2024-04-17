//
//  CoffeeShopCollectionViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import UIKit

protocol CoffeeShopCollectionViewDelegate: AnyObject {
    func didSelectShop(_ shop: CoffeeShop)
}

class CoffeeShopCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var coffeeDelegate: CoffeeShopCollectionViewDelegate?
    
    let layout = UICollectionViewFlowLayout()
    
    var coffeeShops: [CoffeeShop] = []
    
    private var highlightedType: CoffeeShop?

    init() {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 353, height: 80)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .clear
        register(CoffeeShopCollectionViewCell.self, forCellWithReuseIdentifier: CoffeeShopCollectionViewCell.identifier)
        dataSource = self
        delegate = self
    }
    
    func setCoffeeShops(_ coffeeShops: [CoffeeShop]) {
        self.coffeeShops = coffeeShops
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CoffeeShopCollectionViewCell.identifier, for: indexPath) as? CoffeeShopCollectionViewCell else {
            fatalError("Unable to dequeue CoffeeShopCollectionViewCell.")
        }
        let shop = coffeeShops[indexPath.row]
        cell.setupLabel(with: shop.adressName ?? "")
        
        cell.contentView.backgroundColor = (shop == highlightedType) ? AppColors.Brown : AppColors.Orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedShop = coffeeShops[indexPath.row]
        coffeeDelegate?.didSelectShop(selectedShop)
        highlightType(selectedShop)
    }
    
    private func highlightType(_ shop: CoffeeShop) {
        highlightedType = shop
        reloadData()
    }
}
