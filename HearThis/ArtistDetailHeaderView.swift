//
//  ArtistDetailHeaderView.swift
//  HearThis
//
//  Created by Manuel Meyer on 21.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class ArtistDetailHeaderView: UIView {
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    var artist: Artist? {
        didSet{
            artistNameLabel.text = artist?.username
            if let artist = self.artist {
                avatarView.imageFromUrl(urlString: artist.avatarURLString)
                avatarView.clipsToBounds = true
                avatarView.layer.cornerRadius = avatarView.frame.size.width / 2.0
            }
        }
    }

}
