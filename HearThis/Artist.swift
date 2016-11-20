//
//  Artist.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


class Artist: NSObject {
    init(fromAPIModel artistsAPIModel: ArtistAPIModel) {
        username = artistsAPIModel.name
        id = artistsAPIModel.id
        avatarURLString = artistsAPIModel.avatarURL
        permalink = artistsAPIModel.permalink
    }
    
    let username: String
    let id: Int
    let avatarURLString: String
    let permalink: String
}
