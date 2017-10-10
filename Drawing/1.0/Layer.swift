//
//  Layer.swift
//  Drawing
//
//  Created by Aaron Wright on 11/6/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

protocol LayerDelegate{
    func layerDidUpdate(layer: Layer)
}

class Layer: NSObject {
    
    enum Corner {
        case TopLeft
        case TopMiddle
        case TopRight
        case MiddleLeft
        case MiddleRight
        case BottomLeft
        case BottomMiddle
        case BottomRight
        case Middle
        case None
    }
   
    var x: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var y: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var width: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var height: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var rotation: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var offsetX: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var offsetY: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var scaleX: CGFloat = 1.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    var scaleY: CGFloat = 1.0 {
        didSet {
            self.delegate?.layerDidUpdate(layer: self)
        }
    }
    
    var delegate: LayerDelegate?
    
    func drawInContext(context: CGContext) {
        // Do nothing
    }
    
    func drag(corner: Corner, deltaX: CGFloat, deltaY: CGFloat) {
        switch corner {
        case .TopLeft:
            self.x -= deltaX // Fix
            self.y -= cos(abs(self.rotation * CGFloat.pi / 180.0)) * deltaY
            self.width += deltaX
            self.height += deltaY
            break
        case .TopMiddle:
            self.x -= sin(abs(self.rotation * CGFloat.pi / 180.0)) * deltaY
            self.y -= cos(abs(self.rotation * CGFloat.pi / 180.0)) * deltaY
            self.height += deltaY
            break
        case .TopRight:
            self.x -= sin(abs(self.rotation * CGFloat.pi / 180.0)) * deltaY
            self.y -= cos(abs(self.rotation * CGFloat.pi / 180.0)) * deltaY
            self.height += deltaY
            self.width -= deltaX
            break
        case .MiddleLeft:
            self.y += sin(abs(self.rotation * CGFloat.pi / 180.0)) * deltaX
            self.x -= cos(abs(self.rotation * CGFloat.pi / 180.0)) * deltaX
            self.width += deltaX
            break
        case .MiddleRight:
            self.width -= deltaX
            break
        case .BottomLeft:
            self.x -= deltaX // Fix
            self.width += deltaX
            self.height -= deltaY
            break
        case .BottomMiddle:
            self.height -= deltaY
            break
        case .BottomRight:
            self.width -= deltaX
            self.height -= deltaY
            break
        case .Middle:
            self.x -= deltaX
            self.y -= deltaY
            break
        case .None:
            fallthrough
        default:
            return
        }
    }
}
