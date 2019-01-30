//
//  DetailViewControllerDataSource.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 30/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import Foundation

protocol HeroeDetailViewControllerDataSourceProtocol: class {

    func description(_ : HeroeDetailViewControllerDataSource?, _ description: String?, error: Error?)
    func finishDataRetrieve(_ : HeroeDetailViewControllerDataSource?,
                            _ comics: [(title: String, description: String)]?,
                            _ events: [(title: String, description: String)]?,
                            _ stories: [(title: String, description: String)]?,
                            _ series: [(title: String, description: String)]?,
                            error: Error?)
}

class HeroeDetailViewControllerDataSource {

    weak var delegate: HeroeDetailViewControllerDataSourceProtocol?

    private var id: String
    private var numberOfItems = 3
    private var comics: [(title: String, description: String)] = []
    private var events: [(title: String, description: String)] = []
    private var stories: [(title: String, description: String)] = []
    private var series: [(title: String, description: String)] = []

    init(_ id: String) {

        self.id = id
    }

    func requestForHeroeData() {

        MarvelApi.request(decodingType: DataWrapper<Character>.self,
                          requests: .character(id: self.id)) { [weak self] character in

            if let character = character?.data?.results?.first {

                DispatchQueue.main.async {

                    self?.delegate?.description(self, character.description, error: nil)
                }

                self?.resetDataArrays()
                let group = DispatchGroup()

                if let comics = character.comics?.items {

                    _ = comics.prefix(self?.numberOfItems ?? 0).map {

                        group.enter()
                        self?.requestForElementData(DataWrapper<Comic>.self ,$0.resourceURI, { comic in

                            if let comic = comic?.data?.results?.first {

                                self?.comics.append((title: comic.title ?? "", description: comic.description ?? ""))
                            }

                            group.leave()
                        })
                    }
                }

                if let events = character.events?.items {

                    _ = events.prefix(self?.numberOfItems ?? 0).map {

                        group.enter()
                        self?.requestForElementData(DataWrapper<Event>.self ,$0.resourceURI) { event in

                            if let event = event?.data?.results?.first {

                                self?.events.append((title: event.title ?? "", description: event.description ?? ""))
                            }

                            group.leave()
                        }
                    }
                }

                if let stories = character.stories?.items {

                    _ = stories.prefix(self?.numberOfItems ?? 0).map {

                        group.enter()
                        self?.requestForElementData(DataWrapper<Story>.self ,$0.resourceURI) { story in

                            if let story = story?.data?.results?.first {

                                self?.stories.append((title: story.title ?? "", description: story.description ?? ""))
                            }

                            group.leave()
                        }
                    }
                }

                if let series = character.series?.items {

                    _ = series.prefix(self?.numberOfItems ?? 0).map {

                        group.enter()
                        self?.requestForElementData(DataWrapper<Series>.self, $0.resourceURI) { serie in

                            if let serie = serie?.data?.results?.first {

                                self?.series.append((title: serie.title ?? "", description: serie.description ?? ""))
                            }

                            group.leave()
                        }
                    }
                }

                group.notify(queue: .main) { [weak self] in

                    self?.delegate?.finishDataRetrieve(self, self?.comics, self?.events, self?.stories, self?.series, error: nil)
                }
            }
        }
    }


}

private extension HeroeDetailViewControllerDataSource {

    func resetDataArrays() {

        self.comics = []
        self.events = []
        self.stories = []
        self.series = []
    }

    func requestForElementData<T: Codable>(_ decodingType: T.Type,
                                           _ urlString: String?,
                                           _ completionHandler: @escaping (T?) -> Void) {

        guard let urlString = urlString, let url = MarvelUrl.urlCreate(urlString) else { return }

        print(url)

        MarvelApi.request(decodingType: decodingType, url: url ) { data in

            completionHandler(data)
        }
    }
}


