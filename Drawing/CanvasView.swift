//
//  CanvasView.swift
//  Drawing
//
//  Created by Aaron Wright on 10/29/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var controlView: ControlView!
    var activeView: ShapeView?
    var selectMode: Bool = false
    var drawMode: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup() {
        self.controlView = ControlView(frame: CGRectZero)
        self.addSubview(self.controlView)
        
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    func rotate() {
        self.controlView.rotate(10.0)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInView(self)
        
        self.controlView.selected = false
        
        if self.selectMode {
            if let view = self.hitTest(location, withEvent: event) {
                if view != self {
                    if view.isKindOfClass(ShapeView) {
                        let shapeView = view as ShapeView
                        
                        self.controlView.controlledView = shapeView
                        self.controlView.selected = true
                    }
                    if view.isKindOfClass(ControlView) {
                        self.controlView.selected = true
                    }
                }
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInView(self)
        
        if self.drawMode {
            if let shape = self.activeView {
                let width: CGFloat = location.x - shape.frame.origin.x
                let height: CGFloat = location.y - shape.frame.origin.y
                
                shape.frame = CGRectMake(shape.frame.origin.x, shape.frame.origin.y, width, height)
                shape.setNeedsDisplay()
            } else {
                let shape = ShapeView(frame: CGRectMake(location.x, location.y, 0.0, 0.0))
                self.insertSubview(shape, belowSubview: self.controlView!)
                
                self.activeView = shape
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if self.drawMode {
            self.drawMode = false
            self.selectMode = true
            
            if let activeView = self.activeView {
                self.controlView.selected = true
                self.controlView.controlledView = activeView
                
                self.activeView = nil
            }
        }
    }

}
