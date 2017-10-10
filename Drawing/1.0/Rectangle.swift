//
//  Rectangle.swift
//  Drawing
//
//  Created by Aaron Wright on 11/6/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class Rectangle: Layer {
   
    var backgroundColor: UIColor = UIColor.clear
    var strokeColor: UIColor = UIColor.clear
    var strokeWidth: CGFloat = 0.0
    var cornerRadius: CGFloat = 0.0
 
    override func drawInContext(context: CGContext) {
        super.drawInContext(context: context)
        
        context.saveGState()
        context.translateBy(x: self.x, y: self.y)
        context.rotate(by: self.rotation * CGFloat.pi / 180.0)
        context.scaleBy(x: self.scaleX, y: self.scaleY)
        
        //let path = UIBezierPath(roundedRect: CGRectMake(self.offsetX, self.offsetY, self.width, self.height), cornerRadius: self.cornerRadius)
        let path = UIBezierPath(rect: CGRect(x: self.offsetX, y: self.offsetY, width: self.width, height: self.height))
        
        self.backgroundColor.setFill()
        self.strokeColor.setStroke()
        
        path.lineWidth = self.strokeWidth
        
        path.fill()
        path.stroke()
        
        context.restoreGState()
    }
}
