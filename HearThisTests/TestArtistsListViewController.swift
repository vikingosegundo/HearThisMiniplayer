//
//  TestArtistsListViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 23.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit
@testable import HearThis

class TestArtistsListViewController: ArtistsListViewController {

    var artist: Artist?
    var indexPath: IndexPath?
    override func selected(_ artist: Artist, on: IndexPath) {
        self.artist = artist
        self.indexPath = on
    }
    
}
