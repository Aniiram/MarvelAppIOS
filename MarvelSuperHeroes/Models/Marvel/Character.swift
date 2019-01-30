//
//  MarvelCharacter.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 25/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct Character: Codable {

    let id: Int?
    let name: String?
    let description: String?
    let modified: Date?
    let resourceURI: String?
    let urls: [Url]?
    let thumbnail: Image?
    let comics: ComicList?
    let stories: StoryList?
    let events: EventList?
    let series: SeriesList?
}
