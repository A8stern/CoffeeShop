//
//  UserViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import UIKit
import SnapKit

class UserViewController: UIViewController, UserMapDelegate {
    
    var presenter: UserPresenter?
    
    var nameLabel: MainScreenLabel = {
        var label = MainScreenLabel()
        label.text = "Hello"
        label.textColor = AppColors.Brown
        return label
    }()
    
    var adressLabel: RegistrationLabels = {
        var adressLabel = RegistrationLabels()
        adressLabel.text = "Address of delivery"
        adressLabel.textAlignment = .center
        adressLabel.font = UIFont.systemFont(ofSize: 18)
        adressLabel.textColor = AppColors.Brown
        return adressLabel
    }()
    
    var mapButton = UserMap()
    
    var adressNameLabel: RegistrationLabels = {
        var adressNameLabel = RegistrationLabels()
        adressNameLabel.text = " Click on map to change \n your address of delivery"
        adressNameLabel.numberOfLines = 0
        adressNameLabel.lineBreakMode = .byWordWrapping
        adressNameLabel.textAlignment = .center
        adressNameLabel.font = UIFont.systemFont(ofSize: 16)
        adressNameLabel.textColor = AppColors.Brown
        return adressNameLabel
    }()
    
    var logOutButton: BigButton = {
        var logOutButton = BigButton()
        logOutButton.setTitle("Log out", for: .normal)
        return logOutButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidAppear()
        setupUI()
        setupCustomBackButton()
        enum Operation {
          
          case add(constant: Int)
            case subtract(constant: Int)
            case multiply(constant: Int)
        }
        
        func someFunction(_ flag: Bool) -> ([Int]) -> [Int] {
            func someFunction1(number: [Int]) -> [Int] {
                return number.flatMap { [$0, $0] }
            }

            func someFunction2(number: [Int]) -> [Int] {
                return number.flatMap { [$0, $0, $0] }
            }

            return flag ? someFunction1 : someFunction2
        }

        let function = someFunction(false)
        let result = function([3, 2, 1])
        print("***", result)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    private func setupUI() {
        view.backgroundColor = AppColors.LightGrey
        mapButton.delegate = self
        logOutButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        [nameLabel, adressLabel, mapButton,
         adressNameLabel, logOutButton].forEach {  view.addSubview($0) }
        setupLayout()
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
            make.width.equalTo(250)
            make.height.equalTo(120)
        }
        adressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.height.equalTo(50)
        }
        mapButton.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        adressNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mapButton.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.height.equalTo(50)
        }
        logOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupCustomBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popToRoot))
        navigationItem.leftBarButtonItem = backButton
    }

    
    func mapTouched(in view: UserMap) {
        print("Map was touched")
        presenter?.mapTapped()
    }
    
    @objc func buttonTapped() {
        print("Log out")
        presenter?.buttonTapped()
    }
    
    @objc func popToRoot() {
        presenter?.popToRoot()
    }
    
    func changeLocation(latitude: Double, longitude: Double) {
        mapButton.showLocation(latitude: latitude, longitude: longitude)
    }
    
    func changeName(name: String) {
        nameLabel.text = " Hello, \n \(name)"
    }
    
    func changeAdress(adressName: String, flat: Int16) {
        adressNameLabel.text = "\(adressName), квартира \(flat)"
    }
}
