//
//  APIModel.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


public struct ArtistAPIModel: Hashable {
    public init(id: Int, name: String, avatarURL: String, permalink: String) {
        self.name = name
        self.id = id
        self.avatarURL = avatarURL
        self.permalink = permalink
    }
    
    public let name: String
    public let id: Int
    public let avatarURL: String
    public let permalink: String
    
    public var hashValue: Int {
        return id
    }
    
     public static func ==(lhs: ArtistAPIModel, rhs: ArtistAPIModel) -> Bool {
        return lhs.id == rhs.id
    }
}


public struct TrackAPIModel {
    init(id: Int, title: String, streamURL: String, coverArtURL: String, duration: Int, playCount: Int, favoriteCount:Int) {
        self.title = title
        self.id = id
        self.streamURL = streamURL
        self.coverArtURL = coverArtURL
        self.duration = duration
        self.playCount = playCount
        self.favoriteCount = favoriteCount
    }
    
    public let title: String
    public let id: Int
    public let streamURL: String
    public let coverArtURL: String
    public let duration: Int
    public let playCount: Int
    public let favoriteCount:Int
    public var waveFormDataAPIModel: WaveFormDataAPIModel?

}

public struct WaveFormDataAPIModel {
   public init(waveFormDataPoints: [Int]) {
        self.waveFormDataPoints = waveFormDataPoints
    }
    
   public let waveFormDataPoints: [Int]
}
