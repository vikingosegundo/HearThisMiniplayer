//
//  TrackResource.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


protocol TrackResourceType {
    func tracksForArtist(_ artist:Artist, fetched: @escaping (FetchResult<[Track]>) -> Void)
}

class TrackResource: TrackResourceType {

    init(hearThisAPI: HearThisAPIType) {
        self.hearThisAPI = hearThisAPI
    }
    
    private let hearThisAPI: HearThisAPIType

    func tracksForArtist(_ artist: Artist, fetched: @escaping (FetchResult<[Track]>) -> Void) {
        self.hearThisAPI.fetchTracksForArtists(artistPermaLink: artist.permalink, page: 0, numberOfTracks: 20){
            result in
            switch result {
            case .success(let list):
                fetched(FetchResult.success(list.map{ Track(fromAPIModel: $0)}))
            case .error(let error):
                fetched(FetchResult.error(error))
            }
        }
    }
}
