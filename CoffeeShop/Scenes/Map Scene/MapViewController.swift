//
//  MapViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 30.03.2024.
//

import UIKit
import YandexMapsMobile
import SnapKit

class MapViewController: UIViewController,
        CoffeeShopCollectionViewDelegate {
    
    var presenter: MapPresenter?
    
    var mapView = CoffeeShopsMap()
    
    var coffeeShopCollection = CoffeeShopCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = AppColors.LightGrey
        coffeeShopCollection.coffeeDelegate = self
        [mapView, coffeeShopCollection].forEach {  view.addSubview($0) }
        setupLayout()
    }
    
    private func setupLayout() {
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }
        coffeeShopCollection.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    func setupPlacemarks(with coffeeShops: [CoffeeShop]) {
        coffeeShops.forEach {mapView.addPlacemark(latitude: $0.latitude ?? 0.0, longitude: $0.longtitude ?? 0.0)}
    }
    
    func didSelectShop(_ shop: CoffeeShop) {
        mapView.showLocation(latitude: shop.latitude ?? 0.0, longitude: shop.longtitude ?? 0.0)
    }
    
    func setupCollection(with coffeeShops: [CoffeeShop]) {
        coffeeShopCollection.setCoffeeShops(coffeeShops)
    }
}
