//
//  SceneDelegate.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        ///Create VC for tabBarController
        let listVC = ModuleBuilder.createListModule()
        let wishListVC = ModuleBuilder.createWishListModule()
        let purchasesVC = ModuleBuilder.createPurchasesModule()
        
        listVC.navigationItem.largeTitleDisplayMode = .automatic
        wishListVC.navigationItem.largeTitleDisplayMode = .automatic
        purchasesVC.navigationItem.largeTitleDisplayMode = .automatic
        
        
        let firstNavigationController = UINavigationController(rootViewController: listVC)
        let secondNavigationController = UINavigationController(rootViewController: wishListVC)
        let thirdNavigationController = UINavigationController(rootViewController: purchasesVC)
        let arrayNav = [firstNavigationController, secondNavigationController, thirdNavigationController]
        
        for nav in arrayNav {
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationBar.tintColor = .systemPurple
        }
        
        ///Create tabBarController
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(arrayNav, animated: true)
        tabBarController.tabBar.tintColor = .systemPurple
        
        wishListVC.loadViewIfNeeded()
        purchasesVC.loadViewIfNeeded()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .clear
    }
}

