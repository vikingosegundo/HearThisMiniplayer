//
//  HearThisAPIMock.swift
//  HearThis
//
//  Created by Manuel Meyer on 22.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
import HearThisAPI
@testable import HearThis

class ArtistsHearThisAPIMock: HearThisAPIType {
    
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


class TrackHearThisAPIMock: HearThisAPIType {
    
    init(mockedData: [TrackAPIModel]) {
        self.mockedData = mockedData
    }
    
    let mockedData: [TrackAPIModel]
    
    func fetchArtists(page: Int = 0, numberOfArtists: Int = 20, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void)) {
    }
    
    func fetchTracksForArtists(artistPermaLink:String,page: Int, numberOfTracks: Int, fetched:@escaping ((FetchResult<[TrackAPIModel]>) -> Void)) {
        fetched(FetchResult.success(mockedData))
        
    }
    func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void)) {
        
    }
}


class WaveFormHearThisAPIMock: HearThisAPIType {
    
    init() {
        
    }
    
    
    func fetchArtists(page: Int = 0, numberOfArtists: Int = 20, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void)) {
    }
    
    func fetchTracksForArtists(artistPermaLink:String,page: Int, numberOfTracks: Int, fetched:@escaping ((FetchResult<[TrackAPIModel]>) -> Void)) {
        
    }
    func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void)) {
        fetched(.success(WaveFormDataAPIModel(waveFormDataPoints: [128, 255, 217])))
    }
}
