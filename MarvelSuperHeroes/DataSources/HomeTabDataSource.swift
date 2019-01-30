//
//  HomeTabDataSource.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 29/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

protocol HomeTabDataSourceProtocol: class {

    func heroesData(_ : HomeTabDataSource?, _ heroesData: [(id: String, name: String, url: String)]?, error: Error?)
}

class HomeTabDataSource {

    weak var delegate: HomeTabDataSourceProtocol?

    private var offset: Int
    private var totalOfHeroesThatCanBeCalled: Int

    init(offset: Int = 0) {

        self.offset = offset
        self.totalOfHeroesThatCanBeCalled = offset
    }

    func requestForHeroes() {

        if self.totalOfHeroesThatCanBeCalled < self.offset {

            return
        }

        let oldOffset = self.offset

        MarvelApi.request(decodingType: DataWrapper<Character>.self,
                          requests: .characters(parameters: [.orderBy(orderBy: Constants.orderHeroesListBy),
                                                             .limit(limit: Constants.numberOfCharactersPerRequest),
                                                             .offset(offset: offset)]))
        { [weak self] characters in

            if oldOffset == self?.offset, let total = characters?.data?.total, let characters = characters?.data?.results {

                let heroesData = DataSourceHelper.digestData(characters)

                self?.totalOfHeroesThatCanBeCalled = total
                self?.offset += heroesData.count

                DispatchQueue.main.async {

                    self?.delegate?.heroesData(self, heroesData, error: nil)
                }
            }
        }
    }
}
