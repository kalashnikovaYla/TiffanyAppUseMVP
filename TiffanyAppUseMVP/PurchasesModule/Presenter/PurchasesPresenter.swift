//
//  PurchasesPresenter.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import Foundation

protocol PurchasesViewProtocol: AnyObject {
    func emptyCart()
    func updateView()
}

protocol PurchasesPresenterProtocol: AnyObject {
    
    var selectedModels: [Model] {get}
    init(view: PurchasesViewProtocol, models: [Model]?)
    func passDataToView()
}

final class PurchasesPresenter: PurchasesPresenterProtocol {
    
    weak var view: PurchasesViewProtocol?
    var models: [Model]?
    var selectedModels: [Model] = []
    
    //MARK: - Init
    
    init (view: PurchasesViewProtocol, models: [Model]?) {
        self.view = view
        self.models = models 
        passDataToView()
    }
    
    /// Presenter asks view to update interface
    func passDataToView() {
        
        guard let models = models else {return}
        
        var temporaryArray: [Model] = []
        for model in models {
            if model.isAddedToCart{
                temporaryArray.append(model)
            }
        }
        selectedModels = temporaryArray
        if selectedModels.isEmpty {
            view?.emptyCart()
        } else {
            view?.updateView()
        }
    }
    
}
