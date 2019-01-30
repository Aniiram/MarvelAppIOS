//
//  HomeViewController.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 29/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let heroesListCollectionView = HeroesListCollectionViewController()
    private let dataSource = HomeTabDataSource(offset: 0)

    override func viewDidLoad() {

        self.title = "Marvel"

        super.viewDidLoad()

        self.addChild(heroesListCollectionView)

        self.addSubviews()
        self.configureConstraints()
        self.configureSubviews()
    }
}

// MARK: Private

private extension HomeViewController {

    func addSubviews() {

        self.view.addSubview(self.heroesListCollectionView.view)
    }

    func configureConstraints() {

        self.heroesListCollectionViewConstrains()
    }

    func configureSubviews() {

        self.navigationController?.delegate = self.heroesListCollectionView

        self.heroesListCollectionView.delegate = self
        self.dataSource.delegate = self

        self.dataSource.requestForHeroes()
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

extension HomeViewController: HeroesListCollectionViewControllerProtocol {

    func removeHeroeFromFavorites(viewController: HeroesListCollectionViewController?, viewCell: HeroeCollectionViewCell, error: Error?) {
        
    }

    func scrollViewReachEnd(viewController: HeroesListCollectionViewController?, error: Error?) {

        self.dataSource.requestForHeroes()
    }

    func pushViewController(viewController: HeroesListCollectionViewController?, viewControllerToPush: UIViewController, error: Error?) {

        self.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }

    func reloadHeroesData(viewController: HeroesListCollectionViewController?, error: Error?) {

        self.heroesListCollectionView.reloadCollectionView()
    }
}

extension HomeViewController: HomeTabDataSourceProtocol {

    func heroesData(_: HomeTabDataSource?, _ heroesData: [(id: String, name: String, url: String)]?, error: Error?) {

        if let heroesData = heroesData, heroesData.count > 0 {

            self.heroesListCollectionView.addHeroesToTheList(heroesData)
        }
    }
}
