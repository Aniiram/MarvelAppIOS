//
//  FavouritesHandler.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 16/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

final class FavouritesHelper {

    static func favourites() -> [String: [String]]? {
        
        return UserDefaults.standard.dictionary(forKey: "userFavourites") as? [String: [String]]
    }

    static func addFavourite(_ id: String,
                             _ name: String,
                             _ imageUrl: String){

        var newFavourites = [String: [String]]()
        if let favourites = self.favourites() {

            newFavourites = favourites
        }

        newFavourites[id] = [name, imageUrl]
        UserDefaults.standard.set(newFavourites, forKey: "userFavourites")
    }

    static func removeFavourite(_ id: String) {

        if let favourites = self.favourites() {

            var newFavourites = favourites
            newFavourites.removeValue(forKey: id)

            UserDefaults.standard.set(newFavourites, forKey: "userFavourites")
        }
    }

    static func isFavourite(_ id: String) -> Bool {

        if let favourites = self.favourites() {

            return favourites.keys.contains(id)
        }
        
        return false
    }
}
