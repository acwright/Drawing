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
    
    var debugColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var canvas: CGRect = CGRect.zero {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
        tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        panRecognizer.delegate = self
        panRecognizer.minimumNumberOfTouches = 1
        panRecognizer.maximumNumberOfTouches = 1
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        pinchRecognizer.delegate = self
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotate(recognizer:)))
        rotationRecognizer.delegate = self
        
        self.addGestureRecognizer(tapRecognizer)
        self.addGestureRecognizer(panRecognizer)
        self.addGestureRecognizer(pinchRecognizer)
        self.addGestureRecognizer(rotationRecognizer)
        
        self.canvas = self.bounds.offsetBy(dx: 10, dy: 10)
        self.frame = CGRect(x: self.frame.origin.x - 10, y: self.frame.origin.y - 10, width: self.frame.size.width + 20, height: self.frame.size.height + 20)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view as? LayerView {
            view.selected = !view.selected
        }
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        if let superview = self.superview {
            let translation = recognizer.translation(in: superview)
            
            if let view = recognizer.view as? LayerView {
                if view.selected {
                    view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
                }
            }
            
            recognizer.setTranslation(CGPoint.zero, in: superview)
        }
    }
    
    @objc func pinch(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view as? LayerView {
            if view.selected {
                view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            }
        }
        recognizer.scale = 1.0
    }
    
    @objc func rotate(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view as? LayerView {
            if view.selected {
                view.transform = view.transform.rotated(by: recognizer.rotation)
            }
        }
        recognizer.rotation = 0
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        context.saveGState()
        
        if self.selected {
            let path = UIBezierPath(rect: self.bounds)
            self.debugColor.setFill()
            path.fill()
        }
        
        context.restoreGState()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
