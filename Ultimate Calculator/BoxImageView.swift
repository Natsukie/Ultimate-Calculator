//
//  AppDelegate.swift
//  Ultimate Calculator
//
//  Created by Guangzu on 11/27/19.
//  Copyright © 2019 Guangzu. All rights reserved.
//

import Vision
import UIKit


class BoundingBoxImageView: UIImageView {
    

    private var boundingBoxViews = [UIView]()
    
    func load(boundingBoxes: [CGRect]) {
       
        removeExistingBoundingBoxes()
    
        for box in boundingBoxes {
            load(boundingBox: box)
        }
    }
    
   
    func removeExistingBoundingBoxes() {
        for view in boundingBoxViews {
            view.removeFromSuperview()
        }
        boundingBoxViews.removeAll()
    }
    
    private func load(boundingBox: CGRect) {

        let imageRect = self.imageRect
        
        var boundingBox = boundingBox
        
      
        boundingBox.origin.y = 1 - boundingBox.origin.y
        
        var convertedBoundingBox = VNImageRectForNormalizedRect(boundingBox, Int(imageRect.width), Int(imageRect.height))
        
        if frame.width - imageRect.width != 0 {
            convertedBoundingBox.origin.x += imageRect.origin.x
            convertedBoundingBox.origin.y -= convertedBoundingBox.height
        } else if frame.height - imageRect.height != 0 {
            convertedBoundingBox.origin.y += imageRect.origin.y
            convertedBoundingBox.origin.y -= convertedBoundingBox.height
        }
        
        let enlargementAmount = CGFloat(2.2)
        convertedBoundingBox.origin.x    -= enlargementAmount
        convertedBoundingBox.origin.y    -= enlargementAmount
        convertedBoundingBox.size.width  += enlargementAmount * 2
        convertedBoundingBox.size.height += enlargementAmount * 2

        let view = UIView(frame: convertedBoundingBox)
        view.layer.opacity = 1
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        
        addSubview(view)
        boundingBoxViews.append(view)
    }
}

