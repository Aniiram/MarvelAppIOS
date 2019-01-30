//
//  favourites.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 16/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

extension UIButton {

    static func favoriteButton() -> UIButton {

        let button = UIButton()

        button.setBackgroundImage(UIImage(named: "icon_normal")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setBackgroundImage(UIImage(named: "icon_fav")?.withRenderingMode(.alwaysTemplate), for: .selected)
        button.tintColor = #colorLiteral(red: 0.9294117647, green: 0.1137254902, blue: 0.1411764706, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
}
