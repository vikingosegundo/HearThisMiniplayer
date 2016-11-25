
//  WaveFormResourceSpec.swift
//  HearThis
//
//  Created by Manuel Meyer on 25.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Quick
import Nimble
@testable import HearThis
import HearThisAPI


class WaveFormResourceSpec: QuickSpec {
    var sut: WaveFormResource!
    
    override func spec() {
        context("WaveFormResource"){
            
            beforeEach{
                self.sut = WaveFormResource(hearThisAPI: WaveFormHearThisAPIMock())
            }
            
            it("fetches data for given url"){
                
                var fetchedWaveForm: WaveForm?
                
                let track = Track(fromAPIModel: TrackAPIModel(id: 1, title: "ik mutt gor nix", streamURL: "", coverArtURL: "", duration: 3, playCount: 1, favoriteCount: 1))
                track.waveFormURL = "https://waveform.url"
                self.sut.waveform(for: track){
                    result in
                    
                    switch result {
                    case .success(let waveForm):
                        fetchedWaveForm = waveForm
                    case .error:
                        break
                    }
                }
                
                expect(fetchedWaveForm?.waveFormDataPoints.count).toEventually(equal(3))
            }
            
            
            it("yields error for not given url"){
                
                var fetchedWaveForm: WaveForm?
                var error: Error?
                let track = Track(fromAPIModel: TrackAPIModel(id: 1, title: "ik mutt gor nix", streamURL: "", coverArtURL: "", duration: 3, playCount: 1, favoriteCount: 1))

                self.sut.waveform(for: track){
                    result in
                    
                    switch result {
                    case .success(let waveForm):
                        fetchedWaveForm = waveForm
                    case .error(let e):
                        error = e
                    }
                }
                
                expect(error).toEventuallyNot(beNil())
                expect(fetchedWaveForm).toEventually(beNil())

            }
        }
    }
}
