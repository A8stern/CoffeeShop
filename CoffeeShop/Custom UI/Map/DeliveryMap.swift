//
//  DeliveryMap.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import UIKit
import YandexMapsMobile

protocol DeliveryMapDelegate: AnyObject {
    func didTapOnMap(latitude: Double, longitude: Double)
}

class DeliveryMap: UIView, YMKMapInputListener {
    private var mapView: YMKMapView!
    weak var delegate: DeliveryMapDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMapView()
    }
    
    private func setupMapView() {
        mapView = YMKMapView(frame: self.bounds)
        mapView.layer.cornerRadius = 30
        mapView.clipsToBounds = true
        addSubview(mapView)
        
        let initialLocation = YMKPoint(latitude: 59.9359, longitude: 30.3259)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: initialLocation, zoom: 16, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
        
        mapView.mapWindow.map.addInputListener(with: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mapView.frame = self.bounds
    }
    
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        delegate?.didTapOnMap(latitude: point.latitude, longitude: point.longitude)
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        delegate?.didTapOnMap(latitude: point.latitude, longitude: point.longitude)
    }
}
