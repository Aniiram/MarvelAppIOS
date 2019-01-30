//
//  Series.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct Series: Codable {

    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [Url]?
    let startYear: Int?
    let endYear: Int?
    let rating: String?
    let modified: Date?
    let thumbnail: Image?
    let comics: ComicList?
    let stories: StoryList?
    let events: EventList?
    let characters: CharacterList?
    let creators: CreatorList?
    let next: Summary?
    let previous: Summary?
}
