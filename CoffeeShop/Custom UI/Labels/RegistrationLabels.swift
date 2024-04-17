//
//  RegistrationLabels.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import UIKit

class RegistrationLabels: UILabel {
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
    }

}
