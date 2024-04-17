//
//  BigButton.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import UIKit

class BigButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
       
    private func setup() {
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        setTitleColor(AppColors.Black, for: .normal)
        backgroundColor = AppColors.Green
        layer.borderColor = AppColors.Green.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 20
        clipsToBounds = true
        
    }
}
