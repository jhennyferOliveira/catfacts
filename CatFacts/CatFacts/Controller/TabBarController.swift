//
//  TabBarController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    let firstController = FactsViewController()
    let secondController = FavoriteViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFirstController()
        setUpSecondController()
        setUpTabBar()
    }
    
    func setUpFirstController() {
        let iconForFirstController = UITabBarItem(title: "Cat Facts", image: UIImage(systemName: "newspaper.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "newspaper.fill")?.withTintColor(.purpleAction, renderingMode: .alwaysOriginal))
        firstController.tabBarItem = iconForFirstController
    }
    
    func setUpSecondController() {
        let iconForSecondController = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "heart.fill")?.withTintColor(.purpleAction, renderingMode: .alwaysOriginal))
        secondController.tabBarItem = iconForSecondController
    }
    
    func setUpTabBar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purpleAction], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let controllers = [firstController, secondController]
        self.viewControllers = controllers
    }
    
}
