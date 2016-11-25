//
//  TrackResourceSpec.swift
//  HearThis
//
//  Created by Manuel Meyer on 25.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Quick
import Nimble
@testable import HearThis
import HearThisAPI


class TrackResourceSpec: QuickSpec {
    var sut: TrackResource!
    
    override func spec() {
        
        
        context("TrackResource"){
            beforeEach{
                self.sut = TrackResource(hearThisAPI: TrackHearThisAPIMock(mockedData:
                    [
                        TrackAPIModel(id:1, title:"Ik mutt gor nix", streamURL:"", coverArtURL: "", duration: 300, playCount: 11, favoriteCount:2)
                    ])
                )
            }
            
            it("accesses artist's tracks"){
            
                var tracks: [Track]?
                self.sut.tracksForArtist(Artist(fromAPIModel: ArtistAPIModel(id: 23, name: "Tiffy", avatarURL: "https://tiffy.com", permalink: "tiffy"))){
                    result in
                    
                    switch result {
                    case .success(let list):
                        tracks = list
                    case .error:
                        break
                    }
                
                }
                
                expect(tracks?.count).to(equal(1))
                expect(tracks?[0].title).to(equal("Ik mutt gor nix"))
            }
            
            
        }
    }
}
