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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clear
    }
    
    func rotate(degrees: Double) {
        if let controlledView = self.controlledView {
            controlledView.transform = controlledView.transform.rotated(by: CGFloat(CGFloat(degrees) / 180.0 * CGFloat.pi))
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
        let translation = CGPoint(x: location.x - previousLocation.x, y: location.y - previousLocation.y)
        var newFrame = CGRect.zero
        var newBounds = CGRect.zero
        
        if self.controlledView != nil {
            newBounds = self.controlledView!.bounds
        }
        
        switch self.handle {
        case Handle.TopLeft:
            newFrame = CGRect(x: self.frame.origin.x + translation.x, y: self.frame.origin.y + translation.y, width: self.frame.size.width - translation.x, height: self.frame.size.height - translation.y)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width - translation.x, height: newBounds.size.height - translation.y)
        case Handle.TopMiddle:
            newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + translation.y, width: self.frame.size.width, height: self.frame.size.height - translation.y)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width, height: newBounds.size.height - translation.y)
        case Handle.TopRight:
            newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + translation.y, width: self.frame.size.width + translation.x, height: self.frame.size.height - translation.y)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width + translation.x, height: newBounds.size.height - translation.y)
        case Handle.MiddleLeft:
            newFrame = CGRect(x: self.frame.origin.x + translation.x, y: self.frame.origin.y, width: self.frame.size.width - translation.x, height: self.frame.size.height)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width - translation.x, height: newBounds.size.height)
        case Handle.MiddleRight:
            newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width + translation.x, height: self.frame.size.height)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width + translation.x, height: newBounds.size.height)
        case Handle.BottomLeft:
            newFrame = CGRect(x: self.frame.origin.x + translation.x, y: self.frame.origin.y, width: self.frame.size.width - translation.x, height: self.frame.size.height + translation.y)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width - translation.x, height: newBounds.size.height + translation.y)
        case Handle.BottomMiddle:
            newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height + translation.y)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width, height: newBounds.size.height + translation.y)
        case Handle.BottomRight:
            newFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width + translation.x, height: self.frame.size.height + translation.y)
            newBounds = CGRect(x: newBounds.origin.x, y: newBounds.origin.y, width: newBounds.size.width + translation.x, height: newBounds.size.height + translation.y)
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
        let translation = CGPoint(x: location.x - previousLocation.x, y: location.y - previousLocation.y)
        let newCenter = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        self.center = newCenter
        self.controlledView?.center = newCenter
        
        self.setNeedsDisplay()
    }
    
    func endMove(location: CGPoint) {
        self.moving = false
        
        self.setNeedsDisplay()
    }
    
    func handleForLocation(location: CGPoint) -> Handle {
        if self.rectForHandle(handle: Handle.TopLeft).contains(location) {
            return Handle.TopLeft
        }
        if self.rectForHandle(handle: Handle.TopMiddle).contains(location) {
            return Handle.TopMiddle
        }
        if self.rectForHandle(handle: Handle.TopRight).contains(location) {
            return Handle.TopRight
        }
        if self.rectForHandle(handle: Handle.MiddleLeft).contains(location) {
            return Handle.MiddleLeft
        }
        if self.rectForHandle(handle: Handle.MiddleRight).contains(location) {
            return Handle.MiddleRight
        }
        if self.rectForHandle(handle: Handle.BottomLeft).contains(location) {
            return Handle.BottomLeft
        }
        if self.rectForHandle(handle: Handle.BottomMiddle).contains(location) {
            return Handle.BottomMiddle
        }
        if self.rectForHandle(handle: Handle.BottomRight).contains(location) {
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
            return CGRect(x: leftX, y: topY, width: padding, height: padding)
        case Handle.TopMiddle:
            return CGRect(x: midX, y: topY, width: padding, height: padding)
        case Handle.TopRight:
            return CGRect(x: rightX, y: topY, width: padding, height: padding)
        case Handle.MiddleLeft:
            return CGRect(x: leftX, y: midY, width: padding, height: padding)
        case Handle.MiddleRight:
            return CGRect(x: rightX, y: midY, width: padding, height: padding)
        case Handle.BottomLeft:
            return CGRect(x: leftX, y: bottomY, width: padding, height: padding)
        case Handle.BottomMiddle:
            return CGRect(x: midX, y: bottomY, width: padding, height: padding)
        case Handle.BottomRight:
            return CGRect(x: rightX, y: bottomY, width: padding, height: padding)
        case Handle.None:
            fallthrough
        default:
            return CGRect.zero
        }
    }
    
    func drawHandles() {
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
        
        let topLeft = rectForHandle(handle: Handle.TopLeft)
        let topMiddle = rectForHandle(handle: Handle.TopMiddle)
        let topRight = rectForHandle(handle: Handle.TopRight)
        let middleLeft = rectForHandle(handle: Handle.MiddleLeft)
        let middleRight = rectForHandle(handle: Handle.MiddleRight)
        let bottomLeft = rectForHandle(handle: Handle.BottomLeft)
        let bottomMiddle = rectForHandle(handle: Handle.BottomMiddle)
        let bottomRight = rectForHandle(handle: Handle.BottomRight)
        
        context.fill(topLeft)
        context.fill(topMiddle)
        context.fill(topRight)
        context.fill(middleLeft)
        context.fill(middleRight)
        context.fill(bottomLeft)
        context.fill(bottomMiddle)
        context.fill(bottomRight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if self.selected {
            let touch = touches.first!
            let location = touch.location(in: self)
            
            switch self.handleForLocation(location: location) {
            case Handle.TopLeft:
                self.beginResize(handle: Handle.TopLeft, location: location)
            case Handle.TopMiddle:
                self.beginResize(handle: Handle.TopMiddle, location: location)
            case Handle.TopRight:
                self.beginResize(handle: Handle.TopRight, location: location)
            case Handle.MiddleLeft:
                self.beginResize(handle: Handle.MiddleLeft, location: location)
            case Handle.MiddleRight:
                self.beginResize(handle: Handle.MiddleRight, location: location)
            case Handle.BottomLeft:
                self.beginResize(handle: Handle.BottomLeft, location: location)
            case Handle.BottomMiddle:
                self.beginResize(handle: Handle.BottomMiddle, location: location)
            case Handle.BottomRight:
                self.beginResize(handle: Handle.BottomRight, location: location)
            case Handle.None:
                fallthrough
            default:
                self.beginMove(location: location)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if self.selected {
            let touch = touches.first!
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            if self.resizing {
                self.continueResize(location: location, previousLocation: previousLocation)
            }
            if self.moving {
                self.continueMove(location: location, previousLocation: previousLocation)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if self.selected {
            let touch = touches.first!
            let location = touch.location(in: self)
            
            if self.resizing {
                self.endResize(location: location)
            }
            if self.moving {
                self.endMove(location: location)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let backgroundColor = self.backgroundColor {
            let context = UIGraphicsGetCurrentContext()!
            
            backgroundColor.setFill()
            
            context.fill(self.bounds)
        }
        
        if self.selected && !self.moving {
            self.drawHandles()
        }
    }
}
