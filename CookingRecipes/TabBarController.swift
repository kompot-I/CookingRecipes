//
//  TabBarController.swift
//  CookingRecipes
//
//  Created by Nikita Zubov on 10.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    private enum TabBarItem: Int {
        case category
        case main
        case favourite
        
        var title: String {
            switch self {
            case .main : return "Popular Recipes"
            case .category: return "Category Recipes"
            case .favourite: return "Favourite Recies"
            }
        }
        
        var iconName: String {
            switch self {
            case .main : return "star.square"
            case .category: return "square.on.square"
            case .favourite: return "heart.square"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        view.backgroundColor = UIColor(named: "blueColor")
        tabBar.tintColor = .white
        // добавил цвета кастомные цвета в таббар
        tabBar.isTranslucent = false
//        tabBar.barTintColor = UIColor(named: "orangeColor")
//        tabBar.unselectedItemTintColor = UIColor(named: "blueColor")
        
        tabBar.barTintColor = UIColor(named: "blueColor")
        tabBar.unselectedItemTintColor = UIColor(named: "orangeColor")
        

        
        let dataSource: [TabBarItem] = [.category, .main, .favourite]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .category:
                let categoryRecipesViewController = CategoryRecipesViewController()
                return self.wrappedInNavigationController(with: categoryRecipesViewController, title: $0.title)
            case .main:
                let mainViewController = MainViewController()
                return self.wrappedInNavigationController(with: mainViewController, title: $0.title)
            case .favourite:
                let favoriteViewController = FavoriteViewController()
                return self.wrappedInNavigationController(with: favoriteViewController, title: $0.title)
            }
        }
        
        self.viewControllers?.enumerated().forEach{
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
            $1.tabBarController?.tabBar.backgroundColor = UIColor(named: "blueColor")
        }
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UIViewController {
        return UINavigationController(rootViewController: with)
    }
}
