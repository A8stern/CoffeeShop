//
//  NavBarViewController.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 30.03.2024.
//

import UIKit
import SnapKit

class NavBarViewController: UINavigationController {
    
    var buttonAccount: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.setImage(UIImage(systemName: "person.crop.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), for: .normal)
        button.tintColor = AppColors.Green
        button.backgroundColor = AppColors.LightGrey
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    var buttonMap: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.setImage(UIImage(systemName: "map.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), for: .normal)
        button.tintColor = AppColors.Green
        button.backgroundColor = AppColors.LightGrey
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    
    var viewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar(for: viewController)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.viewController = viewController
    }
    
    private func setupNavigationBar(for viewController: UIViewController) {
        navigationBar.barTintColor = AppColors.LightGrey
        navigationBar.isTranslucent = false

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = AppColors.LightGrey
            appearance.shadowColor = nil
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }

        navigationBar.shadowImage = UIImage()
                
        navigationBar.prefersLargeTitles = false
        navigationBar.tintColor = AppColors.Green
        
        let buttonSize: CGFloat = 30

        buttonAccount.snp.makeConstraints { make in
            make.height.width.equalTo(buttonSize)
        }
                
        buttonMap.snp.makeConstraints { make in
            make.height.width.equalTo(buttonSize)
        }
        
        setupActions()

        let leftBarButtonItem = UIBarButtonItem(customView: buttonMap)
        let rightBarButtonItem = UIBarButtonItem(customView: buttonAccount)
        
        self.topViewController?.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.topViewController?.navigationItem.rightBarButtonItem = rightBarButtonItem
    }


    
    private func setupActions() {
        buttonAccount.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        buttonMap.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
    }
    
    @objc private func accountButtonTapped(sender: UIButton) {
        animateButton(sender)
        print("Account button tapped")
        if UserDataHandler.shared.hasStoredEmailData() {
            let userModule = UserRouter.createModule()
            self.pushViewController(userModule, animated: true)
        } else {
            let accountModule = AccountRouter.createModule()
            self.pushViewController(accountModule, animated: true)
        }
    }
    
    @objc private func mapButtonTapped(sender: UIButton) {
        animateButton(sender)
        print("Map button tapped")
        let mapModule = MapRouter.createModule()
        self.pushViewController(mapModule, animated: true)
    }
    
    private func animateButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                        sender.transform = CGAffineTransform.identity
                }
            }
        )
    }
}


