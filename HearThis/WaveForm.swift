//
//  Wave.swift
//  HearThis
//
//  Created by Manuel Meyer on 24.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
import HearThisAPI

class WaveForm: NSObject {
    init(with apiModel:WaveFormDataAPIModel) {
        waveFormDataPoints = apiModel.waveFormDataPoints
    }
    let waveFormDataPoints: [Int]

}
