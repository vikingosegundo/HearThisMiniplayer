//
//  ArtistsResourceSpec.swift
//  HearThis
//
//  Created by Manuel Meyer on 25.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Quick
import Nimble
@testable import HearThis
import HearThisAPI


class ArtistsResourceSpec: QuickSpec {
    var sut: ArtistsResource!
    
    override func spec() {
        
        
        context("ArtistsResource"){
            beforeEach{
                self.sut = ArtistsResource(hearThisAPI: ArtistsHearThisAPIMock(mockedData:
                    [
                        ArtistAPIModel(id: 23, name: "Tiffy", avatarURL: "https://tiffy.com", permalink: "tiffy"),
                        ArtistAPIModel(id: 13, name: "Herr von Blödefeld", avatarURL: "https://bloedefeld.com", permalink: "bloedefeld")
                    ]
                    )
                )
            }
        
            it("acesses top artists"){
                var artitsts: [Artist]?
                self.sut.topArtists {
                    result in
                    
                    switch result {
                    case .success(let list):
                        artitsts = list
                    case .error:
                        break
                    }
                }
                expect(artitsts?.count).to(equal(2))
            }
        }
    }
}
