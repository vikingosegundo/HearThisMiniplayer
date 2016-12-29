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
    
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    let hearThisAPI = HearThisAPI(networkConnector: NetworkConnector())
    var artist: Artist?
    var hearThisPlayer: HearThisPlayerType? {
        didSet {
            hearThisPlayer?.registerObserver(observer: self)
        }
    }
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
                                                             tracksResource: TrackResource(hearThisAPI:hearThisAPI),
                                                             waveFormResource: WaveFormResource(hearThisAPI: hearThisAPI)
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

extension ArtistDetailViewController : HearThisPlayerObserver {

    func player(_ player: HearThisPlayerType, willStartPlaying track: Track) {
        bottomContraint.constant = 64
    }
    
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track) {
        bottomContraint.constant = 0
    }
}
