//
//  ListPresenter.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import Foundation

protocol ListViewProtocol: AnyObject {
    func updateView()
}

protocol ListPresenterProtocol: AnyObject {
    
    var models: [Model] {get}
    init(view: ListViewProtocol, models: [Model])
    func setModels()
}

final class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var models: [Model]
    
    init(view: ListViewProtocol, models: [Model]) {
        self.view = view
        self.models = models
    }
    
    /// Presenter asks view to update interface
    func setModels() {
        view?.updateView()
    }
    
}
