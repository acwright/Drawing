//
//  LayerView.swift
//  Drawing
//
//  Created by Aaron Wright on 1/25/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

class LayerView: UIView, UIGestureRecognizerDelegate {
    
    var selected: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var debugColor: UIColor = UIColor.clearColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var canvas: CGRect = CGRectZero {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "pan:")
        panRecognizer.delegate = self
        panRecognizer.minimumNumberOfTouches = 1
        panRecognizer.maximumNumberOfTouches = 1
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "pinch:")
        pinchRecognizer.delegate = self
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: "rotate:")
        rotationRecognizer.delegate = self
        
        self.addGestureRecognizer(tapRecognizer)
        self.addGestureRecognizer(panRecognizer)
        self.addGestureRecognizer(pinchRecognizer)
        self.addGestureRecognizer(rotationRecognizer)
        
        self.canvas = CGRectOffset(self.bounds, 10, 10)
        self.frame = CGRectMake(self.frame.origin.x - 10, self.frame.origin.y - 10, self.frame.size.width + 20, self.frame.size.height + 20)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tap(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view as? LayerView {
            view.selected = !view.selected
        }
    }
    
    func pan(recognizer: UIPanGestureRecognizer) {
        if let superview = self.superview {
            let translation = recognizer.translationInView(superview)
            
            if let view = recognizer.view as? LayerView {
                if view.selected {
                    view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
                }
            }
            
            recognizer.setTranslation(CGPointZero, inView: superview)
        }
    }
    
    func pinch(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view as? LayerView {
            if view.selected {
                view.transform = CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale)
            }
        }
        recognizer.scale = 1.0
    }
    
    func rotate(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view as? LayerView {
            if view.selected {
                view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
            }
        }
        recognizer.rotation = 0
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(context)
        
        if self.selected {
            let path = UIBezierPath(rect: self.bounds)
            self.debugColor.setFill()
            path.fill()
        }
        
        CGContextRestoreGState(context)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
