//
//  DetailView.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 14/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

protocol DetailViewProtocol {

    func removeHeroeFromFavorites(viewCell: DetailView?, error: Error?)
    func addHeroeOnFavorites(viewCell: DetailView?, erro: Error?)
}

class DetailView: UIView {

    var delegate: DetailViewProtocol?

    private let heroView = UIView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private var portrait: [NSLayoutConstraint] = []
    private var landscape: [NSLayoutConstraint] = []

    private lazy var favouriteButton = UIButton.favoriteButton()
    private lazy var nameLabel = self.setLabel()
    private lazy var descriptionLabel = self.setLabel()
    private var comicsSection: [UILabel] = []
    private var eventsSection: [UILabel] = []
    private var storiesSection: [UILabel] = []
    private var seriesSection: [UILabel] = []

    lazy var heroeImageView: UIImageView = {

        let hImgV = UIImageView()

        hImgV.tag = Constants.trasitioningAnimationTag
        hImgV.clipsToBounds = true
        hImgV.contentMode = UIView.ContentMode.scaleAspectFill
        //hImgV.layer.cornerRadius = 8.0
        hImgV.translatesAutoresizingMaskIntoConstraints = false

        return hImgV
    }()

    private lazy var nameAttributes: [NSAttributedString.Key : Any] = {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        return [
            .font: UIFont(name: "AmericanTypewriter-CondensedBold", size: 40) as Any,
            .strokeWidth: 4.0,
            .strokeColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ]
    }()

    private lazy var descriptionAttributes: [NSAttributedString.Key : Any] = {

        return [
            .font: UIFont(name: "AmericanTypewriter-Condensed", size: 25) as Any,
            .foregroundColor: UIColor.black
        ]
    }()

    private lazy var sectionTitleAttributes: [NSAttributedString.Key : Any] = {

        return [
            .font: UIFont(name: "AmericanTypewriter-CondensedBold", size: 25) as Any,
            .foregroundColor: UIColor.black
        ]
    }()

    private lazy var elemTitleAttributes: [NSAttributedString.Key : Any] = {

        return [
            .font: UIFont(name: "AmericanTypewriter-Condensed", size: 20) as Any,
            .foregroundColor: UIColor.black
        ]
    }()

    private lazy var elemDescriptionAttributes: [NSAttributedString.Key : Any] = {

        return [
            .font: UIFont(name: "AmericanTypewriter-CondensedLight", size: 23) as Any,
            .foregroundColor: UIColor.black
        ]
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        self.addSubview(self.heroView)
        self.heroView.addSubview(self.heroeImageView)
        self.heroView.addSubview(self.favouriteButton)
        self.heroView.addSubview(self.nameLabel)
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.descriptionLabel)

        self.favouriteButton.addTarget(self, action: #selector(favButtonAction(_:)), for: .touchUpInside)

        self.configureStackView()
    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        super.layoutSubviews()

        self.defineHeroViewConstraits()
        self.defineHeroeImageConstrains()
        self.defineFavouriteButton()
        self.defineNameLabelConstrains()
        self.defineScrollViewConstraits()
        self.defineStackViewConstraits()

        detailChangeSome()
    }

    func detailChangeSome() {

        let orientation = UIApplication.shared.statusBarOrientation.isPortrait

        if orientation {

            self.landscape.forEach() { $0.isActive = !orientation }
            self.portrait.forEach() { $0.isActive = orientation }

        } else {

            self.portrait.forEach() { $0.isActive = orientation }
            self.landscape.forEach() { $0.isActive = !orientation }
        }
    }

    // MARK: Public

    func setHeroe(_ isFavourite: Bool, _ heroeImage: UIImage, _ name: String) {

        self.favouriteButton.isSelected = isFavourite
        self.heroeImageView.image = heroeImage
        self.nameLabel.attributedText = NSAttributedString(string: name, attributes: self.nameAttributes)
    }

    func setHeroe(_ isFavourite: Bool, _ imageUrl: URL?, _ name: String) {

        self.favouriteButton.isSelected = isFavourite
        
        if let imageUrl = imageUrl {

            self.heroeImageView.fetchImage(imageUrl)

        } else {

            self.heroeImageView.image = UIImage(named: "heroeNotFound")
        }

        self.nameLabel.attributedText = NSAttributedString(string: name, attributes: self.nameAttributes)
    }

    func setUpDescription(_ description: String) {

        self.descriptionLabel.attributedText = NSAttributedString(string: description, attributes: self.descriptionAttributes)
    }

