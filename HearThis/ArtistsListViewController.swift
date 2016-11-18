//
//  ArtistsListViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 17.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class ArtistsListViewController: UIViewController, ArtistSelectionObserver {

    let hearThisAPI = HearThisAPI(networkConnector: NetworkConnectorMock())

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let ds =  ArtistsListDatasource(tableView:tableView,
                                            artistsResource: ArtistsResource(hearThisAPI: hearThisAPI)
            )
            ds.registerSelectionObserver(observer: self)
            self.datasource = ds
        }
    }
    
    private var datasource: ArtistsListDatasource?
    
    func selected(_ artist: Artist, on: IndexPath) {
        print(artist.username)
    }
}

