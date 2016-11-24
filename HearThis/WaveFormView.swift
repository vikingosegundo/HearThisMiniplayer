//
//  WaveView.swift
//  HearThis
//
//  Created by Manuel Meyer on 24.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class WaveFormView: UIImageView {

    var waveForm: WaveForm? {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
}
