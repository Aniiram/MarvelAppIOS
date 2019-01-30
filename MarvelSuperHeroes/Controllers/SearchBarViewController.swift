//
//  SearchBarController.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 28/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//
//
import UIKit

class SearchBarViewController: UIViewController {

    private let heroesListCollectionView = HeroesListCollectionViewController()
    private let searchController = UISearchController(searchResultsController: nil)
    private let dataSource = SearchTabDataSource()
    private var pendingRequestWorkItem: DispatchWorkItem?
    private var oldTextSearch = ""

    override func viewDidLoad() {

        super.viewDidLoad()

        self.addChild(heroesListCollectionView)
        self.configureSearchController()

        self.addSubviews()
        self.configureConstraints()
        self.configureSubviews()
    }
}

// MARK: Private

private extension SearchBarViewController {

    func addSubviews() {

        self.heroesListCollectionView.willMove(toParent: self)

        self.addChild(self.heroesListCollectionView)

        self.view.addSubview(self.heroesListCollectionView.view)

        self.heroesListCollectionView.didMove(toParent: self)
    }

    func configureConstraints() {

        self.heroesListCollectionViewConstrains()
    }

    func configureSubviews() {

        self.navigationController?.delegate = self.heroesListCollectionView

        self.heroesListCollectionView.delegate = self
        self.dataSource.delegate = self
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

    func configureSearchController() {

        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false

        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self

        self.definesPresentationContext = true

        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self

        //Escurece a view quando está a true
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search here..."
        self.searchController.searchBar.tintColor = Constants.searchBarTintColor
        self.searchController.searchBar.barTintColor = Constants.searchBarTintColor
        self.searchController.searchBar.barStyle = UIBarStyle.black
    }
}

extension SearchBarViewController: UISearchControllerDelegate {

    func didDismissSearchController(_ searchController: UISearchController) {

        self.heroesListCollectionView.setUpHeroesListData([])
    }
}

extension SearchBarViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        self.pendingRequestWorkItem?.cancel()

        guard let searchText = searchController.searchBar.text, searchText != "", searchText != self.oldTextSearch else {

            return
        }

        self.oldTextSearch = searchText
        let requestWorkItem = DispatchWorkItem { [weak self] in

            self?.dataSource.requestForHeroes(searchText)
        }

        self.pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }
}

extension SearchBarViewController: HeroesListCollectionViewControllerProtocol {

    func scrollViewReachEnd(viewController: HeroesListCollectionViewController?, error: Error?) {

        self.dataSource.requestForHeroes()
    }

    func pushViewController(viewController: HeroesListCollectionViewController?, viewControllerToPush: UIViewController, error: Error?) {

        if let bounds = self.navigationController?.navigationBar.frame {

            viewControllerToPush.navigationController?.navigationBar.frame = bounds
        }

        self.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }

    func removeHeroeFromFavorites(viewController: HeroesListCollectionViewController?, viewCell: HeroeCollectionViewCell, error: Error?) {

    }

    func reloadHeroesData(viewController: HeroesListCollectionViewController?, error: Error?) {

        self.heroesListCollectionView.reloadCollectionView()
    }
}

extension SearchBarViewController: SearchTabDataSourceProtocol {

    func heroesDataAdd(_: SearchTabDataSource?, _ heroesData: [(id: String, name: String, url: String)]?, error: Error?) {

        if let heroesData = heroesData, heroesData.count > 0 {

            self.heroesListCollectionView.addHeroesToTheList(heroesData)
        }
    }

    func heroesDataSetUp(_: SearchTabDataSource?, _ heroesData: [(id: String, name: String, url: String)]?, error: Error?) {

        if let heroesData = heroesData {

            self.heroesListCollectionView.setUpHeroesListData(heroesData)
        }
    }
}
