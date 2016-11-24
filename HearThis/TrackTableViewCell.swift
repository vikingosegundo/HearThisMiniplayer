//
//  TrackTableViewCell.swift
//  HearThis
//
//  Created by Manuel Meyer on 23.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var coverArtView: UIImageView! {
        didSet{
            coverArtView.layer.cornerRadius = 4
            coverArtView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var duartionLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!

    func configure(withTrack track: Track) {
        self.coverArtView.image = nil
        self.coverArtView.imageFromUrl(urlString: track.coverArtURL)
        self.titleLabel.text = track.title
        self.duartionLabel.text = type(of:self).durationString(forDuration: track.duration)
        self.playCountLabel.text = "🎧\(track.playCount)"
        self.favoriteCountLabel.text = "❤️\(track.favoriteCount)"
    }

    static func durationString(forDuration duration:Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(duration))
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let comps = calendar.dateComponents([.hour, .minute, .second], from: date)

        var hourString: String = ""
        var minuteString: String = "00"
        var secondString: String = "00"
        
        if let hour = comps.hour, hour > 0 {
            hourString = "\(hour):"
        }
        
        if let minute = comps.minute {
            minuteString = "\(minute)"
            if minuteString.characters.count < 2, hourString != "" {
                minuteString = "0" + minuteString
            }
        }
        
        if let second = comps.second {
            secondString = "\(second)"
            if secondString.characters.count < 2 {
                secondString = "0" + secondString
            }
        }
        
        return "\(hourString)\(minuteString):\(secondString)"
    }
}
