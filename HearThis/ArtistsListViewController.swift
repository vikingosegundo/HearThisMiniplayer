//
//  ArtistsListViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 17.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class ArtistsListViewController: BaseTableViewController, ArtistSelectionObserver, HearThisPlayerHolder {

    let hearThisAPI = HearThisAPI(networkConnector: NetworkConnector())

    override weak var tableView: UITableView! {
        didSet {
            let ds =  ArtistsListDatasource(tableView:tableView,
                                            artistsResource: ArtistsResource(hearThisAPI: hearThisAPI)
            )
            ds.registerSelectionObserver(observer: self)
            self.datasource = ds
        }
    }
    
    private var datasource: ArtistsListDatasource?
    
    var hearThisPlayer: HearThisPlayerType?
    
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
}

