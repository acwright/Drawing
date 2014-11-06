//
//  ControlView.swift
//  Drawing
//
//  Created by Aaron Wright on 10/29/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class ControlView: UIView {
    
    enum Handle {
        case TopLeft
        case TopMiddle
        case TopRight
        case MiddleLeft
        case MiddleRight
        case BottomLeft
        case BottomMiddle
        case BottomRight
        case None
    }
    
    var handle: Handle = Handle.None
    var resizing: Bool = false
    var moving: Bool = false
    var selected: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var controlledView: UIView? {
        didSet {
            self.frame = self.controlledView!.frame
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    func rotate(degrees: Double) {
        if let controlledView = self.controlledView {
            controlledView.transform = CGAffineTransformRotate(controlledView.transform, CGFloat(degrees / 180.0 * M_PI))
            self.frame = controlledView.frame
            self.setNeedsDisplay()
        }
    }
    
    func beginResize(handle: Handle, location: CGPoint) {
        self.frame = self.controlledView!.frame
        
        self.handle = handle
        self.resizing = true
    }

    func continueResize(location: CGPoint, previousLocation: CGPoint) {
        let translation = CGPointMake(location.x - previousLocation.x, location.y - previousLocation.y)
        var newFrame = CGRectZero
        var newBounds = CGRectZero
        
        if let controlledView = self.controlledView {
            newBounds = self.controlledView!.bounds
        }
        
        switch self.handle {
        case Handle.TopLeft:
            newFrame = CGRectMake(self.frame.origin.x + translation.x, self.frame.origin.y + translation.y, self.frame.size.width - translation.x, self.frame.size.height - translation.y)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width - translation.x, newBounds.size.height - translation.y)
        case Handle.TopMiddle:
            newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y + translation.y, self.frame.size.width, self.frame.size.height - translation.y)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width, newBounds.size.height - translation.y)
        case Handle.TopRight:
            newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y + translation.y, self.frame.size.width + translation.x, self.frame.size.height - translation.y)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width + translation.x, newBounds.size.height - translation.y)
        case Handle.MiddleLeft:
            newFrame = CGRectMake(self.frame.origin.x + translation.x, self.frame.origin.y, self.frame.size.width - translation.x, self.frame.size.height)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width - translation.x, newBounds.size.height)
        case Handle.MiddleRight:
            newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + translation.x, self.frame.size.height)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width + translation.x, newBounds.size.height)
        case Handle.BottomLeft:
            newFrame = CGRectMake(self.frame.origin.x + translation.x, self.frame.origin.y, self.frame.size.width - translation.x, self.frame.size.height + translation.y)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width - translation.x, newBounds.size.height + translation.y)
        case Handle.BottomMiddle:
            newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + translation.y)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width, newBounds.size.height + translation.y)
        case Handle.BottomRight:
            newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + translation.x, self.frame.size.height + translation.y)
            newBounds = CGRectMake(newBounds.origin.x, newBounds.origin.y, newBounds.size.width + translation.x, newBounds.size.height + translation.y)
        case Handle.None:
            fallthrough
        default:
            return
        }
        
        self.frame = newFrame
        
        if let controlledView = self.controlledView {
            controlledView.center = self.center
            controlledView.bounds = newBounds
            
            self.frame = controlledView.frame
        }
        
        self.setNeedsDisplay()
    }
    
    func endResize(location: CGPoint) {
        self.handle = Handle.None
        self.resizing = false
        
        self.setNeedsDisplay()
    }
    
    func beginMove(location: CGPoint) {
        self.moving = true
    }
    
    func continueMove(location: CGPoint, previousLocation: CGPoint) {
        let translation = CGPointMake(location.x - previousLocation.x, location.y - previousLocation.y)
        let newCenter = CGPointMake(self.center.x + translation.x, self.center.y + translation.y)
        self.center = newCenter
        self.controlledView?.center = newCenter
        
        self.setNeedsDisplay()
    }
    
    func endMove(location: CGPoint) {
        self.moving = false
        
        self.setNeedsDisplay()
    }
    
    func handleForLocation(location: CGPoint) -> Handle {
        if self.rectForHandle(Handle.TopLeft).contains(location) {
            return Handle.TopLeft
        }
        if self.rectForHandle(Handle.TopMiddle).contains(location) {
            return Handle.TopMiddle
        }
        if self.rectForHandle(Handle.TopRight).contains(location) {
            return Handle.TopRight
        }
        if self.rectForHandle(Handle.MiddleLeft).contains(location) {
            return Handle.MiddleLeft
        }
        if self.rectForHandle(Handle.MiddleRight).contains(location) {
            return Handle.MiddleRight
        }
        if self.rectForHandle(Handle.BottomLeft).contains(location) {
            return Handle.BottomLeft
        }
        if self.rectForHandle(Handle.BottomMiddle).contains(location) {
            return Handle.BottomMiddle
        }
        if self.rectForHandle(Handle.BottomRight).contains(location) {
            return Handle.BottomRight
        }
        return Handle.None
    }
    
    func rectForHandle(handle: Handle) -> CGRect {
        let padding: CGFloat = 20.0
        
        let leftX = self.bounds.origin.x
        let midX = self.bounds.origin.x + (self.bounds.size.width / 2.0) - (padding / 2.0)
        let rightX = self.bounds.origin.x + self.bounds.size.width - padding
        
        let topY = self.bounds.origin.y
        let midY = self.bounds.origin.y + (self.bounds.size.height / 2.0) - (padding / 2.0)
        let bottomY = self.bounds.origin.y + self.bounds.size.height - padding
        
        switch handle {
        case Handle.TopLeft:
            return CGRectMake(leftX, topY, padding, padding)
        case Handle.TopMiddle:
            return CGRectMake(midX, topY, padding, padding)
        case Handle.TopRight:
            return CGRectMake(rightX, topY, padding, padding)
        case Handle.MiddleLeft:
            return CGRectMake(leftX, midY, padding, padding)
        case Handle.MiddleRight:
            return CGRectMake(rightX, midY, padding, padding)
        case Handle.BottomLeft:
            return CGRectMake(leftX, bottomY, padding, padding)
        case Handle.BottomMiddle:
            return CGRectMake(midX, bottomY, padding, padding)
        case Handle.BottomRight:
            return CGRectMake(rightX, bottomY, padding, padding)
        case Handle.None:
            fallthrough
        default:
            return CGRectZero
        }
    }
    
    func drawHandles() {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.7)
        
        let topLeft = rectForHandle(Handle.TopLeft)
        let topMiddle = rectForHandle(Handle.TopMiddle)
        let topRight = rectForHandle(Handle.TopRight)
        let middleLeft = rectForHandle(Handle.MiddleLeft)
        let middleRight = rectForHandle(Handle.MiddleRight)
        let bottomLeft = rectForHandle(Handle.BottomLeft)
        let bottomMiddle = rectForHandle(Handle.BottomMiddle)
        let bottomRight = rectForHandle(Handle.BottomRight)
        
        CGContextFillRect(context, topLeft)
        CGContextFillRect(context, topMiddle)
        CGContextFillRect(context, topRight)
        CGContextFillRect(context, middleLeft)
        CGContextFillRect(context, middleRight)
        CGContextFillRect(context, bottomLeft)
        CGContextFillRect(context, bottomMiddle)
        CGContextFillRect(context, bottomRight)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        if self.selected {
            let touch = touches.anyObject() as UITouch
            let location = touch.locationInView(self)
            
            switch self.handleForLocation(location) {
            case Handle.TopLeft:
                self.beginResize(Handle.TopLeft, location: location)
            case Handle.TopMiddle:
                self.beginResize(Handle.TopMiddle, location: location)
            case Handle.TopRight:
                self.beginResize(Handle.TopRight, location: location)
            case Handle.MiddleLeft:
                self.beginResize(Handle.MiddleLeft, location: location)
            case Handle.MiddleRight:
                self.beginResize(Handle.MiddleRight, location: location)
            case Handle.BottomLeft:
                self.beginResize(Handle.BottomLeft, location: location)
            case Handle.BottomMiddle:
                self.beginResize(Handle.BottomMiddle, location: location)
            case Handle.BottomRight:
                self.beginResize(Handle.BottomRight, location: location)
            case Handle.None:
                fallthrough
            default:
                self.beginMove(location)
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        if self.selected {
            let touch = touches.anyObject() as UITouch
            let location = touch.locationInView(self)
            let previousLocation = touch.previousLocationInView(self)
            
            if self.resizing {
                self.continueResize(location, previousLocation: previousLocation)
            }
            if self.moving {
                self.continueMove(location, previousLocation: previousLocation)
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        if self.selected {
            let touch = touches.anyObject() as UITouch
            let location = touch.locationInView(self)
            
            if self.resizing {
                self.endResize(location)
            }
            if self.moving {
                self.endMove(location)
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if let backgroundColor = self.backgroundColor {
            backgroundColor.setFill()
            CGContextFillRect(UIGraphicsGetCurrentContext(), self.bounds)
        }
        
        if self.selected && !self.moving {
            self.drawHandles()
        }
    }
}
