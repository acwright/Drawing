//
//  ViewController.swift
//  Drawing
//
//  Created by Aaron Wright on 10/29/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    var multiplier: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let canvasView = self.view as CanvasView
        
        let layer = Rectangle()
        layer.x = 50.0
        layer.y = 50.0
        layer.offsetX = 0.0
        layer.offsetY = 0.0
        layer.rotation = 0.0
        layer.scaleX = 1.0
        layer.scaleY = 1.0
        layer.width = 20.0
        layer.height = 20.0
        layer.strokeWidth = 0.0
        layer.strokeColor = UIColor.blackColor()
        layer.backgroundColor = UIColor.greenColor()
        
        canvasView.addLayer(layer)
    }
    
    @IBAction func debug(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.debug = !canvasView.debug
    }
    
    @IBAction func X(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        for layer in canvasView.layers {
            layer.x += 10.0 * multiplier
        }
    }
    
    @IBAction func offX(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        for layer in canvasView.layers {
            layer.offsetX += 10.0 * multiplier
        }
    }
    
    @IBAction func Y(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        for layer in canvasView.layers {
            layer.y += 10.0 * multiplier
        }
    }
    
    @IBAction func offY(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        for layer in canvasView.layers {
            layer.offsetY += 10.0 * multiplier
        }
    }
    
    @IBAction func W(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        for layer in canvasView.layers {
            layer.width += 10.0 * multiplier
        }
    }
    
    @IBAction func H(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        for layer in canvasView.layers {
            layer.height += 10.0 * multiplier
        }
    }
    
    @IBAction func tl(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.TopLeft
    }
    
    @IBAction func tm(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.TopMiddle
    }
    
    @IBAction func tr(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.TopRight
    }
    
    @IBAction func ml(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.MiddleLeft
    }
    
    @IBAction func mr(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.MiddleRight
    }
    
    @IBAction func bl(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.BottomLeft
    }
    
    @IBAction func bm(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.BottomMiddle
    }
    
    @IBAction func br(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.BottomRight
    }
    
    @IBAction func m(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        canvasView.corner = Layer.Corner.Middle
    }
    
    @IBAction func rotate(sender: AnyObject) {
        let canvasView = self.view as CanvasView
        
        for layer in canvasView.layers {
            layer.rotation -= 10.0 * multiplier
        }
    }
    
    @IBAction func multiplier(sender: AnyObject) {
        let _switch = sender as UISwitch
        
        if _switch.on {
            self.multiplier = 1.0
        } else {
            self.multiplier = -1.0
        }
    }
}

