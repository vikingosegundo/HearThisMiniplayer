//
//  HearThisPlayer.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
import AVFoundation

protocol HearThisPlayerType {
    func play(_ track: Track)
    func stop()
    
    mutating func registerObserver(observer: HearThisPlayerObserver)
    mutating func removeObserver(observer: HearThisPlayerObserver)
    var observers:[HearThisPlayerObserver] { set get }
}

extension HearThisPlayerType {
    mutating func registerObserver(observer: HearThisPlayerObserver) {
        self.observers.append(observer)
    }
    mutating func removeObserver(observer: HearThisPlayerObserver) {
        if let idx = self.observers.index(where: {
            $0 === observer
        }){
            self.observers.remove(at: idx)
        }
    }
    
}

protocol HearThisPlayerObserver: class {
    func player(_ player: HearThisPlayerType, willStartPlaying track: Track)
    func player(_ player: HearThisPlayerType, didStartPlaying track: Track)
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track)
}


protocol HearThisPlayerHolder : class {
    var hearThisPlayer: HearThisPlayerType? {set get }
}



class AVPlayerItemStatusObserver: NSObject {

    init(playerItem: AVPlayerItem, playerItemStatusChanged: @escaping (AVPlayerItemStatus) -> Void) {
        self.playerItem = playerItem
        self.playerItemStatusChanged = playerItemStatusChanged
        super.init()
        playerItem.addObserver(self,
                               forKeyPath: #keyPath(AVPlayerItem.status),
                               options: [.old, .new],
                               context: &playerItemContext)
    }
    
    deinit {
        playerItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), context: &playerItemContext)
    }
    
    private let playerItem: AVPlayerItem
    private let playerItemStatusChanged: (AVPlayerItemStatus) -> Void
    private var playerItemContext = 0

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
            return
        }
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItemStatus
            
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItemStatus(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            playerItemStatusChanged(status)
        }
    }
}


class HearThisPlayer: HearThisPlayerType {

    init(notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
    
        
        player.addBoundaryTimeObserver(forTimes: [CMTime(seconds: 0.001, preferredTimescale: 1000) as NSValue], queue: nil, using:{
            if let currentTrack = self.currentTrack {
                self.trackdDidStartPlaying(track: currentTrack)
            }
        })
        
        notificationCenter.addObserver(self, selector: #selector(HearThisPlayer.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    var observers:[HearThisPlayerObserver] = []
    
    private let player = AVPlayer()
    
    private var playerItemStatusObserver: AVPlayerItemStatusObserver?
    fileprivate var currentTrack: Track?
    private let notificationCenter: NotificationCenter
    func play(_ track: Track) {
        self.trackWillStartPlaying(track)
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let `self` = self else { return }
            let item = AVPlayerItem(url: URL(string: track.streamURL)!)

            self.playerItemStatusObserver = AVPlayerItemStatusObserver(playerItem: item) {
                status in
                switch status {
                case .readyToPlay:
                    print("ready to play")
                case .failed:
                    print("player faild")
                case .unknown:
                    print("unknown")
                }
            }
            self.currentTrack = track
            self.playItem(item)
        }
    }
    
    func stop() {
        player.pause()
        if player.currentItem != nil {
            player.replaceCurrentItem(with: nil)
            if let currentTrack = self.currentTrack {
                self.trackdDidStopPlaying(track: currentTrack)
            }
            self.currentTrack = nil
        }
    }
    
    private func playItem(_ item: AVPlayerItem) {
        player.replaceCurrentItem(with: item)
        player.play()
    }
}

extension HearThisPlayer {
    
    
    fileprivate func trackWillStartPlaying(_ track:Track) {
        DispatchQueue.main.async {
            for observer in self.observers {
                observer.player(self, willStartPlaying: track)
            }
        }
    }
    
    fileprivate func trackdDidStartPlaying(track: Track) {
        DispatchQueue.main.async {
            for observer in self.observers {
                observer.player(self, didStartPlaying: track)
            }
        }
    }
    
    fileprivate func trackdDidStopPlaying(track: Track) {
        DispatchQueue.main.async {
            for observer in self.observers {
                observer.player(self, didStopPlaying: track)
            }
        }
    }
    
    @objc
    func playerDidFinishPlaying(note: NSNotification){
        if let track = currentTrack {
            trackdDidStopPlaying(track: track)
        }
    }

}

