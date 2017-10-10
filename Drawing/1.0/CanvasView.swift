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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup() {
        
        self.backgroundColor = UIColor.white
    }
    
    func addLayer(layer: Layer) {
        layer.delegate = self
        self.layers.append(layer)
        self.setNeedsDisplay()
    }
    
    func boundingRectForLayer(layer: Layer) -> CGRect {
        var translate = CGAffineTransform(translationX: layer.x, y: layer.y)
        translate = CGAffineTransform(rotationAngle: layer.rotation * CGFloat.pi / 180.0).concatenating(translate) // New transform must come first!
        translate = CGAffineTransform(scaleX: layer.scaleX, y: layer.scaleY).concatenating(translate) // New transform must come first!
        
        return CGRect(x: layer.offsetX, y: layer.offsetY, width: layer.width, height: layer.height).applying(translate)
    }
    
    func drawLayerDebugInContext(layer: Layer, context: CGContext) {
        context.saveGState()
        
        let boundingPath = UIBezierPath(rect: self.boundingRectForLayer(layer: layer))
        
        UIColor.red.setStroke()
        boundingPath.stroke()
        
        let originPath = UIBezierPath(ovalIn: CGRect(x: layer.x - 5.0, y: layer.y - 5.0, width: 10.0, height: 10.0))
        
        UIColor.blue.setFill()
        originPath.fill()
        
        context.restoreGState()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        for layer in layers {
            layer.drawInContext(context: context)
            
            if self.debug {
                self.drawLayerDebugInContext(layer: layer, context: context)
            }
        }
    }
    
    // MARK: LayerDelegate
    
    func layerDidUpdate(layer: Layer) {
        self.setNeedsDisplay()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        
        let deltaX = previousLocation.x - location.x
        let deltaY = previousLocation.y - location.y
        
        for layer in self.layers {
            layer.drag(corner: self.corner, deltaX: deltaX, deltaY: deltaY)
        }
    }

}
