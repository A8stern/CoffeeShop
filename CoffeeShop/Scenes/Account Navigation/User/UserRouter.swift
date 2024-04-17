//
//  UserRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import UIKit

class UserRouter {
    weak var viewController: UIViewController?

    func popToRootViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func pushUserDeliveryViewController() {
        let deliveryModule = UserDeliveryRouter.createModule()
        viewController?.navigationController?.pushViewController(deliveryModule, animated: true)
    }
    
    static func createModule() -> UIViewController {
        let view = UserViewController()
        let presenter = UserPresenter()
        let interactor = UserInteractor()
        let router = UserRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
