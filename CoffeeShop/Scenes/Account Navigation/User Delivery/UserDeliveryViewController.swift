//
//  UserDeliveryViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import UIKit
import SnapKit

class UserDeliveryViewController: UIViewController, DeliveryMapDelegate {
    var presenter: UserDeliveryPresenter?
    
    var adressLabel: RegistrationLabels = {
        var adressLabel = RegistrationLabels()
        adressLabel.numberOfLines = 0
        adressLabel.lineBreakMode = .byWordWrapping
        adressLabel.textAlignment = .center
        return adressLabel
    }()
    
    var flatLabel: RegistrationLabels = {
        var flatLabel = RegistrationLabels()
        flatLabel.text = "Number of flat"
        flatLabel.textAlignment = .center
        return flatLabel
    }()
    
    var flatTextField: TextFieldRegistration = {
        var flatTextField = TextFieldRegistration()
        flatTextField.placeholder = "0"
        return flatTextField
    }()
    
    var deliveryMap = DeliveryMap()
    
    var chooseAdress: BigButton = {
        var chooseAdress = BigButton()
        chooseAdress.setTitle("Change adress of delivery", for: .normal)
        return chooseAdress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidAppear()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    private func setupUI() {
        view.backgroundColor = AppColors.LightGrey
        deliveryMap.delegate = self
        chooseAdress.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        [deliveryMap, adressLabel, flatLabel,
         flatTextField, chooseAdress].forEach {  view.addSubview($0) }
        setupLayout()
    }
    
    private func setupLayout() {
        deliveryMap.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }
        adressLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryMap.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        flatLabel.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        flatTextField.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(20)
            make.left.equalTo(flatLabel.snp.right).inset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        chooseAdress.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    func changeText(adress: String) {
        print(adress)
        adressLabel.text = adress
    }
    
    @objc func buttonTapped() {
        print("change adress")
        animateButtonTap()
        presenter?.buttonTapped(adressName: adressLabel.text, flat: flatTextField.text)
    }
    
    private func animateButtonTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.chooseAdress.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                    self.chooseAdress.transform = CGAffineTransform.identity
            }
        }
    }
    
    func didTapOnMap(latitude: Double, longitude: Double) {
        print("Latitude: \(latitude), Longitude: \(longitude)")
        presenter?.tapOnMap(lat: latitude, lon: longitude)
    }
    
    func showErrorMessage(_ message: String) {
        print("Error: \(message)")
    }
}
