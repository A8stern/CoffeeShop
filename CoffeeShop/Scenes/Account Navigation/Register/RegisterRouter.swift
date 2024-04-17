//
//  RegisterRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation
import UIKit

class RegisterRouter {
    weak var viewController: UIViewController?

    func navigateToUserViewController() {
        let userModule = UserRouter.createModule()
        viewController?.navigationController?.pushViewController(userModule, animated: true)
    }
    
    static func createModule() -> UIViewController {
        let view = RegisterViewController()
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        let router = RegisterRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
