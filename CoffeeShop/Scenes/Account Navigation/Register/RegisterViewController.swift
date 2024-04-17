//
//  RegisterViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation
import UIKit
import SnapKit

class RegisterViewController: UIViewController{
    var presenter: RegisterPresenter?
    
    var nameLabel: RegistrationLabels = {
        var label = RegistrationLabels()
        label.text = "Name"
        return label
    }()
    
    var nameTextField: TextFieldRegistration = {
        var textView = TextFieldRegistration()
        textView.placeholder = "Gleb"
        return textView
    }()
    
    var emailLabel: RegistrationLabels = {
        var emailLabel = RegistrationLabels()
        emailLabel.text = "Email"
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
    
    var confirmLabel: RegistrationLabels = {
        var confirmLabel = RegistrationLabels()
        confirmLabel.text = "Repeat password"
        return confirmLabel
    }()
    
    var confirmField = TextFieldPassword()
    
    var registerButton: BigButton = {
        var registerButton = BigButton()
        registerButton.setTitle("Register", for: .normal)
        return registerButton
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        print("Initializing")
        view.backgroundColor = AppColors.LightGrey
        
        [nameLabel, nameTextField, emailLabel,
         emailTextField, passwordField, passwordLabel,
         confirmLabel, confirmField, registerButton].forEach { view.addSubview($0) }
        
        registerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        makeConstrains()
    }
    
    private func makeConstrains() {
        print("Made constrains")
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.right.equalTo(20)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.left.right.equalTo(20)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalTo(20)
        }
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        confirmLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.left.right.equalTo(20)
        }
        confirmField.snp.makeConstraints { make in
            make.top.equalTo(confirmLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(confirmField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func buttonTapped() {
        print("Tapped")
        animateButtonTap()
        presenter?.registerButtonTapped(withName: nameTextField.text, email: emailTextField.text, password: passwordField.text, confirmPassword: confirmField.text)
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
    
    func showErrorMessage(_ message: String) {
        print("Error: \(message)")
    }

}
