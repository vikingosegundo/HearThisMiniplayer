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
    func fetchArtists(page: Int = 0, numberOfArtists: Int = 20, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void)) {
        
        let artists = [
            ArtistAPIModel(id: 23, name: "Tiffy", avatarURL: "https://tiffy.com", permalink: "tiffy"),
            ArtistAPIModel(id: 13, name: "Herr von Blödefeld", avatarURL: "https://bloedefeld.com", permalink: "bloedefeld")
        ]
        
        fetched(FetchResult.success(artists))
    }
    
    func fetchTracksForArtists(artistPermaLink:String,page: Int, numberOfTracks: Int, fetched:@escaping ((FetchResult<[TrackAPIModel]>) -> Void)) {
    
    }
    func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void)) {
    
    }
}
