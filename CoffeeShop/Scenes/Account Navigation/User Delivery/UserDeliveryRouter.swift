//
//  UserDeliveryRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import UIKit

class UserDeliveryRouter {
    weak var viewController: UIViewController?

    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    static func createModule() -> UIViewController {
        let view = UserDeliveryViewController()
        let presenter = UserDeliveryPresenter()
        let interactor = UserDeliveryInteractor()
        let router = UserDeliveryRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
