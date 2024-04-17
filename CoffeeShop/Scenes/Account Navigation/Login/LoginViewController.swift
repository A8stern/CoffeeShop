//
//  LoginViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    var presenter: LoginPresenter?

    var emailLabel: RegistrationLabels = {
        var emailLabel = RegistrationLabels()
        emailLabel.text = "email"
        return emailLabel
    }()
        
    var emailTextField: TextFieldRegistration = {
        var textView = TextFieldRegistration()
        textView.placeholder = "example@example.ru"
        return textView
    }()
        
    var passwordLabel: RegistrationLabels = {
        var passwordLabel = RegistrationLabels()
        passwordLabel.text = "Password"
        return passwordLabel
    }()
    
    var passwordField = TextFieldPassword()
        
    var loginButton: BigButton = {
        var registerButton = BigButton()
        registerButton.setTitle("Login", for: .normal)
        return registerButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.LightGrey
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        [emailLabel, emailTextField, passwordLabel, passwordField, loginButton].forEach { view.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.right.equalToSuperview().inset(20)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    @objc private func buttonTapped() {
        animateButtonTap()
        presenter?.loginButtonTapped(withEmail: emailTextField.text, password: passwordField.text)
    }
    
    private func animateButtonTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                    self.loginButton.transform = CGAffineTransform.identity
            }
        }
    }

    func showErrorMessage(_ message: String) {
        print("Error: \(message)")
    }
}
