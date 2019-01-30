//
//  SearchTabDataSource.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 03/12/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

protocol SearchTabDataSourceProtocol: class {

    func heroesDataAdd(_ : SearchTabDataSource?, _ heroesData: [(id: String, name: String, url: String)]?, error: Error?)
    func heroesDataSetUp(_: SearchTabDataSource?, _ heroesData: [(id: String, name: String, url: String)]?, error: Error?)
}

class SearchTabDataSource {

    weak var delegate: SearchTabDataSourceProtocol?

    private var offset = 0
    private var totalOfHeroesThatCanBeCalled = 0
    private var text = ""

    func requestForHeroes(_ text: String) {

        self.text = text
        self.offset = 0
        self.totalOfHeroesThatCanBeCalled = 0

        let oldOffset = self.offset

        MarvelApi.request(decodingType: DataWrapper<Character>.self,
                          requests: .characters(parameters: [.nameStartsWith(name: text),
                                                             .orderBy(orderBy: Constants.orderHeroesListBy),
                                                             .limit(limit: Constants.numberOfCharactersPerRequest),
                                                             .offset(offset: offset)]))
        { [weak self] characters in

            if text != self?.text { return }

            if oldOffset == self?.offset, let total = characters?.data?.total, let characters = characters?.data?.results {

                let heroesData = DataSourceHelper.digestData(characters)

                self?.totalOfHeroesThatCanBeCalled = total
                self?.offset += heroesData.count

                DispatchQueue.main.async {

                    self?.delegate?.heroesDataSetUp(self, heroesData, error: nil)
                }

            } else {

                DispatchQueue.main.async {

                    self?.delegate?.heroesDataSetUp(self, nil, error: nil)
                }
            }
        }
    }

    func requestForHeroes() {

        if self.totalOfHeroesThatCanBeCalled <= self.offset && self.totalOfHeroesThatCanBeCalled != 0 {

            return
        }

        let oldOffset = self.offset

        MarvelApi.request(decodingType: DataWrapper<Character>.self,
                          requests: .characters(parameters: [.nameStartsWith(name: text),
                                                             .orderBy(orderBy: Constants.orderHeroesListBy),
                                                             .limit(limit: Constants.numberOfCharactersPerRequest),
                                                             .offset(offset: offset)]))
        { [weak self] characters in

            if oldOffset == self?.offset, let total = characters?.data?.total, let characters = characters?.data?.results {

                let heroesData = DataSourceHelper.digestData(characters)

                self?.totalOfHeroesThatCanBeCalled = total
                self?.offset += heroesData.count

                DispatchQueue.main.async {

                    self?.delegate?.heroesDataAdd(self, heroesData, error: nil)
                }
            }
        }
    }
}
