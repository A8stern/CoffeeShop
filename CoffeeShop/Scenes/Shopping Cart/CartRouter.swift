//
//  CartRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import UIKit

class CartRouter {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = CartViewController()
        let presenter = CartPresenter()
        let interactor = CartInteractor()
        let router = CartRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
