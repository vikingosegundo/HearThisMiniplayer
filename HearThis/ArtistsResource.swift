//
//  ArtistsResource.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


protocol ArtistsResourceType: class {
    func topArtists(topArtistsFetched: @escaping (FetchResult<[Artist]>) -> Void)
}


class ArtistsResource: ArtistsResourceType {

    init(hearThisAPI: HearThisAPIType) {
        self.hearThisAPI = hearThisAPI
    }

    private let hearThisAPI: HearThisAPIType
    private var _topArtists: [Artist] = []
    private let batchSize = 20
    
    func topArtists(topArtistsFetched: @escaping (FetchResult<[Artist]>) -> Void) {
        if _topArtists.count < 1 {
            hearThisAPI.fetchArtists(page: 0, numberOfArtists: batchSize, fetched: {
                [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .success(let apiArtists):
                    self._topArtists = apiArtists.map{ Artist(fromAPIModel: $0) }
                    topArtistsFetched(FetchResult.success(self._topArtists))
                case .error(let error):
                    topArtistsFetched(FetchResult.error(error))
                }
            })
        } else {
            topArtistsFetched(FetchResult.success(self._topArtists))
        }
    }
}
