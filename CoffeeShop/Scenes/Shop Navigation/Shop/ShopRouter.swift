//
//  ShopRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import UIKit

class ShopRouter {
    weak var viewController: UIViewController?

    func pushItemViewController(with item: Item) {
        let itemModule = ItemRouter.createModule(with: item)
        viewController?.navigationController?.pushViewController(itemModule, animated: true)
    }
    
    func pushCartViewController() {
        let cartModule = CartRouter.createModule()
        viewController?.navigationController?.pushViewController(cartModule, animated: true)
    }
    
    static func createModule() -> UIViewController {
        let view = ShopViewController()
        let presenter = ShopPresenter()
        let interactor = ShopInteractor()
        let router = ShopRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
