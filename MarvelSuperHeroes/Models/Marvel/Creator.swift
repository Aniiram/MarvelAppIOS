//
//  Creator.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 29/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct Creator: Codable {

    let id: Int?
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let suffix: String?
    let fullName: String?
    let modified: Date?
    let resourceURI: String?
    let urls: [Url]?
    let thumbnail: Image?
    let series: SeriesList?
    let stories: StoryList?
    let comics: ComicList?
    let events: EventList?
}
