//
//  UICollectionViewFlowLayout+Prepare.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 06/12/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {

    open override func prepare() {

        super.prepare()

        self.minimumLineSpacing = 0.0
        self.minimumInteritemSpacing = 0.0

        guard let availableWidth = collectionView?.superview?.bounds.width else { return }

        let minColumnWidth = CGFloat(150)
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)

        self.itemSize = CGSize(width: cellWidth, height: cellWidth*2/3)

        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
    }
}
