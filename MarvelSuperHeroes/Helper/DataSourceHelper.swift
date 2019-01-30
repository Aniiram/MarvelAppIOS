//
//  DataSourceHelper.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 03/12/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

final class DataSourceHelper {

    static func digestData(_ characters: [Character]) -> [(id: String, name: String, url: String)] {

        var heroesData: [(id: String, name: String, url: String)] = []

        for character in characters {

            let id = String(character.id ?? 0)
            let name = character.name ?? ""
            var imgUrl = ""

            if let imgPath = character.thumbnail?.path, let imgExt = character.thumbnail?.imgExtension {

                imgUrl = imgPath + "." + imgExt
            }

            heroesData.append((id: id, name: name, url: imgUrl))
        }

        return heroesData
    }

    static func digestData(_ characters: [String: [String]]) -> [(id: String, name: String, url: String)] {

        var heroesData: [(id: String, name: String, url: String)] = []

        for character in characters {

            heroesData.append((id: character.key, name: character.value[0], url: character.value[1]))
        }

        return heroesData
    }
}
