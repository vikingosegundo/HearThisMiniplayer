//
//  ArtistsListViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 17.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class ArtistsListViewController: UIViewController {
    let hearThisAPI = HearThisAPI(networkConnector: NetworkConnector())

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.datasource = ArtistsListDatasource(tableView:tableView, artistsResource: ArtistsResource(hearThisAPI: hearThisAPI))
        }
    }
    
    private var datasource: ArtistsListDatasource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

