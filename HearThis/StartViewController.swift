//
//  StartViewController.swift
//  HearThis
//
//  Created by Manuel Meyer on 18.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, HearThisPlayerHolder {
    @IBOutlet weak var minPlayerHightConstraint: NSLayoutConstraint!

    @IBOutlet weak var tableViewBottomContraint: NSLayoutConstraint!
    var hearThisPlayer: HearThisPlayerType? {
        didSet{
            hearThisPlayer?.registerObserver(observer: self)
        }
    }
    
    fileprivate var bottomDistance: CGFloat = 0 {	
        didSet{
            minPlayerHightConstraint.constant = bottomDistance
            tableViewBottomContraint.constant = bottomDistance
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomDistance = 0
        for childViewController in self.childViewControllers {
            if let playerHolder = childViewController as? HearThisPlayerHolder {
                playerHolder.hearThisPlayer = self.hearThisPlayer
            }
        }
    }

}

extension StartViewController: HearThisPlayerObserver {
    func player(_ player: HearThisPlayerType, willStartPlaying track: Track) {
        bottomDistance = 69
    }
    
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track) {
        bottomDistance = 0
    }
}
