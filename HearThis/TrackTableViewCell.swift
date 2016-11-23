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
    
    func configure(withTrack track: Track) {
        self.coverArtView.imageFromUrl(urlString: track.coverArtURL)
        self.titleLabel.text = track.title
    }

}
