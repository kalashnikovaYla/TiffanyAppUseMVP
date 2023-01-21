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
    func wishListButtonIsTapped()
    func cartButtonIsTapped()
}

final class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailViewProtocol?
    var model: Model?
    
    //MARK: Init
    
    init(view: DetailViewProtocol, model: Model?) {
        self.view = view
        self.model = model
        passDataToView()
    }
    
    /// Presenter asks view to update interface
    func passDataToView() {
        view?.updateView(model: model)
    }
    
    ///Presenter update models
    func wishListButtonIsTapped() {
        model?.isAddedToWishList = true
    }

    func cartButtonIsTapped() {
        model?.isAddedToCart = true
    }
}
