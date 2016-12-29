//
//  ArtistsListViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 17.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit
import HearThisAPI

class ArtistsListViewController: BaseTableViewController, ArtistSelectionObserver, HearThisPlayerHolder {

    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    
    override var tableView: UITableView! {
        didSet{
            configure()
        }
    }
    
    var hearThisAPI: HearThisAPIType {
        set{
            privateApi = newValue
        }
        get {
            if privateApi == nil {
                privateApi = HearThisAPI(networkConnector: NetworkConnector())
            }
            return privateApi!
        }
    }
    
    private var privateApi: HearThisAPIType?
    
    private var datasource: ArtistsListDatasource?
    
    var hearThisPlayer: HearThisPlayerType? {
        didSet{
            hearThisPlayer?.registerObserver(observer: self)
        }
    }
    
    private var selectedArtist: Artist?
    func selected(_ artist: Artist, on: IndexPath) {
        selectedArtist = artist
        performSegue(withIdentifier: "ArtistDetailViewController", sender: self)
        selectedArtist = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destiantion =  segue.destination as? HearThisPlayerHolder {
            destiantion.hearThisPlayer = hearThisPlayer
        }
        
        if let destination = segue.destination as? ArtistDetailViewController {
            destination.artist = selectedArtist
        }
    }
    
    private func configure(){
        guard let tableView = self.tableView else { return }
        do {
            let ds = try ArtistsListDatasource(tableView:tableView,
                                                artistsResource: ArtistsResource(hearThisAPI: hearThisAPI)
            )
            ds.registerSelectionObserver(observer: self)
            self.datasource = ds
        } catch(let e) {
            fatalError(e.localizedDescription)
        }
    }
}

extension ArtistsListViewController: HearThisPlayerObserver {
    
    func player(_ player: HearThisPlayerType, willStartPlaying track: Track) {
        bottomContraint.constant = 64
    }
    
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track) {
        bottomContraint.constant = 0
    }
}

