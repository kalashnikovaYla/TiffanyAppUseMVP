//
//  DetailViewController.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import UIKit

final class DetailViewController: UIViewController {

    //MARK: Properties
    
    var presenter: DetailPresenterProtocol!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .label
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
        label.tintColor = .secondaryLabel
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .secondaryLabel
        label.textAlignment = .justified
        return label
    }()
    
    private let addToWishListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("В избранное", for: .normal)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemPink
        button.setTitleColor(.systemPink, for: .normal)
        return button
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("В корзину", for: .normal)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .systemPurple
        button.setTitleColor(.systemPurple, for: .normal)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .tertiarySystemBackground
        view.addSubviews(imageView, nameLabel, label, descriptionLabel, addToWishListButton, addToCartButton)
        addToWishListButton.addTarget(self, action: #selector(addToWishListButtonTapped), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCardButtonTapped), for: .touchUpInside)
        createConstraint()
    }

    
    private func createConstraint() {
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 7/8),
        
            label.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 7/8),
            
            descriptionLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 7/8),
        
            addToWishListButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            addToWishListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            addToWishListButton.widthAnchor.constraint(equalToConstant: 150),
            addToWishListButton.heightAnchor.constraint(equalToConstant: 50),
            
            addToCartButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            addToCartButton.widthAnchor.constraint(equalToConstant: 150),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func addToWishListButtonTapped() {
        /// The view notifies presenter that the buttons is pressed
        presenter.wishListButtonIsTapped()
    }
    
    @objc func addToCardButtonTapped() {
        /// The view notifies presenter that the buttons is pressed
        presenter.cartButtonIsTapped()
    }
}


//MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    
    func updateView(model: Model?) {
        nameLabel.text = model?.name
        descriptionLabel.text = model?.description ?? ""
        guard let image = UIImage(named: model!.nameOfImage) else {return}
        imageView.image = image
    }
    
}
