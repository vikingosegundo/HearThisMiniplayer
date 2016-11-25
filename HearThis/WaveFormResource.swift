//
//  WaveFormResourcetype.swift
//  HearThis
//
//  Created by Manuel Meyer on 24.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
import HearThisAPI

protocol WaveFormResourceType: class {
    func waveform(for track: Track, fetched: @escaping (FetchResult<WaveForm>) -> Void)
}

class WaveFormResource: WaveFormResourceType {
    init(hearThisAPI: HearThisAPIType) {
        self.hearThisAPI = hearThisAPI
    }
    
    let hearThisAPI: HearThisAPIType
    
    func waveform(for track: Track, fetched: @escaping (FetchResult<WaveForm>) -> Void) {
        guard let waveFormURL = track.waveFormURL else { return }
        hearThisAPI.fetchWaveFormData(waveFormURL){
            result in
            switch result {
            case .success(let waveAPIModel):
                fetched(.success(WaveForm(with: waveAPIModel)))
            case .error(let error):
                fetched(.error(error))
            }
        }
    }
}
