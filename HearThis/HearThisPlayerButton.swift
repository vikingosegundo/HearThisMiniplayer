//
//  HearThisPlayerButton.swift
//  HearThis
//
//  Created by Manuel Meyer on 21.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit


enum HearThisPlayerButtonState {
    case error
    case loading
    case playing
    case notPlaying(ableToPlay: Bool)
}

class HearThisPlayerButton: UIButton {
    var playerState: HearThisPlayerButtonState = .notPlaying(ableToPlay: false) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    weak fileprivate var activityIndicator: UIActivityIndicatorView? {
        didSet {
            activityIndicator?.color = self.tintColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tintColor = .blue
        self.setTitle(nil, for: .normal)
        switch playerState {
        case .playing:
            enterIsPlaying()
        case .notPlaying(ableToPlay: true):
            enterIsNotPlaying(ableToPlay: true)
        case .notPlaying(ableToPlay: false):
            enterIsNotPlaying(ableToPlay: false)
        case .loading:
            enterIsLoading()
            
        default:
            self.setImage(nil, for: .normal)
        }
    }
}

extension HearThisPlayerButton {
    fileprivate func enterIsLoading() {
        self.activityIndicator?.removeFromSuperview()

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        self.setImage(nil, for: .normal)
        self.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
    }
    
    fileprivate func enterIsPlaying() {
        self.setImage(UIImage(named:"audio_pause"), for: .normal)
        self.activityIndicator?.removeFromSuperview()
    }
    
    fileprivate func enterIsNotPlaying(ableToPlay:Bool) {
        if !ableToPlay {
            self.activityIndicator?.removeFromSuperview()
            self.setImage(nil, for: .normal)
        }
    }
}
