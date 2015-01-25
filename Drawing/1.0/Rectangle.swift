//
//  Rectangle.swift
//  Drawing
//
//  Created by Aaron Wright on 11/6/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class Rectangle: Layer {
   
    var backgroundColor: UIColor = UIColor.clearColor()
    var strokeColor: UIColor = UIColor.clearColor()
    var strokeWidth: CGFloat = 0.0
    var cornerRadius: CGFloat = 0.0
 
    override func drawInContext(context: CGContextRef) {
        super.drawInContext(context)
        
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, self.x, self.y)
        CGContextRotateCTM(context, self.rotation * CGFloat(M_PI) / 180.0)
        CGContextScaleCTM(context, self.scaleX, self.scaleY)
        
        //let path = UIBezierPath(roundedRect: CGRectMake(self.offsetX, self.offsetY, self.width, self.height), cornerRadius: self.cornerRadius)
        let path = UIBezierPath(rect: CGRectMake(self.offsetX, self.offsetY, self.width, self.height))
        
        self.backgroundColor.setFill()
        self.strokeColor.setStroke()
        
        path.lineWidth = self.strokeWidth
        
        path.fill()
        path.stroke()
        
        CGContextRestoreGState(context)
    }
}
