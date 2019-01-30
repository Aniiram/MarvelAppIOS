//
//  HeroeCollectionViewCell.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 12/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

protocol HeroeCollectionViewCellProtocol {

    func removeHeroeFromFavorites(viewCell: HeroeCollectionViewCell?, error: Error?)
    func addHeroeOnFavorites(viewCell: HeroeCollectionViewCell?, erro: Error?)
}

class HeroeCollectionViewCell: UICollectionViewCell {

    var delegate: HeroeCollectionViewCellProtocol?

    private var imageUrl: URL?
    private var nameLabel = UILabel()
    private var favouriteButton: UIButton

    lazy var imageView: UIImageView = {

        let hImgV = UIImageView()
        
        hImgV.clipsToBounds = true
        //hImgV.layer.cornerRadius = 8.0
        hImgV.contentMode = UIView.ContentMode.scaleAspectFill

        return hImgV
    }()

    private lazy var nameAttributes: [NSAttributedString.Key : Any] = {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        return [
            .font: UIFont(name: "AmericanTypewriter-CondensedBold", size: 27) as Any,
            .strokeWidth: -4.0,
            .strokeColor: UIColor.black,// #colorLiteral(red: 0.9294117647, green: 0.1137254902, blue: 0.1411764706, alpha: 1),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
    }()

    override init(frame: CGRect) {

        self.favouriteButton = UIButton.favoriteButton()

        super.init(frame: frame)

        self.favouriteButton.addTarget(self, action: #selector(favButtonAction(_:)), for: .touchUpInside)
        self.addSubview(self.nameLabel)
        self.addSubview(self.favouriteButton)
    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        super.layoutSubviews()
        
        defineNameLabelConstraits()
        defineFavButtonConstraits()
    }

    // MARK: Public

    func setCell(at id: String, with name: String, at imageUrl: URL?) {

        if let imageUrl = imageUrl {

            if imageUrl != self.imageUrl {

                self.imageUrl = imageUrl
                self.imageView.image = nil
                self.imageView.fetchImage(imageUrl)
            }

        } else {

            self.imageView.image = UIImage(named: "heroeNotFound")
        }

        self.backgroundView = imageView
        self.nameLabel.attributedText = NSAttributedString(string: name, attributes: nameAttributes)
        self.favouriteButton.isSelected = FavouritesHelper.isFavourite(id)
    }

    @objc func favButtonAction(_ sender: UIButton) {
        
        self.favouriteButton.isSelected = !self.favouriteButton.isSelected
        
        if self.favouriteButton.isSelected {

            self.delegate?.addHeroeOnFavorites(viewCell: self, erro: nil)
            
        } else {
            
            self.delegate?.removeHeroeFromFavorites(viewCell: self, error: nil)
        }
    }
}

// MARK: Private

private extension HeroeCollectionViewCell {

    func defineNameLabelConstraits() {

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false

        self.nameLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    func defineFavButtonConstraits() {

        self.favouriteButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        self.favouriteButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        self.favouriteButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Constants.favButtonSizeMultiplier).isActive = true
        self.favouriteButton.heightAnchor.constraint(equalTo: self.favouriteButton.widthAnchor).isActive = true
    }
}
