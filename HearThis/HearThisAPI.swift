//
//  HearThisAPI.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
public protocol NetworkFetching {
    func get(url: NSURL, parameters: [String:Any],  response: @escaping ((FetchResult<[[String:Any]]>) -> Void))
    func getPlainResponse(url: NSURL, parameters: [String:Any], response: @escaping ((FetchResult<Any>) -> Void))
}

public protocol NetworkConnecting: NetworkFetching {
    
}


public enum FetchError: Error {
    case undefined(String)
}



public enum FetchResult<T> {
    case success(T)
    case error(Error)
}


public protocol HearThisAPIType {
    func fetchArtists(page: Int, numberOfArtists: Int, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void))
    func fetchTracksForArtists(artistPermaLink:String,page: Int, numberOfTracks: Int, fetched:@escaping ((FetchResult<[TrackAPIModel]>) -> Void))
    func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void))

}

public class HearThisAPI: HearThisAPIType {
    
    public init(networkConnector: NetworkConnecting, baseURLString: String = "https://api-v2.hearthis.at/") {
        self.networkConnector = networkConnector
        self.baseURLString = baseURLString
    }
    
    private let networkConnector: NetworkConnecting
    private let baseURLString: String
    public func fetchArtists(page: Int = 0, numberOfArtists: Int = 20, fetched:@escaping ((FetchResult<[ArtistAPIModel]>) -> Void)) {
        networkConnector.get(url: NSURL(string: "\(baseURLString)feed/")!, parameters: ["type": "popular", "page": page, "count": numberOfArtists]) {
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
    
    public func fetchTracksForArtists(artistPermaLink: String, page: Int = 0, numberOfTracks: Int = 20, fetched: @escaping ((FetchResult<[TrackAPIModel]>) -> Void)) {
        let link = baseURLString+artistPermaLink
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
                        let coverArtURL = $0["artwork_url"] as? String,
                        let durationString = $0["duration"] as? String,
                        let duration = Int(durationString),
                        let playCountString = $0["playback_count"] as? String,
                        let playCount = Int(playCountString),
                        let favCountStrig = $0["favoritings_count"] as? String,
                        let favCount = Int(favCountStrig)
                    {
                        var track = TrackAPIModel(id: id, title: title, streamURL: streamURL, coverArtURL: coverArtURL, duration:duration, playCount: playCount, favoriteCount: favCount)
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
    
    public func fetchWaveFormData(_ waveFormURL: String, fetched:@escaping ((FetchResult<WaveFormDataAPIModel>) -> Void)) {
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