    func addElements(_ type: String, data: [(title: String, description: String)]){

        if data.count <= 0 { return }

        let titleLabel = setLabel()
        titleLabel.attributedText = NSAttributedString(string: type, attributes: self.sectionTitleAttributes)

        var elements: [UILabel] = []
        for elem in data {

            elements.append(addElem(elem.title, elem.description))
        }

        switch type {

        case "Comics":
            self.comicsSection = []
            self.comicsSection.append(titleLabel)
            self.comicsSection.append(contentsOf: elements)

        case "Events":
            self.eventsSection = []
            self.eventsSection.append(titleLabel)
            self.eventsSection.append(contentsOf: elements)

        case "Stories":
            self.eventsSection = []
            self.eventsSection.append(titleLabel)
            self.eventsSection.append(contentsOf: elements)

        case "Series":
            self.seriesSection = []
            self.eventsSection.append(titleLabel)
            self.eventsSection.append(contentsOf: elements)

        default:
            return
        }
    }

    func configureView() {

        self.addSubviews()
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

private extension DetailView {

    func setLabel() -> UILabel {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }

    func addElem(_ title: String, _ description: String) -> UILabel{

        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: title + ": ", attributes: self.elemTitleAttributes))
        text.append(NSAttributedString(string: description, attributes: self.elemDescriptionAttributes))

        let label = setLabel()
        label.attributedText = text

        return label
    }

    func configureStackView() {

        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.spacing = Constants.stackViewDetailViewMarginsConstant
        self.stackView.distribution = .fill
    }

    func defineHeroViewConstraits() {

        self.heroView.translatesAutoresizingMaskIntoConstraints = false

        self.heroView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.heroView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        self.portrait.append(self.heroView.widthAnchor.constraint(equalTo: self.widthAnchor))
        self.portrait.append(self.heroView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: Constants.detailViewContentSeparationMultiplier))

        self.landscape.append(self.heroView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        self.landscape.append(self.heroView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Constants.detailViewContentSeparationMultiplier))
    }

    func defineHeroeImageConstrains() {

        self.heroeImageView.translatesAutoresizingMaskIntoConstraints = false

        self.heroeImageView.leadingAnchor.constraint(equalTo: self.heroView.leadingAnchor).isActive = true
        self.heroeImageView.trailingAnchor.constraint(equalTo: self.heroView.trailingAnchor).isActive = true
        self.heroeImageView.topAnchor.constraint(equalTo: self.heroView.topAnchor).isActive = true
    }

    func defineFavouriteButton() {

        self.favouriteButton.translatesAutoresizingMaskIntoConstraints = false

        self.favouriteButton.topAnchor.constraint(equalTo: self.heroeImageView.layoutMarginsGuide.topAnchor).isActive = true
        self.favouriteButton.trailingAnchor.constraint(equalTo: self.heroeImageView.layoutMarginsGuide.trailingAnchor).isActive = true
        self.favouriteButton.widthAnchor.constraint(equalTo: self.heroeImageView.widthAnchor, multiplier: Constants.favButtonSizeMultiplier).isActive = true
        self.favouriteButton.heightAnchor.constraint(equalTo: self.favouriteButton.widthAnchor).isActive = true
    }

    func defineNameLabelConstrains() {

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false

        self.nameLabel.topAnchor.constraint(equalTo: self.heroeImageView.bottomAnchor, constant: Constants.marginsDetailViewConstant).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.heroeImageView.centerXAnchor ).isActive = true
        self.nameLabel.widthAnchor.constraint(equalTo: self.heroeImageView.widthAnchor).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.heroView.bottomAnchor, constant: -Constants.marginsDetailViewConstant).isActive = true
    }

    func defineScrollViewConstraits() {

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        self.portrait.append(self.scrollView.topAnchor.constraint(equalTo: self.heroView.bottomAnchor, constant: Constants.marginsDetailViewConstant))
        self.portrait.append(self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.marginsDetailViewConstant))

        self.landscape.append(self.scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.marginsDetailViewConstant))
        self.landscape.append(self.scrollView.leadingAnchor.constraint(equalTo: self.heroView.trailingAnchor, constant: Constants.marginsDetailViewConstant))

        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.marginsDetailViewConstant).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.marginsDetailViewConstant).isActive = true
    }

    func defineStackViewConstraits() {

        self.stackView.translatesAutoresizingMaskIntoConstraints = false

        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true

        self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
    }

    func addSubviews() {

        for comic in self.comicsSection {

            self.stackView.addArrangedSubview(comic)
        }

        for event in self.eventsSection {

            self.stackView.addArrangedSubview(event)
        }

        for story in self.storiesSection {

            self.stackView.addArrangedSubview(story)
        }

        for serie in self.seriesSection {

            self.stackView.addArrangedSubview(serie)
        }
    }
}
