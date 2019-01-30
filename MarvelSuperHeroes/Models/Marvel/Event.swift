//
//  Event.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct Event: Codable {

    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [Url]?
    let modified: Date?
    let start: Date?
    let end: Date?
    let thumbnail: Image?
    let comics: ComicList?
    let stories: StoryList?
    let series: SeriesList?
    let characters: CharacterList?
    let creators: CreatorList?
    let next: Summary?
    let previous: Summary?
}
