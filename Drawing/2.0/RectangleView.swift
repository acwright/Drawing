//
//  RectangleView.swift
//  Drawing
//
//  Created by Aaron Wright on 1/25/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

class RectangleView: LayerView {

    var fillColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var strokeColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var strokeWidth: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()!
        
        context.saveGState()
        
        var path: UIBezierPath
        
        if self.cornerRadius > 0.0 {
            path = UIBezierPath(roundedRect: self.canvas, cornerRadius: self.cornerRadius)
        } else {
            path = UIBezierPath(rect: self.canvas)
        }
        
        self.fillColor.setFill()
        self.strokeColor.setStroke()
        
        path.lineWidth = self.strokeWidth
        
        path.fill()
        path.stroke()
        
        context.saveGState()
    }

}
