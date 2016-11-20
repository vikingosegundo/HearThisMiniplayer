//
//  StartViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, HearThisPlayerHolder {

    var hearThisPlayer: HearThisPlayerType? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for childViewController in self.childViewControllers {
            if let playerHolder = childViewController as? HearThisPlayerHolder {
                playerHolder.hearThisPlayer = self.hearThisPlayer
            }
        }
    }

}
