//
//  ListViewController.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import UIKit

final class ListViewController: UIViewController {

    private var identifier = "Cell"
    private var tableView: UITableView!
    
    var presenter: ListPresenterProtocol!
    
    //MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Каталог"
        tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "clipboard"), tag: 0)
        view.backgroundColor = .tertiarySystemBackground
        settingsTableView()
    }
    
    func settingsTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .tertiarySystemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}


//MARK: - ListViewProtocol

extension ListViewController: ListViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = presenter.models[indexPath.row].name
        
        let imageName = presenter.models[indexPath.row].nameOfImage
        if let image = UIImage(named: imageName) {
            configuration.image = image
        }
        cell.contentConfiguration = configuration
        cell.backgroundColor = .tertiarySystemBackground
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        /// View notifies presenter that the row is selected
        let selectedModel = presenter.models[indexPath.row]
        let detailVC = ModuleBuilder.createDetailModule(model: selectedModel)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


