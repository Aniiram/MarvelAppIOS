//
//  Story.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 29/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct Story: Codable {

    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let type: String?
    let modified: Date?
    let thumbnail: Image?
    let comics: ComicList?
    let series: SeriesList?
    let events: EventList?
    let characters: CharacterList?
    let creators: CreatorList?
    let originalissue: Summary?
}
