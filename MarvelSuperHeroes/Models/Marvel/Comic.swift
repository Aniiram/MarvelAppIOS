//
//  Comic.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 27/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

struct Comic: Codable {

    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: Double?
    let variantDescription: String?
    let description: String?
    let modified: Date?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String
    let issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [Url]?
    let series: Summary?
    let variants: [Summary]?
    let collections: [Summary]?
    let collectedIssues: [Summary]?
    let dates: [ComicDate]?
    let prices: [ComicPrice]?
    let thumbnail: Image?
    let images: [Image]?
    let creators: CreatorList?
    let characters: CharacterList?
    let stories: StoryList?
    let events: EventList?
}
