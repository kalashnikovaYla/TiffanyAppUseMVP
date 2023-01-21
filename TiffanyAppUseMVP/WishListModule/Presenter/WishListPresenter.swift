//
//  WishListPresenter.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import Foundation

protocol WishListViewProtocol: AnyObject {
    func emptyWishList()
    func updateView()
}

protocol WishListPresenterProtocol: AnyObject {
    var selectedModels: [Model] {get}
    init(view: WishListViewProtocol, models: [Model]?)
    func passDataToView()
}


final class WishListPresenter: WishListPresenterProtocol {
    
    var models: [Model]?
    weak var view: WishListViewProtocol?
    var selectedModels: [Model] = []
    
    //MARK: Init
    
    init(view: WishListViewProtocol, models: [Model]?) {
        self.view = view
        self.models = models
        passDataToView()
    }
    
    
    /// Presenter asks view to update interface
    func passDataToView() {
        
        guard let models = models else {return}
        
        var temporaryArray: [Model] = []
        
        for model in models {
            if model.isAddedToWishList {
                temporaryArray.append(model)
            }
        }
        selectedModels = temporaryArray
        
        if selectedModels.isEmpty {
            view?.emptyWishList()
        } else {
            view?.updateView()
        }
    }

}
