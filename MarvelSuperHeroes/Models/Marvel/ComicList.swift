//
//  ComicList.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct ComicList: Codable {
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [Summary]?
}
