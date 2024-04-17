//
//  CoffeeShopsMap.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import UIKit
import YandexMapsMobile

class CoffeeShopsMap: UIView {
    
    private var mapView: YMKMapView!
    private var mapObjects: YMKMapObjectCollection!
    
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
    }
    
    func addPlacemark(latitude: Double, longitude: Double) {
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

        if let coffeeIcon = UIImage(systemName: "cup.and.saucer.fill")?.withTintColor(AppColors.LightGrey, renderingMode: .alwaysOriginal) {
            let coffeeIconRect = CGRect(x: (size.width - 20) / 2, y: (size.width - 20) / 2, width: 20, height: 20)
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

}


