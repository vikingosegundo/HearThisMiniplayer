//
//  HearThisTabBarController.swift
//  HearThis
//
//  Created by Manuel Meyer on 28.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class HearThisTabBarController: UITabBarController, HearThisPlayerHolder {
    
    var hearThisPlayer: HearThisPlayerType? {
        didSet{
            if let viewControllers = viewControllers {
                for vc in viewControllers {
                    configureTargetViewController(vc)
                }
            }
        }
    }
    
    private
    func configureTargetViewController(_ viewController: UIViewController?){
        if let playerHolder = viewController as? HearThisPlayerHolder {
            playerHolder.hearThisPlayer = hearThisPlayer
        }
    }
}
