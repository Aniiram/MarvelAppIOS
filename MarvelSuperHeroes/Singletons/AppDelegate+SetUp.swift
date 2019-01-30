//
//  AppDelegateRoot.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 29/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

extension AppDelegate {

    var titleImage: UIImageView {

        get {

            let titleImg = UIImageView(image: UIImage(named: "Marvel"))

            titleImg.contentMode = .scaleAspectFit

            return titleImg
        }
    }

    var homeIcon: UIImage? {

        get {

            return UIImage(named: "icon_home")
        }
    }

    var favouritesIcon: UIImage? {

        get {

            return UIImage(named: "icon_heart")
        }
    }

    func setUpTabBarController() -> UITabBarController {

        let tabBarController = UITabBarController()

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: self.defineHome(0)),
            UINavigationController(rootViewController: self.defineFavourites(1)),
            UINavigationController(rootViewController: self.defineSearch(2))
        ]

        tabBarController.tabBar.barTintColor = Constants.tabBarBarTintColor
        tabBarController.tabBar.tintColor = Constants.tabBarTintColor

        tabBarController.viewControllers?
            .compactMap { $0 as? UINavigationController }
            .forEach {
                $0.navigationBar.barTintColor = Constants.navBarBarTintColor
                $0.navigationBar.tintColor = Constants.navBarTintColor
                $0.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.navBarTintColor]
                $0.topViewController?.navigationItem.titleView = self.titleImage
                $0.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                $0.title = "Marvel"
        }

        return tabBarController
    }

    func defineHome(_ tag: Int) -> UIViewController {

        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: self.homeIcon, tag: tag)

        return homeViewController
    }

    func defineFavourites(_ tag: Int) -> UIViewController {

        let favouritesViewController = FavouritesViewController()
        favouritesViewController.tabBarItem = UITabBarItem(title: "Favourites", image: self.favouritesIcon, tag: tag)

        return favouritesViewController
    }

    func defineSearch(_ tag: Int) -> UIViewController {

        let searchViewController = SearchBarViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: tag)

        return searchViewController
    }
}
