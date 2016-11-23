//
//  Track.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation

class Track: NSObject {
    init(fromAPIModel apiModel: TrackAPIModel) {
        id = apiModel.id
        title = apiModel.title
        streamURL = apiModel.streamURL
        coverArtURL = apiModel.coverArtURL
    }
    
    let title: String
    let id: Int
    let streamURL: String
    let coverArtURL: String
}
