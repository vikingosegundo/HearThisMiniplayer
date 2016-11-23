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
    func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void))

}

class HearThisAPI: HearThisAPIType {
    
    init(networkConnector: NetworkConnecting) {
        self.networkConnector = networkConnector
    }
    
    private let networkConnector: NetworkConnecting
    
    func fetchArtists(page: Int = 0, numberOfArtists: Int = 20, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void)) {
        networkConnector.get(url: NSURL(string: "https://api-v2.hearthis.at/feed/")!, parameters: ["type": "popular", "page": page, "count": numberOfArtists]) {
            result in
            
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
                
                fetched(FetchResult.success(NSOrderedSet(array: artists).array as! [ArtistAPIModel]))

            case .error(let error):
                fetched(FetchResult.error(error))
            }
        }
    }
    
    func fetchTracksForArtists(artistPermaLink: String, page: Int = 0, numberOfTracks: Int = 20, fetched: @escaping ((FetchResult<[TrackAPIModel]>) -> Void)) {
        
        let link = "https://api-v2.hearthis.at/"+artistPermaLink
        networkConnector.get(url: NSURL(string: link)!, parameters: ["type":"tracks", "page": page, "count": numberOfTracks]){
            [weak self]
            result in
            guard let `self` = self else { return }
            switch result {
            case .success(let list):
                let tracks: [TrackAPIModel] = list.map{
                    if let idString = $0["id"] as? String,
                        let id = Int(idString),
                        let title = $0["title"] as? String,
                        let streamURL = $0["stream_url"] as? String,
                        let coverArtURL = $0["artwork_url"] as? String
                    {
                        var track = TrackAPIModel(id: id, title: title, streamURL: streamURL, coverArtURL: coverArtURL)
                        if let waveFormURL = $0["waveform_data"] as? String{
                        self.fetchWaveFormData(waveFormURL, fetched: {
                            (result) in
                            switch result {
                            case .success(let waveform):
                                track.waveFormDataAPIModel = waveform
                            case .error(let error):
                                print(error.localizedDescription)
                            }
                        })
                    }
                            return track
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
    
    func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void)) {
        if let url = NSURL(string: waveFormURL) {
            networkConnector.getPlainResponse(url: url, parameters: [:], response: {
                result in
                switch result {
                case .success(let value):
                    if let array = value as? [Int] {
                        fetched(FetchResult.success(WaveFormDataAPIModel(waveFormDataPoints: array)))
                    } else {
                        fetched(FetchResult.error(FetchError.undefined("datapoints wrong format")))
                    }
                case .error(let error):
                    fetched(FetchResult.error(error))
                }
            })
        }
    }
    
}
