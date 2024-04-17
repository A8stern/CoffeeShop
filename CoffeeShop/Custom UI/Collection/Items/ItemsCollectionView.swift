//
//  ItemsTableView.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//
// ItemsCollectionView.swift

import UIKit

protocol ItemsCollectionViewDelegate: AnyObject {
    func didScrollToSection(_ section: Int)
    func didSelectItem(_ item: Item)
    func updatePrice()
}

class ItemsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ItemsCellDelegate {
    
    weak var itemsDelegate: ItemsCollectionViewDelegate?
    
    let layout = UICollectionViewFlowLayout()
    
    var itemsByType: [TypeOfFood: [Item]] = [:]
    var types: [TypeOfFood] = []
    
    init() {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        super.init(frame: .zero, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: ItemsCollectionViewCell.identifier)
    }
    
    func configureWithItems(_ items: [Item], andTypes types: [TypeOfFood]) {
        itemsByType.removeAll()

        for type in types {
            itemsByType[type] = items.filter { $0.type == type }
        }
        
        self.types = types
        reloadData()
    }
    
    // MARK: - DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = types[section]
        return itemsByType[type]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCollectionViewCell.identifier, for: indexPath) as? ItemsCollectionViewCell,
              let type = types[safe: indexPath.section],
              let item = itemsByType[type]?[safe: indexPath.row] else {
            fatalError("Unable to dequeue ItemsCollectionViewCell or Item not found.")
        }
        cell.delegate = self
        cell.configure(with: item)
        return cell
    }
    
    // MARK: - DelegateSelectItem
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = types[safe: indexPath.section],
              let item = itemsByType[type]?[safe: indexPath.row] else {
            fatalError("Unable to get selected item.")
        }
        itemsDelegate?.didSelectItem(item)
    }
    
    // MARK: - DelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - layout.sectionInset.left - layout.sectionInset.right
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
    
    func scrollToSection(for type: TypeOfFood) {
        guard let section = types.firstIndex(of: type) else { return }
        let indexPath = IndexPath(item: 0, section: section)
        scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    private subscript (safe index: Int) -> TypeOfFood? {
        return types.indices.contains(index) ? types[index] : nil
    }
    
    // MARK: - CellDelgate
    
    func updatePrice() {
        itemsDelegate?.updatePrice()
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension ItemsCollectionView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.minY)
        if let visibleIndexPath = self.indexPathForItem(at: visiblePoint) {
            itemsDelegate?.didScrollToSection(visibleIndexPath.section)
        }
    }
}

