//
//  CharacterDataWrapper.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct DataWrapper<T: Codable>: Codable {
    
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: DataContainer<T>?
    let etag: String?
}
