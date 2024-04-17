//
//  ShopViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation
import UIKit
import SnapKit

class ShopViewController: UIViewController, TypesCollectionViewDelegate {
    var presenter: ShopPresenter?
    
    var orderLabel = MainScreenLabel()
    
    lazy var typesCollectionView: TypesCollectionView = TypesCollectionView()
    
    lazy var itemsCollectionView: ItemsCollectionView = {
        let collectionView = ItemsCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var registerButton: BigButton = {
        var registerButton = BigButton()
        registerButton.setTitle("Buy", for: .normal)
        return registerButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsCollectionView.reloadData()
        presenter?.updatePrice()
    }
    
    private func initialize() {
        view.backgroundColor = AppColors.LightGrey
        orderLabel.textColor = AppColors.Brown
        
        [orderLabel, typesCollectionView, itemsCollectionView, registerButton].forEach {  view.addSubview($0) }
        makeConstrains()
        setupActions()
        setupDelegates()
    }

    
    private func makeConstrains() {
        print("Made constrains")
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().inset(30)
            make.width.equalTo(250)
            make.height.equalTo(120)
        }
        typesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(2)
            make.height.equalTo(40)
        }
        itemsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(typesCollectionView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }

        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(60)
        }
    }
    
    private func setupActions() {
        registerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupDelegates() {
        typesCollectionView.typesDelegate = self
        itemsCollectionView.itemsDelegate = self
    }
    
    func didSelectType(_ type: TypeOfFood) {
        itemsCollectionView.scrollToSection(for: type)
    }
    
    @objc private func buttonTapped() {
        print("Tapped")
        animateButtonTap()
        presenter?.buttonTapped()
    }
    
    private func animateButtonTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.registerButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                    self.registerButton.transform = CGAffineTransform.identity
            }
        }
    }
    
    func typesSetValues(with typesData: [TypeOfFood]) {
        typesCollectionView.setTypes(typesData)
    }
    
    func itemsSetValues(with typesData: [TypeOfFood], items: [Item]) {
        itemsCollectionView.configureWithItems(items, andTypes: typesData)
    }
    
    func buttonSetPrice(with price: Double) {
        if price == 0 {
            hideRegisterButton()
        } else {
            registerButton.setTitle("Total price: \(price)$", for: .normal)
                showRegisterButton()
        }
    }
        
    private func showRegisterButton() {
        if registerButton.isHidden {
            self.view.layoutIfNeeded()
                
            registerButton.isHidden = false
            registerButton.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.registerButton.alpha = 1
            }
        }
    }
        
    private func hideRegisterButton() {
        UIView.animate(withDuration: 0.2, animations: {
            self.registerButton.alpha = 0
        }) { _ in
            self.registerButton.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    func showErrorMessage(_ message: String) {
        print("Error: \(message)")
    }
}

extension ShopViewController: ItemsCollectionViewDelegate {
    func updatePrice() {
        presenter?.updatePrice()
    }
    
    func didSelectItem(_ item: Item) {
        print(item)
        presenter?.toItemVC(with: item)
    }
    
    func didScrollToSection(_ section: Int) {
        guard section < typesCollectionView.types.count else { return }
        let selectedType = typesCollectionView.types[section]
        typesCollectionView.highlightType(selectedType)
        typesCollectionView.scrollToType(selectedType)
    }
}


