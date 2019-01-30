//
//  Image.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct Image: Codable {
    
    let path: String?
    let imgExtension: String?

    private enum CodingKeys: String, CodingKey {
        case path
        case imgExtension = "extension"
    }
}
