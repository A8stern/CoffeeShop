//
//  TypesCollectionView.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//

import UIKit

protocol TypesCollectionViewDelegate: AnyObject {
    func didSelectType(_ type: TypeOfFood)
}

class TypesCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var typesDelegate: TypesCollectionViewDelegate?
    var types: [TypeOfFood] = []
    
    private var highlightedType: TypeOfFood?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        super.init(frame: .zero, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        register(TypesCollectionViewCell.self, forCellWithReuseIdentifier: TypesCollectionViewCell.identifier)
    }
    
    func setTypes(_ types: [TypeOfFood]) {
        self.types = types
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: TypesCollectionViewCell.identifier, for: indexPath) as? TypesCollectionViewCell else {
            fatalError("Unable to dequeue TypesCollectionViewCell.")
        }
        let type = types[indexPath.row]
        cell.configure(with: type.name)
        
        cell.contentView.backgroundColor = (type == highlightedType) ? AppColors.Brown : AppColors.Orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedType = types[indexPath.row]
        typesDelegate?.didSelectType(selectedType)
    }
    
    func highlightType(_ type: TypeOfFood) {
        highlightedType = type
        reloadData()
    }

    func scrollToType(_ type: TypeOfFood) {
        if let index = types.firstIndex(of: type) {
            let indexPath = IndexPath(item: index, section: 0)
            scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
