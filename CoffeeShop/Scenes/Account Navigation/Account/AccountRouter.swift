//
//  AccountRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//

import UIKit

class AccountRouter {
    weak var viewController: UIViewController?

    func navigateToLoginViewController() {
        let loginModule = LoginRouter.createModule()
        viewController?.navigationController?.pushViewController(loginModule, animated: true)
    }
    
    func navigateToRegisterViewController() {
        let registerModule = RegisterRouter.createModule()
        viewController?.navigationController?.pushViewController(registerModule, animated: true)
    }
    
    static func createModule() -> UIViewController {
        let view = AccountViewController()
        let presenter = AccountPresenter()
        let interactor = AccountInteractor()
        let router = AccountRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
