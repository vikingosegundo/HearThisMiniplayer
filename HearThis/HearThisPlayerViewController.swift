//
//  HearThisPlayerViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class HearThisPlayerViewController: UIViewController, HearThisPlayerHolder, HearThisPlayerObserver {
    var hearThisPlayer: HearThisPlayerType? {
        didSet{
            hearThisPlayer?.registerObserver(observer: self)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!

    deinit {
        hearThisPlayer?.removeObserver(observer: self)
    }
    
    func player(_ player: HearThisPlayerType, willStartPlaying track: Track) {
        titleLabel.text = "loading \(track.title)"
    }
    
    func player(_ player: HearThisPlayerType, didStartPlaying track: Track) {
        titleLabel.text = track.title
    }
    
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track) {
        titleLabel.text = nil
    }
}
