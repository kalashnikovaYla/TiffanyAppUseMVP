//
//  PurchasesViewController.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import UIKit

final class PurchasesViewController: UIViewController {

    var presenter: PurchasesPresenter!
    let identifier = "Cell"
    
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
        label.text = "Упс! Корзина пуста. Вернитесь в каталог"
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

    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оформить заказ", for: .normal)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .systemPurple
        button.setTitleColor(.systemPurple, for: .normal)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Корзина"
        view.backgroundColor = .tertiarySystemBackground
        tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /// View asks presenter to pass data for update interface
        presenter.passDataToView()
        tableView.reloadData()
    }

}

//MARK: - PurchasesViewProtocol

extension PurchasesViewController: PurchasesViewProtocol {
    
    func emptyCart() {
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
        view.addSubviews(tableView, addToCartButton)
        
        addToCartButton.addTarget(self, action: #selector(makeOrder), for: .touchUpInside)
       
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 7/8),
            
            addToCartButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 200),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func makeOrder() {
        let alertController = UIAlertController(title: "Заказ успешно оформлен", message: "Ожидайте звонка оператора", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension PurchasesViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 100
    }
}
