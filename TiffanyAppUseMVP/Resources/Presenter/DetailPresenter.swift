//
//  DetailPresenter.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func updateView(model: Model?)
}

protocol DetailPresenterProtocol: AnyObject {
    
    var model: Model? {get}
    init(view: DetailViewProtocol, model: Model?)
    func passDataToView()
    func modelIsSeleted()
}

final class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailViewProtocol?
    var model: Model?
    
    init(view: DetailViewProtocol, model: Model?) {
        self.view = view
        self.model = model
        passDataToView()
    }
    
    ///Presenter asks view to update interface
    func passDataToView() {
        view?.updateView(model: model)
    }
    
    func modelIsSeleted() {
        model?.isFavorites = true 
    }
    
}
