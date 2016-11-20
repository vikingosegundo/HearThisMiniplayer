//
//  APIModel.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


struct ArtistAPIModel {
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
}


struct TrackAPIModel {
    init(id: Int, title: String, streamURL: String) {
        self.title = title
        self.id = id
        self.streamURL = streamURL
    }
    
    let title: String
    let id: Int
    let streamURL: String
}
