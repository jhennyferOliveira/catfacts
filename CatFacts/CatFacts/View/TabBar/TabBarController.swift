//
//  TabBarController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purpleAction]
        appearance.stackedLayoutAppearance = tabBarItemAppearance
        
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item1 = FactCollectionViewController()
        let icon1 = UITabBarItem(title: "Cat Facts", image: UIImage(systemName: "newspaper.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "newspaper.fill")?.withTintColor(.purpleAction, renderingMode: .alwaysOriginal))
        
        let item2 = FavoriteViewController()
        let icon2 = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "heart.fill")?.withTintColor(.purpleAction, renderingMode: .alwaysOriginal))
        
        item2.tabBarItem = icon2
        item1.tabBarItem = icon1
        
        let controllers = [item1, item2]
        self.viewControllers = controllers
    }
}
