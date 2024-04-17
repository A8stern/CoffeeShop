//
//  ItemRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import UIKit

class ItemRouter {
    weak var viewController: UIViewController?
    
    static func createModule(with item: Item) -> UIViewController {
        let view = ItemViewController()
        let presenter = ItemPresenter()
        let interactor = ItemInteractor()
        let router = ItemRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.item = item
        router.viewController = view
        
        return view
    }
}
