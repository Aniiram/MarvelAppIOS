//
//  MarvelURL.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 30/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//
//
import Foundation

final class MarvelUrl {

    private static var publicKey = "f1c938178b8bc789bf25cf7695ed5191"
    private static var privateKey = "ae2eee5c09746dd77374d4225a5a7ed5bbf5ae06"

    static func urlCreate(_ requests: MarvelRequests) -> URL? {

        guard let urlCompletion = urlCompletion() else { return nil }

        let requestsDigested = requests.toString()

        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"

        components.path = "/v1/public/" + requestsDigested.path
        components.queryItems = requestsDigested.queries + urlCompletion

        return components.url
    }

    static func urlCreate(_ url: String) -> URL? {

        var components = URLComponents(string: url)
        components?.queryItems = urlCompletion()

        return components?.url
    }
}

private extension MarvelUrl {

    static func urlCompletion() -> [URLQueryItem]? {

        let timeStamp = Date().timeIntervalSince1970.description

        guard let hash = (timeStamp + self.privateKey + self.publicKey).MD5() else {

            return nil
        }

        return [ URLQueryItem(name: "ts", value: timeStamp),
                 URLQueryItem(name: "apikey", value: self.publicKey),
                 URLQueryItem(name: "hash", value: hash)]
    }
}
