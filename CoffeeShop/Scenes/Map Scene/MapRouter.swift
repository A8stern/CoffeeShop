//
//  MapRouter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 30.03.2024.
//

import UIKit

class MapRouter {
    weak var viewController: UIViewController?

    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    static func createModule() -> UIViewController {
        let view = MapViewController()
        let presenter = MapPresenter()
        let interactor = MapInteractor()
        let router = MapRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
