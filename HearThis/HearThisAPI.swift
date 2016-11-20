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
    func fetchTracksForArtists(artistPermaLink:String,page: Int, numberOfTracks: Int, fetched:@escaping ((FetchResult<[TrackAPIModel]>) -> Void))
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
                            let id = Int(idString),
                            let permalink = artistsDict["permalink"]! as? String{
                            return ArtistAPIModel(id:id, name: username, avatarURL:avatarURL, permalink: permalink)
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
    
    func fetchTracksForArtists(artistPermaLink: String, page: Int = 0, numberOfTracks: Int = 20, fetched: @escaping ((FetchResult<[TrackAPIModel]>) -> Void)) {
        
        let link = "https://api-v2.hearthis.at/"+artistPermaLink
        networkConnector.get(url: NSURL(string: link)!, parameters: ["type":"tracks", "page": page, "count": numberOfTracks]){
            result in
            switch result {
            case .success(let list):
                let tracks: [TrackAPIModel] = list.map{
                    if let idString = $0["id"] as? String,
                        let id = Int(idString),
                        let title = $0["title"] as? String,
                        let streamURL = $0["stream_url"] as? String{
                            return TrackAPIModel(id: id, title: title, streamURL: streamURL)
                    }
                    return nil
                }
                    .filter { $0 != nil }
                    .map{ $0! }
                fetched(FetchResult.success(tracks))

            case .error(let error):
                fetched(FetchResult.error(error))
            }
        }
    }
}
