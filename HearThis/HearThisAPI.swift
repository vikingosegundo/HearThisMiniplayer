//
//  HearThisAPI.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation

protocol HearThisAPIType {
    func fetchArtists(page: Int, numberOfArtists: Int, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void))
}

class HearThisAPI: HearThisAPIType {
    
    init(networkConnector: NetworkConnecting) {
        self.networkConnector = networkConnector
    }
    
    private let networkConnector: NetworkConnecting
    
    func fetchArtists(page: Int = 0, numberOfArtists: Int = 20, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void)) {
        networkConnector.get(url: NSURL(string: "https://api-v2.hearthis.at/feed/")!, parameters: ["type": "popular", "page": page, "count": numberOfArtists]) {
            result -> Void in
            
            switch result {
            case .success(let list):
                let artists: [ArtistAPIModel] = list
                    .filter{$0["user"] != nil}
                    .map{$0["user"]! as! [String:Any]}
                    .map{
                        artistsDict in
                        if let username = artistsDict["username"] as? String,
                            let avatarURL = artistsDict["avatar_url"] as? String,
                            let idString = artistsDict["id"]! as? String ,
                            let id = Int(idString){
                            return ArtistAPIModel(name: username, id:id, avatarURL:avatarURL)
                        }
                        return nil
                    }
                    .filter { $0 != nil }
                    .map{ $0! }
                fetched(FetchResult.success(artists))

            case .error(let error):
                fetched(FetchResult.error(error))
            }
        }
    }
}
