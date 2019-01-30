//
//  HeroePageViewController.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 13/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

class HeroeDetailViewController: UIViewController {

    private var heroInfo = (id: "", name: "Super-Hero", url: "")
    private var heroeImage: UIImage?
    private let dataSource: HeroeDetailViewControllerDataSource

    private var detailView = DetailView()

    init(_ heroInfo: (id: String, name: String, url: String),_ heroeImage: UIImage?) {

        self.heroInfo = heroInfo
        self.heroeImage = heroeImage
        self.dataSource = HeroeDetailViewControllerDataSource(heroInfo.id)

        super.init(nibName: nil, bundle: nil)

        self.detailView.delegate = self
        self.dataSource.delegate = self
        self.dataSource.requestForHeroeData()
    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        self.title = self.heroInfo.name
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        self.view.addSubview(self.detailView)
        self.detailViewConstrains()
        self.setDetailView()
    }
}

// MARK: Private

private extension HeroeDetailViewController {

    func setDetailView() {

        self.detailView.backgroundColor = Constants.backgroundColor

        if let heroeImage = self.heroeImage {

            self.detailView.setHeroe(FavouritesHelper.isFavourite(heroInfo.id), heroeImage, self.heroInfo.name)

        } else {

            self.detailView.setHeroe(FavouritesHelper.isFavourite(heroInfo.id), URL(string: self.heroInfo.url), self.heroInfo.name)
        }
    }

    func detailViewConstrains() {

        self.detailView.translatesAutoresizingMaskIntoConstraints = false

        //Pin to SafeArea
        let margins = self.view.safeAreaLayoutGuide
        self.detailView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        self.detailView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    }
}

extension HeroeDetailViewController: HeroeDetailViewControllerDataSourceProtocol {

    func finishDataRetrieve(_: HeroeDetailViewControllerDataSource?,
                            _ comics: [(title: String, description: String)]?,
                            _ events: [(title: String, description: String)]?,
                            _ stories: [(title: String, description: String)]?,
                            _ series: [(title: String, description: String)]?,
                            error: Error?) {

        if let comics = comics {

            print(comics)
            self.detailView.addElements("Comics", data: comics)
        }

        if let events = events {

            print(events)
            self.detailView.addElements("Events", data: events)
        }

        if let stories = stories {

            print(stories)
            self.detailView.addElements("Stories", data: stories)
        }

        if let series = series {

            print(series)
            self.detailView.addElements("Series", data: series)
        }

        self.detailView.configureView()
    }

    func description(_: HeroeDetailViewControllerDataSource?, _ description: String?, error: Error?) {

        self.detailView.setUpDescription(description ?? "")
    }
}

extension HeroeDetailViewController: DetailViewProtocol {
    
    func addHeroeOnFavorites(viewCell: DetailView?, erro: Error?) {

        FavouritesHelper.addFavourite(heroInfo.id,
                                      heroInfo.name,
                                      heroInfo.url)

    }

    func removeHeroeFromFavorites(viewCell: DetailView?, error: Error?) {

        FavouritesHelper.removeFavourite(heroInfo.id)
    }
}
