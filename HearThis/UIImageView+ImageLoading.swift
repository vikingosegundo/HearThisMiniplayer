//
//  UIImageView+ImageLoading.swift
//  HearThis
//
//  Created by Manuel Meyer on 21.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            Alamofire.request(url).response(completionHandler: { (response) in
                if let data = response.data, let image = UIImage(data: data) {
                    self.image = image
                }
            })
        }
    }
}
