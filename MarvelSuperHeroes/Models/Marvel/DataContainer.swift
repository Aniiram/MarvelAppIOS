//
//  CharacterDataContainer.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct DataContainer<T: Codable>: Codable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [T]?
}
