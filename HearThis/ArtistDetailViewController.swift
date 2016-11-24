//
//  ArtistDetailViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 19.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit
import HearThisAPI

class ArtistDetailViewController: BaseTableViewController, TrackSelectionObserver, HearThisPlayerHolder {
    
    let hearThisAPI = HearThisAPI(networkConnector: NetworkConnector())
    var artist: Artist?
    var hearThisPlayer: HearThisPlayerType?
    private var datasource: ArtistDetailDataSource?

    @IBOutlet weak var artistDetailHeaderView: ArtistDetailHeaderView!
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let artist = artist {
            self.artistDetailHeaderView.artist = artist
            
            do {
                try self.datasource = ArtistDetailDataSource(tableView: tableView,
                                                             artist: artist,
                                                             tracksResource: TrackResource(hearThisAPI:hearThisAPI)
                )
                self.datasource?.registerSelectionObserver(observer: self)
            } catch (let e) {
                fatalError(e.localizedDescription)
            }
        }
    }
    
    func selected(_ track: Track, on: IndexPath) {
        hearThisPlayer?.stop()
        hearThisPlayer?.play(track)
    }
}
