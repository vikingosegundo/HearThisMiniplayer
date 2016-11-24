//
//  WaveFormImageRenderer.swift
//  HearThis
//
//  Created by Manuel Meyer on 24.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit
import CoreGraphics


enum ImageRendererError: Error {
    case unknown(String)
}

enum ImageRendererResult {
    case success(UIImage)
    case error(Error)
    
}
class WaveFormImageRenderer {
    
    
    init(waveFormResource: WaveFormResourceType) {
        self.waveFormResource = waveFormResource
    }
    
    let waveFormResource: WaveFormResourceType
    private var renderedImage: UIImage?
    
    
    func render(track: Track, size: CGSize , rendered:@escaping ((ImageRendererResult)->Void)) {
        
        guard renderedImage == nil else {
            rendered(ImageRendererResult.success(renderedImage!))
            return
        }
        
        waveFormResource.waveform(for: track){
            result in
            switch result {
            case .success(let waveForm):
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    UIGraphicsBeginImageContext(size)
                    guard waveForm.waveFormDataPoints.count > 0 else {
                        DispatchQueue.main.async {
                            rendered(ImageRendererResult.error(ImageRendererError.unknown("no wavePoints")))
                        }
                        return
                    }
                    
                    
                    let wavePoints = waveForm.waveFormDataPoints
                    let dataPointWidth = CGFloat(size.width) / CGFloat(wavePoints.count)
                    
                    UIColor(white: 0.9, alpha: 1).set()
                    var max = -1
                    wavePoints.forEach { (value) in
                        
                        if value > max {
                            max = value
                        }
                    }
                    let heightFactor = CGFloat(size.height) / CGFloat(max)
                    
                    
                    var x = CGFloat(0);
                    for point in wavePoints {
                        let pointRect = CGRect(x: x, y: size.height - CGFloat(point) * heightFactor, width: dataPointWidth, height: CGFloat(point) * heightFactor)
                        let path = UIBezierPath(rect: pointRect)
                        path.stroke()
                        x += dataPointWidth
                    }
                    
                    let img = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    self.renderedImage = img
                    DispatchQueue.main.async {
                        rendered(ImageRendererResult.success(self.renderedImage!))
                    }
                }
            case .error(let error):
                rendered(ImageRendererResult.error(error))
            }
            
        }
        
        
    }
}
