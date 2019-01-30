//
//  MarvelApiCall.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 26/10/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation
import CommonCrypto

final class MarvelApi {

    private static var defaultSession = URLSession(configuration: .default)

    static func request<T:Codable>(decodingType: T.Type, requests: MarvelRequests, completionHandler completion: @escaping (T?)->Void) {

        guard let url = MarvelUrl.urlCreate(requests) else {

            return
        }

        print(url)

        request(decodingType: decodingType, url: url, completionHandler: completion)
    }

    static func request<T:Codable>(decodingType: T.Type, url: URL, completionHandler completion: @escaping (T?)->Void) {

        weak var dataTask = self.defaultSession.dataTask(with: url) { data, response, error in

            guard let response = response as? HTTPURLResponse else {

                print("No response!")
                return
            }

            if let error = error {

                print("Error code: " + String(response.statusCode))
                print("DataTask error: " + error.localizedDescription + "\n")

            } else if let data = data, response.statusCode == 200 {

                print("Parsing data...")

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                if let decodedData = try? decoder.decode(decodingType, from: data){

                    completion(decodedData)

                } else {

                    completion(nil)
                }
            }
        }
        dataTask?.resume()
    }

    static func toFile (_ data: Data, file name: String) {

        if let urlDisk = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true).appendingPathComponent(name) {

            do{

                try data.write(to: urlDisk)
                print("save successfully!")

            } catch let error {

                print("couldn't save \(error)")
            }
        }
    }
}

