//
//  File.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 30/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

enum MarvelRequests {

    case characters (parameters: [MarvelQueryParameters])
    case character (id: String)
    case characterComics (id: String, parameters: [MarvelQueryParameters])
    case characterEvents (id: String, parameters: [MarvelQueryParameters])
    case characterSeries (id: String, parameters: [MarvelQueryParameters])
    case characterStories (id: String, parameters: [MarvelQueryParameters])
    case comics (parameters: [MarvelQueryParameters])
    case comic (id: String)
    case comicCharacters (id: String, parameters: [MarvelQueryParameters])
    case comicCreators (id: String, parameters: [MarvelQueryParameters])
    case comicEvents (id: String, parameters: [MarvelQueryParameters])
    case comicStories (id: String, parameters: [MarvelQueryParameters])
    case events (parameters: [MarvelQueryParameters])
    case event (id: String)
    case eventCharacters (id: String, parameters: [MarvelQueryParameters])
    case eventComics (id: String, parameters: [MarvelQueryParameters])
    case eventSeries (id: String, parameters: [MarvelQueryParameters])
    case eventStories (id: String, parameters: [MarvelQueryParameters])

    func toString() -> (path: String, queries: [URLQueryItem]) {

        switch self {

        case .character(let id): return (path: "characters/" + id, queries: [])
        case .comic(let id): return (path: "comics/" + id, queries: [])
        case .event(let id): return (path: "events/" + id, queries: [])
        case .characters(let parameters): return (path: "characters", queries: parameters.map() { $0.checkParam() } )
        case .comics(let parameters): return (path: "comics", queries: parameters.map() { $0.checkParam() })
        default: break
        }

        return (path: "", queries: [])
    }
}
