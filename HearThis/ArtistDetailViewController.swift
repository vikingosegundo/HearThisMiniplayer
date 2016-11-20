//
//  ArtistDetailViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 19.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class ArtistDetailViewController: BaseTableViewController, TrackSelectionObserver, HearThisPlayerHolder {
    
    let hearThisAPI = HearThisAPI(networkConnector: NetworkConnector())
    var artist: Artist?
    var hearThisPlayer: HearThisPlayerType?
    private var datasource: ArtistDetailDataSource?

    
    @IBOutlet weak var artistName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let artist = artist {
            artistName.text = artist.username
            self.datasource = ArtistDetailDataSource(tableView: tableView, artist: artist, tracksResource: TrackResource(hearThisAPI:hearThisAPI))
            self.datasource?.registerSelectionObserver(observer: self)
        }
    }
    
    func selected(_ track: Track, on: IndexPath) {
        hearThisPlayer?.stop()
        hearThisPlayer?.play(track)
    }
}
