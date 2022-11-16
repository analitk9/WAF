//
//  TabBarConfogurator.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//
import Foundation
import UIKit

final class TabBarConfigurator {
    
    private let allTabs: [TabBarModel] = [.main, .favorite]
    
    func configure()-> UITabBarController {
        getTabBarController()
    }
    
}

extension TabBarConfigurator {
    
    private func getTabBarController()-> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getViewControllers()
        return tabBarController
    }
    
    private func getViewControllers()-> [UIViewController] {
        
        var viewControllers = [UIViewController]()
        
        allTabs.forEach{ tab in
            let controller = getCurrentViewController(tab: tab)
            let navigationController = UINavigationController(rootViewController: controller)
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            viewControllers.append(navigationController)
        }
        
        return viewControllers
    }
    
    private func getCurrentViewController(tab: TabBarModel)-> UIViewController {
        
        switch tab {
        case .main:
            return MainViewController()
        case .favorite:
            return FavoriteViewController()
        }
    }
    
}
