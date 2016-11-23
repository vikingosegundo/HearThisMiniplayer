//
//  HearThisPlayerViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class HearThisPlayerViewController: UIViewController, HearThisPlayerHolder  {
    var hearThisPlayer: HearThisPlayerType? {
        didSet{
            hearThisPlayer?.registerObserver(observer: self)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet{
            titleLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var playButton: HearThisPlayerButton! {
        didSet{
            playButton.addTarget(self, action: #selector(HearThisPlayerViewController.playerButtonTapped(sender:)), for: .touchUpInside)
        }
    }

    deinit {
        hearThisPlayer?.removeObserver(observer: self)
    }
    
}

extension HearThisPlayerViewController {
    func playerButtonTapped(sender: Any) {
        switch playButton.playerState {
        case .playing:
            hearThisPlayer?.stop()
        default:
            break
        }
    }
}

extension HearThisPlayerViewController: HearThisPlayerObserver {
    func player(_ player: HearThisPlayerType, willStartPlaying track: Track) {
        titleLabel.text = track.title
        titleLabel.isHidden = false
        playButton.playerState = .loading
    }
    
    func player(_ player: HearThisPlayerType, didStartPlaying track: Track) {
        titleLabel.text = track.title
        titleLabel.isHidden = false
        playButton.playerState = .playing
    }
    
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track) {
        titleLabel.text = nil
        titleLabel.isHidden = true
        playButton.playerState = .notPlaying(ableToPlay: false)
    }
}
