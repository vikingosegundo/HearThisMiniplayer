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

    @IBOutlet weak var miniPlayerBottom: NSLayoutConstraint!
    var hearThisPlayer: HearThisPlayerType? {
        didSet{
            hearThisPlayer?.registerObserver(observer: self)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        minPlayerHightConstraint.constant = 0
        miniPlayerBottom.constant = 0

        for childViewController in self.childViewControllers {
            if let playerHolder = childViewController as? HearThisPlayerHolder {
                playerHolder.hearThisPlayer = self.hearThisPlayer
            }
        }
    }

}

extension StartViewController: HearThisPlayerObserver {
    func player(_ player: HearThisPlayerType, willStartPlaying track: Track) {
        minPlayerHightConstraint.constant = 69
        miniPlayerBottom.constant = 44
        self.view.setNeedsUpdateConstraints()
    }
    
    func player(_ player: HearThisPlayerType, didStopPlaying track: Track) {
        minPlayerHightConstraint.constant = 0
        miniPlayerBottom.constant = 0
        self.view.setNeedsUpdateConstraints()
    }
}
