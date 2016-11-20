//
//  HearThisNavigationController.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class HearThisNavigationController: UINavigationController, HearThisPlayerHolder {
    var hearThisPlayer: HearThisPlayerType?

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let vc = viewController as? ArtistDetailViewController {
            vc.hearThisPlayer = self.hearThisPlayer
        }
        super.pushViewController(viewController, animated: animated)
    }
}
