//
//  ArtistTableViewCell.swift
//  HearThis
//
//  Created by Manuel Meyer on 23.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView! {
        didSet{
            avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
            avatarView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(withArtist artist: Artist) {
        avatarView.image = nil
        avatarView.imageFromUrl(urlString: artist.avatarURLString)
        nameLabel.text = artist.username
    }
}
