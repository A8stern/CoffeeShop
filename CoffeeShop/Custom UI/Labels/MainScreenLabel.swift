//
//  MainScreenLabel.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//

import UIKit

class MainScreenLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
       
    private func setup() {
        self.textColor = AppColors.Brown
        self.text = " Order the best \n coffee in your \n area"
        self.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        self.textAlignment = .left
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }

}
