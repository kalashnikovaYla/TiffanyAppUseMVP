//
//  ModuleBuilder.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    
    static func createListModule() -> UIViewController
    static func createDetailModule(model: Model?) -> UIViewController
    static func createWishListModule() -> UIViewController
    static func createPurchasesModule() -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
   
    static func createListModule() -> UIViewController {
        let view = ListViewController()
        let models = Model.arrayData
        let presenter = ListPresenter(view: view, models: models)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(model: Model?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
    
    static func createWishListModule() -> UIViewController {

        let view = WishListViewController()
        let models = Model.arrayData
        let presenter = WishListPresenter(view: view, models: models)
        view.presenter = presenter
        return view
    }
    
    static func createPurchasesModule() -> UIViewController {

        let view = PurchasesViewController()
        let models = Model.arrayData
        let presenter = PurchasesPresenter(view: view, models: models)
        view.presenter = presenter
        return view
    }
    
    
}
