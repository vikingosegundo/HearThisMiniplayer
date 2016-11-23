//
//  APIModel.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


struct ArtistAPIModel: Hashable {
    init(id: Int, name: String, avatarURL: String, permalink: String) {
        self.name = name
        self.id = id
        self.avatarURL = avatarURL
        self.permalink = permalink
    }
    
    let name: String
    let id: Int
    let avatarURL: String
    let permalink: String
    
    var hashValue: Int {
        return id
    }
    
    static func ==(lhs: ArtistAPIModel, rhs: ArtistAPIModel) -> Bool {
        return lhs.id == rhs.id
    }
}


struct TrackAPIModel {
    init(id: Int, title: String, streamURL: String, coverArtURL: String) {
        self.title = title
        self.id = id
        self.streamURL = streamURL
        self.coverArtURL = coverArtURL
    }
    
    let title: String
    let id: Int
    let streamURL: String
    let coverArtURL: String
    var waveFormDataAPIModel: WaveFormDataAPIModel?

}

struct WaveFormDataAPIModel {
    init(waveFormDataPoints: [Int]) {
        self.waveFormDataPoints = waveFormDataPoints
    }
    
    let waveFormDataPoints: [Int]
}
