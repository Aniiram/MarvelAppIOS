//
//  ListHeroesCollectionViewController.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//
//
import UIKit

protocol HeroesListCollectionViewControllerProtocol {

    func scrollViewReachEnd(viewController: HeroesListCollectionViewController?, error: Error?)
    func pushViewController(viewController: HeroesListCollectionViewController?, viewControllerToPush: UIViewController, error: Error?)
    func removeHeroeFromFavorites(viewController: HeroesListCollectionViewController?, viewCell: HeroeCollectionViewCell, error: Error?)
    func reloadHeroesData(viewController: HeroesListCollectionViewController?, error: Error?)
}

class HeroesListCollectionViewController: UIViewController {

    var delegate: HeroesListCollectionViewControllerProtocol?

    private(set) var heroesData: [(id: String, name: String, url: String)] = []
    private var favourites = FavouritesHelper.favourites()
    private var customInteractor: CustomInteractor?
    private var customAnimator: CustomAnimator?
    private var selectedCellIndexPath: IndexPath?
    private let heroesListCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {

        super.viewDidLoad()

        self.addSubviews()
        self.configureConstraints()
        self.configureSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        if self.favourites != FavouritesHelper.favourites() {

            self.favourites = FavouritesHelper.favourites()
            self.delegate?.reloadHeroesData(viewController: self, error: nil)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)
        self.heroesListCollectionView.collectionViewLayout.invalidateLayout()
    }

    // MARK: Public

    func setUpHeroesListData(_ heroesData: [(id: String, name: String, url: String)]) {

        self.heroesData = []
        self.addHeroesToTheList(heroesData)
    }

    func addHeroesToTheList(_ heroesData: [(id: String, name: String, url: String)]) {

        self.heroesData.append(contentsOf: heroesData)
        self.reloadCollectionView()
    }

    func reloadCollectionView() {

        self.heroesListCollectionView.reloadData()
    }

    func deleteCellAt(_ viewCell: HeroeCollectionViewCell) {

        guard let indexPathOfCell = self.heroesListCollectionView.indexPath(for: viewCell) else {

            return
        }

        self.heroesData.remove(at: indexPathOfCell.item)
        self.heroesListCollectionView.deleteItems(at: [indexPathOfCell])
    }
}

// MARK: Private

private extension HeroesListCollectionViewController {

    func addSubviews() {

        self.view.addSubview(self.heroesListCollectionView)
    }

    func configureConstraints() {

        self.heroesListCollectionViewConstrains()
    }

    func configureSubviews() {

        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        //background color
        self.heroesListCollectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        //DataSource and Delegation
        self.heroesListCollectionView.dataSource = self
        self.heroesListCollectionView.delegate = self
        self.heroesListCollectionView.register(HeroeCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    }

    func heroesListCollectionViewConstrains() {

        self.heroesListCollectionView.translatesAutoresizingMaskIntoConstraints = false

        let margins = self.view.safeAreaLayoutGuide
        self.heroesListCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.heroesListCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.heroesListCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        self.heroesListCollectionView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    }
}

extension HeroesListCollectionViewController: HeroeCollectionViewCellProtocol {

    func addHeroeOnFavorites(viewCell: HeroeCollectionViewCell?, erro: Error?) {

        if let viewCell = viewCell, let indexPath = heroesListCollectionView.indexPath(for: viewCell) {

            FavouritesHelper.addFavourite(heroesData[indexPath.row].id,
                                          heroesData[indexPath.row].name,
                                          heroesData[indexPath.row].url)

            self.favourites = FavouritesHelper.favourites()
        }
    }

    func removeHeroeFromFavorites(viewCell: HeroeCollectionViewCell?, error: Error?) {

        if let viewCell = viewCell, let indexPath = self.heroesListCollectionView.indexPath(for: viewCell) {

            FavouritesHelper.removeFavourite(heroesData[indexPath.row].id)
            self.favourites = FavouritesHelper.favourites()
            self.delegate?.removeHeroeFromFavorites(viewController: self, viewCell: viewCell, error: error)
        }
    }
}

extension HeroesListCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return self.heroesData.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)

        if let cell = cell as? HeroeCollectionViewCell {

            let id = self.heroesData[indexPath[1]].id
            let name = self.heroesData[indexPath[1]].name
            let imgUrl = URL(string: self.heroesData[indexPath[1]].url)

            cell.setCell(at: id, with: name, at: imgUrl)
            cell.sizeToFit()
            cell.delegate = self
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionHeader) {

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "SearchHeaderCollectionReusableView",
                                                                             for: indexPath)
            return headerView
        }

        fatalError()
    }

}

extension HeroesListCollectionViewController:  UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        if let cell = collectionView.cellForItem(at: indexPath) as? HeroeCollectionViewCell {

            let heroeDetailVC = HeroeDetailViewController(self.heroesData[indexPath[1]], cell.imageView.image)

            self.selectedCellIndexPath = indexPath
            self.customAnimator = CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration),
                                                 originFrame: collectionView.convert(cell.frame, to: view.superview),
                                                 image: cell.imageView.image, self, self)

            delegate?.pushViewController(viewController: self, viewControllerToPush: heroeDetailVC, error: nil)
        }
    }
}

extension HeroesListCollectionViewController: CustomAnimatorProtocol {

    func frameToAnimate() -> CGRect {

        if let selectedCellIndexPath = self.selectedCellIndexPath, let cell = self.heroesListCollectionView.cellForItem(at: selectedCellIndexPath) as? HeroeCollectionViewCell {

            print("here")
            print(self.view.superview!)
            print(cell.frame)
            return self.heroesListCollectionView.convert(cell.frame, to: self.view.superview)
        }

        return CGRect.zero
    }
}

extension HeroesListCollectionViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if scrollView.contentSize.height <= scrollView.contentOffset.y + scrollView.bounds.height {

            self.delegate?.scrollViewReachEnd(viewController: self, error: nil)
        }
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {

        return true
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {

        print("hmmmm")
    }
}

extension HeroesListCollectionViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {

        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC)
            return self.customAnimator?.push()

        default:
            return self.customAnimator?.pop()
        }
    }

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        guard let ci = customInteractor else { return nil }
        
        return ci.transitionInProgress ? customInteractor : nil
    }
    
}
