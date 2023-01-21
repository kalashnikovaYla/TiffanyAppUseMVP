//
//  WishListViewController.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import UIKit

final class WishListViewController: UIViewController {

    var presenter: WishListPresenterProtocol!
    private let identifier = "cell"

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Упс! Список избранного пуст. Вернитесь в каталог"
        label.tintColor = .secondaryLabel
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .tertiarySystemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранное"
        view.backgroundColor = .tertiarySystemBackground
        tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), tag: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /// View asks presenter to pass data for update interface
        presenter.passDataToView()
        tableView.reloadData()
    }
}

//MARK: - WishListViewProtocol

extension WishListViewController: WishListViewProtocol {
    
    func emptyWishList() {
        
        view.addSubviews(imageView, label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4)
        ])
    }
    
    func updateView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.selectedModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = presenter.selectedModels[indexPath.row].name
        
        let imageName = presenter.selectedModels[indexPath.row].nameOfImage
        if let image = UIImage(named: imageName) {
            configuration.image = image
        }
        cell.contentConfiguration = configuration
        cell.backgroundColor = .tertiarySystemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
