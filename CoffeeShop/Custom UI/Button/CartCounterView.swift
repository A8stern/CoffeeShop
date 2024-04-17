//
//  CartCounterView.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import UIKit
import SnapKit

protocol CartCounterViewDelegate: AnyObject {
    func cartCounterViewAddOneItemCount()
    func cartCounterViewMinusOneItemCount()
    func cartCounterViewDidReachZeroItemCount()
}

class CartCounterView: UIView {
    
    weak var delegate: CartCounterViewDelegate?
    
    var item: Item?
    var itemCount: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    var isInCart: Bool = false {
        didSet {
            updateButtonState()
        }
    }
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(AppColors.Black, for: .normal)
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(AppColors.Black, for: .normal)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = AppColors.Black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupActions()
        updateButtonState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupActions()
        updateButtonState()
    }
    
    private func setupViews() {
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(countLabel)
        
        minusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(minusButton.snp.trailing)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        
        plusButton.snp.makeConstraints { make in
            make.leading.equalTo(countLabel.snp.trailing)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupActions() {
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    private func updateButtonState() {
        minusButton.isEnabled = isInCart && itemCount > 0
        countLabel.text = "\(itemCount)"
    }
    
    private func updateCountLabel() {
        countLabel.text = "\(itemCount)"
    }
    
    @objc private func minusButtonTapped() {
        guard itemCount > 1 else { 
            delegate?.cartCounterViewDidReachZeroItemCount()
            return
        }
        delegate?.cartCounterViewMinusOneItemCount()
        updateButtonState()
    }
    
    @objc private func plusButtonTapped() {
        delegate?.cartCounterViewAddOneItemCount()
        updateButtonState()
    }
}
