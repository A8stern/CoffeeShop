//
//  LoginRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import UIKit

class LoginRouter{
    weak var viewController: UIViewController?

    func navigateToUserViewController() {
        let userModule = UserRouter.createModule()
        viewController?.navigationController?.pushViewController(userModule, animated: true)
    }
    
    static func createModule() -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}


