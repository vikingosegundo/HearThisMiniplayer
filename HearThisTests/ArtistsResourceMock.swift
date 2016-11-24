//
//  ArtistsResourceMock.swift
//  HearThis
//
//  Created by Manuel Meyer on 22.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

@testable import HearThis
import HearThisAPI

class  ArtistsResourceMock: ArtistsResourceType {
    
    init(artists: [Artist]){
        self.artists = artists
    }
    
    let artists: [Artist]
    
    func topArtists(topArtistsFetched: @escaping (FetchResult<[Artist]>) -> Void) {
            topArtistsFetched(FetchResult.success(artists))
    }
}
