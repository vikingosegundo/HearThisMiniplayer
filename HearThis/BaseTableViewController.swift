//
//  BaseViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        deselectSelectedCells()
    }
    
    func deselectSelectedCells(){
        for i in 0 ..< self.tableView.numberOfSections {
            for j in 0 ..< self.tableView.numberOfRows(inSection: i) {
                let ip = IndexPath(row: j, section: i)
                self.tableView.deselectRow(at: ip, animated: true)
            }
        }
    }

}
