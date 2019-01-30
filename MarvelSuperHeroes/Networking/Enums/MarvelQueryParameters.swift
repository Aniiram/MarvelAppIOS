//
//  MarvelQueryParameters.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 30/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

enum MarvelQueryParameters {
    
    case orderBy (orderBy: MarvelOrderByOptions)
    case limit (limit: Int)
    case offset (offset: Int)
    case nameStartsWith (name: String)

    func checkParam () -> URLQueryItem {

        switch self {

        case .orderBy (let orderBy): return URLQueryItem(name: "orderBy", value: orderBy.rawValue)
        case .limit(let limit): return URLQueryItem(name: "limit", value: String(limit))
        case .offset(let offset): return URLQueryItem(name: "offset", value: String(offset))
        case .nameStartsWith(let name): return URLQueryItem(name: "nameStartsWith", value: name)
        }
    }
}
