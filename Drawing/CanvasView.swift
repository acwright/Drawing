//
//  CanvasView.swift
//  Drawing
//
//  Created by Aaron Wright on 10/29/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class CanvasView: UIView, LayerDelegate {
    
    var corner: Layer.Corner = Layer.Corner.BottomRight
    
    var layers: [Layer] = []
    var debug: Bool = false {
        didSet {
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
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func addLayer(layer: Layer) {
        layer.delegate = self
        self.layers.append(layer)
        self.setNeedsDisplay()
    }
    
    func boundingRectForLayer(layer: Layer) -> CGRect {
        var translate = CGAffineTransformMakeTranslation(layer.x, layer.y)
        translate = CGAffineTransformConcat(CGAffineTransformMakeRotation(layer.rotation * CGFloat(M_PI) / 180.0), translate) // New transform must come first!
        translate = CGAffineTransformConcat(CGAffineTransformMakeScale(layer.scaleX, layer.scaleY), translate) // New transform must come first!
        
        return CGRectApplyAffineTransform(CGRectMake(layer.offsetX, layer.offsetY, layer.width, layer.height), translate)
    }
    
    func drawLayerDebugInContext(layer: Layer, context: CGContextRef) {
        CGContextSaveGState(context)
        
        let path = UIBezierPath(rect: self.boundingRectForLayer(layer))
        
        UIColor.redColor().setStroke()
        path.stroke()
        
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(layer.x - 5.0, layer.y - 5.0, 10.0, 10.0))
        UIColor.blueColor().setFill()
        ovalPath.fill()
        
        CGContextRestoreGState(context)
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        for layer in layers {
            layer.drawInContext(context)
            
            if self.debug {
                self.drawLayerDebugInContext(layer, context: context)
            }
        }
    }
    
    // MARK: LayerDelegate
    
    func layerDidUpdate(layer: Layer) {
        self.setNeedsDisplay()
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        let touch = touches.anyObject() as UITouch
//        let location = touch.locationInView(self)
//        
//        self.controlView.selected = false
//        
//        if self.selectMode {
//            if let view = self.hitTest(location, withEvent: event) {
//                if view != self {
//                    if view.isKindOfClass(ShapeView) {
//                        let shapeView = view as ShapeView
//                        
//                        self.controlView.controlledView = shapeView
//                        self.controlView.selected = true
//                    }
//                    if view.isKindOfClass(ControlView) {
//                        self.controlView.selected = true
//                    }
//                }
//            }
//        }
//    }
//    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInView(self)
        let previousLocation = touch.previousLocationInView(self)
        
        let x = previousLocation.x - location.x
        let y = previousLocation.y - location.y
        
        for layer in self.layers {
            layer.drag(self.corner, offsetX: x, offsetY: y)
        }
    }
//
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        if self.drawMode {
//            self.drawMode = false
//            self.selectMode = true
//            
//            if let activeView = self.activeView {
//                self.controlView.selected = true
//                self.controlView.controlledView = activeView
//                
//                self.activeView = nil
//            }
//        }
//    }

}
