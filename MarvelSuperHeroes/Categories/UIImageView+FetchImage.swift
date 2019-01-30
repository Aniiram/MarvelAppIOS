//
//  MyUIImageView.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 12/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

extension UIImageView {

    func setSpinner() -> UIActivityIndicatorView {

        let spinner = UIActivityIndicatorView()
        spinner.color = #colorLiteral(red: 0.9294117647, green: 0.1137254902, blue: 0.1411764706, alpha: 1)
        spinner.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        return spinner
    }

    func fetchImage(_ url: URL?) {

        if let url = url {

            let spinner = setSpinner()
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in

                let urlContents = try? Data(contentsOf: url)

                DispatchQueue.main.async {

                    if let imageData = urlContents {

                        self?.image = UIImage(data: imageData)
                        spinner.stopAnimating()
                    }
                }
            }
        }
    }
}
