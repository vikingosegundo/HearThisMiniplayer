//
//  Track.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
import HearThisAPI

class Track: NSObject {
    init(fromAPIModel apiModel: TrackAPIModel) {
        id = apiModel.id
        title = apiModel.title
        streamURL = apiModel.streamURL
        coverArtURL = apiModel.coverArtURL
        duration = apiModel.duration
        playCount = apiModel.playCount
        favoriteCount = apiModel.favoriteCount
        waveFormURL = apiModel.waveFormURL
        
    }
    
    let title: String
    let id: Int
    let streamURL: String
    let coverArtURL: String
    let duration: Int
    let playCount: Int
    let favoriteCount:Int
    var waveFormURL: String?
}
