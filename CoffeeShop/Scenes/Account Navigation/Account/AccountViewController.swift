//
//  AccountViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//

import Foundation

//
//  MapViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 30.03.2024.
//

import Foundation
import UIKit
import SnapKit

class AccountViewController: UIViewController {
    var presenter: AccountPresenter?
    
    var loginButton: BigButton = {
        var button = BigButton()
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    var registerButton: BigButton = {
        var button = BigButton()
        button.setTitle("Register", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.LightGrey
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        makeConstrains()
    }
    
    private func makeConstrains(){
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }
    }
    
    @objc private func loginTapped() {
        print("login")
        animateLoginButtonTap()
        presenter?.loginButtonTapped()
    }
    
    private func animateLoginButtonTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                    self.loginButton.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc private func registerTapped() {
        print("register")
        animateRegisterButtonTap()
        presenter?.regButtonTapped()
    }
    
    private func animateRegisterButtonTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.registerButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                    self.registerButton.transform = CGAffineTransform.identity
            }
        }
    }
}
