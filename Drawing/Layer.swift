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
            self.delegate?.layerDidUpdate(self)
        }
    }
    var y: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    var width: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    var height: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    var rotation: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    var offsetX: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    var offsetY: CGFloat = 0.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    var scaleX: CGFloat = 1.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    var scaleY: CGFloat = 1.0 {
        didSet {
            self.delegate?.layerDidUpdate(self)
        }
    }
    
    var delegate: LayerDelegate?
    
    func drawInContext(context: CGContextRef) {
        // Do nothing
    }
    
    func drag(corner: Corner, offsetX: CGFloat, offsetY: CGFloat) {
        switch corner {
        case .TopLeft:
            self.x -= offsetX
            self.y -= offsetY
            self.width += offsetX
            self.height += offsetY
            break
        case .TopMiddle:
            self.y -= offsetY
            self.height += offsetY
            break
        case .TopRight:
            self.y -= offsetY
            self.height += offsetY
            self.width -= offsetX
            break
        case .MiddleLeft:
            self.x -= offsetX
            self.width += offsetX
            break
        case .MiddleRight:
            self.width -= offsetX
            break
        case .BottomLeft:
            self.x -= offsetX
            self.width += offsetX
            self.height -= offsetY
            break
        case .BottomMiddle:
            self.height -= offsetY
            break
        case .BottomRight:
            self.width -= offsetX
            self.height -= offsetY
            break
        case .Middle:
            self.x -= offsetX
            self.y -= offsetY
            break
        case .None:
            fallthrough
        default:
            return
        }
    }
}
