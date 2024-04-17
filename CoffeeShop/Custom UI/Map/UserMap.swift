//
//  UserMap.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import UIKit
import YandexMapsMobile

protocol UserMapDelegate: AnyObject {
    func mapTouched(in view: UserMap)
}

class UserMap: UIView {
    weak var delegate: UserMapDelegate?
    
    private var mapView: YMKMapView!
    private var mapObjects: YMKMapObjectCollection!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
        addGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMapView()
        addGestureRecognizer()
    }
    
    private func setupMapView() {
        mapView = YMKMapView(frame: self.bounds)
        mapView.layer.cornerRadius = 30
        mapView.clipsToBounds = true
        addSubview(mapView)
        
        mapObjects = mapView.mapWindow.map.mapObjects.add()
        
        showLocation(latitude: 59.9359, longitude: 30.3259)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mapView.frame = self.bounds
    }
    
    func showLocation(latitude: Double, longitude: Double) {
        let targetLocation = YMKPoint(latitude: latitude, longitude: longitude)
            
        mapView.mapWindow.map.move( with: YMKCameraPosition(target: targetLocation, zoom: 16, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
        
        addPlacemark(latitude: latitude, longitude: longitude)
    }
    
    private func addPlacemark(latitude: Double, longitude: Double) {
        mapObjects.clear()
        let targetLocation = YMKPoint(latitude: latitude, longitude: longitude)
        let placemark = mapObjects.addPlacemark(with: targetLocation)

        let size = CGSize(width: 40, height: 50)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!

        let circleRect = CGRect(x: 0, y: 0, width: size.width, height: size.width)
        context.setFillColor(AppColors.Green.cgColor)
        context.fillEllipse(in: circleRect)

        let arrowPath = UIBezierPath()
        let arrowWidth: CGFloat = 20
        let arrowHeight: CGFloat = 10
        let arrowOrigin = CGPoint(x: (size.width - arrowWidth) / 2, y: size.width - arrowHeight / 2)
        arrowPath.move(to: arrowOrigin)
        arrowPath.addLine(to: CGPoint(x: arrowOrigin.x + arrowWidth / 2, y: arrowOrigin.y + arrowHeight))
        arrowPath.addLine(to: CGPoint(x: arrowOrigin.x + arrowWidth, y: arrowOrigin.y))
        arrowPath.close()
        context.addPath(arrowPath.cgPath)
        context.fillPath()

        if let coffeeIcon = UIImage(systemName: "figure.wave.circle")?.withTintColor(AppColors.LightGrey, renderingMode: .alwaysOriginal) {
            let coffeeIconRect = CGRect(x: (size.width - 40) / 2, y: (size.width - 40) / 2, width: 40, height: 40)
            coffeeIcon.draw(in: coffeeIconRect)
        }

        let customPlacemarkImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let placemarkImage = customPlacemarkImage {
            let placemark = mapObjects.addPlacemark(with: targetLocation)
            let anchorYOffset = (arrowHeight / size.height) * 0.9
            let anchor = CGPoint(x: 0.5, y: 1.0 - anchorYOffset)
                    
            placemark.setIconWith(placemarkImage, style: YMKIconStyle(
                anchor: NSValue(cgPoint: anchor),
                rotationType: YMKRotationType.noRotation.rawValue as NSNumber,
                zIndex: nil,
                flat: nil,
                visible: nil,
                scale: nil,
                tappableArea: nil
            ))
        } else {
            print("Failed to create a custom image for the placemark.")
        }
    }
    
    
    private func addGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapTapped))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func mapTapped() {
        delegate?.mapTouched(in: self)
    }
}

