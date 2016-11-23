//
//  HearThisAPIMock.swift
//  HearThis
//
//  Created by Manuel Meyer on 22.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation

@testable import HearThis

class HearThisAPIMock: HearThisAPIType {
    
    init(mockedData: [ArtistAPIModel]) {
        self.mockedData = mockedData
    }
    
    let mockedData: [ArtistAPIModel]
    
    func fetchArtists(page: Int = 0, numberOfArtists: Int = 20, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void)) {
        fetched(FetchResult.success(mockedData))
    }
    
    func fetchTracksForArtists(artistPermaLink:String,page: Int, numberOfTracks: Int, fetched:@escaping ((FetchResult<[TrackAPIModel]>) -> Void)) {
    
    }
    func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void)) {
    
    }
}
