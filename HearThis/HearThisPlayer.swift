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

extension HearThisPlayerObserver {
    func player(_ player: HearThisPlayerType, willStartPlaying track: Track){}
    func player(_ player: HearThisPlayerType, didStartPlaying track: Track) {}
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track)  {}
}

protocol HearThisPlayerHolder : class {
    var hearThisPlayer: HearThisPlayerType? {set get }
}


class HearThisPlayer: HearThisPlayerType {

    init(notificationCenter: NotificationCenter = NotificationCenter.default, audioSession:AVAudioSession = AVAudioSession.sharedInstance()) {
        self.notificationCenter = notificationCenter
        self.audioSession = audioSession
        
        player.addBoundaryTimeObserver(forTimes: [CMTime(seconds: 0.001, preferredTimescale: 1000) as NSValue], queue: nil, using:{
            if let currentTrack = self.currentTrack {
                self.trackdDidStartPlaying(track: currentTrack)
            }
        })
        
        notificationCenter.addObserver(self, selector: #selector(HearThisPlayer.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    var observers:[HearThisPlayerObserver] = []
    
    private let player = AVPlayer()
    
    fileprivate var currentTrack: Track?
    private let notificationCenter: NotificationCenter
    private let audioSession: AVAudioSession
    func play(_ track: Track) {
        self.trackWillStartPlaying(track)
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let `self` = self else { return }
            let item = AVPlayerItem(url: URL(string: track.streamURL)!)
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
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            do {
                try audioSession.setActive(true)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
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

