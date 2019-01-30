//
//  FavouritesViewController.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 30/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    private let heroesListCollectionView = HeroesListCollectionViewController()

    override func viewDidLoad() {

        super.viewDidLoad()

        self.addChild(heroesListCollectionView)
        
        self.addSubviews()
        self.configureConstraints()
        self.configureSubviews()
    }
}

// MARK: Private

private extension FavouritesViewController {

    func addSubviews() {

        self.view.addSubview(self.heroesListCollectionView.view)
    }

    func configureConstraints() {

        self.heroesListCollectionViewConstrains()
    }

    func configureSubviews() {

        self.navigationController?.delegate = self.heroesListCollectionView
        self.heroesListCollectionView.delegate = self
        self.heroesListCollectionView.setUpHeroesListData(DataSourceHelper.digestData(FavouritesHelper.favourites() ?? [:]))
    }

    func heroesListCollectionViewConstrains() {

        self.heroesListCollectionView.view.translatesAutoresizingMaskIntoConstraints = false

        //Pin to SafeArea
        let margins = self.view.safeAreaLayoutGuide
        self.heroesListCollectionView.view.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.heroesListCollectionView.view.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.heroesListCollectionView.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        self.heroesListCollectionView.view.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    }
}

extension FavouritesViewController: HeroesListCollectionViewControllerProtocol {

    func removeHeroeFromFavorites(viewController: HeroesListCollectionViewController?, viewCell: HeroeCollectionViewCell, error: Error?) {

        viewController?.deleteCellAt(viewCell)
    }

    func scrollViewReachEnd(viewController: HeroesListCollectionViewController?, error: Error?) {

    }

    func pushViewController(viewController: HeroesListCollectionViewController?, viewControllerToPush: UIViewController, error: Error?) {

        self.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }

    func reloadHeroesData(viewController: HeroesListCollectionViewController?, error: Error?) {

        self.heroesListCollectionView.setUpHeroesListData(DataSourceHelper.digestData(FavouritesHelper.favourites() ?? [:]))
    }

}
