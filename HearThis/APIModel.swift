//
//  APIModel.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation


struct ArtistAPIModel {
    init(name: String, id: Int, avatarURL: String) {
        self.name = name
        self.id = id
        self.avatarURL = avatarURL
    }
    
    let name: String
    let id: Int
    let avatarURL: String
}
