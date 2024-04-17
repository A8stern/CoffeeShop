//
//  TextFieldPassword.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation
import UIKit

class TextFieldPassword: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
       
    private func setup() {
        font = UIFont.systemFont(ofSize: 16)
        backgroundColor = UIColor.white
        layer.borderColor = AppColors.Brown.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 25
        clipsToBounds = true
        textAlignment = .left
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        leftViewMode = .always
        isSecureTextEntry = true
        placeholder = "*****"
    }
}
