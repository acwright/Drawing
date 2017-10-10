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
        
        let canvasView = self.view as! CanvasView
        
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
        layer.strokeColor = UIColor.black
        layer.backgroundColor = UIColor.green
        
        canvasView.addLayer(layer: layer)
    }
    
    @IBAction func debug(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.debug = !canvasView.debug
    }
    
    @IBAction func X(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        for layer in canvasView.layers {
            layer.x += 10.0 * multiplier
        }
    }
    
    @IBAction func offX(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        for layer in canvasView.layers {
            layer.offsetX += 10.0 * multiplier
        }
    }
    
    @IBAction func Y(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        for layer in canvasView.layers {
            layer.y += 10.0 * multiplier
        }
    }
    
    @IBAction func offY(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        for layer in canvasView.layers {
            layer.offsetY += 10.0 * multiplier
        }
    }
    
    @IBAction func W(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        for layer in canvasView.layers {
            layer.width += 10.0 * multiplier
        }
    }
    
    @IBAction func H(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        for layer in canvasView.layers {
            layer.height += 10.0 * multiplier
        }
    }
    
    @IBAction func tl(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.TopLeft
    }
    
    @IBAction func tm(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.TopMiddle
    }
    
    @IBAction func tr(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.TopRight
    }
    
    @IBAction func ml(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.MiddleLeft
    }
    
    @IBAction func mr(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.MiddleRight
    }
    
    @IBAction func bl(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.BottomLeft
    }
    
    @IBAction func bm(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.BottomMiddle
    }
    
    @IBAction func br(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.BottomRight
    }
    
    @IBAction func m(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        canvasView.corner = Layer.Corner.Middle
    }
    
    @IBAction func rotate(_ sender: AnyObject) {
        let canvasView = self.view as! CanvasView
        
        for layer in canvasView.layers {
            layer.rotation -= 10.0 * multiplier
        }
    }
    
    @IBAction func multiplier(_ sender: AnyObject) {
        let _switch = sender as! UISwitch
        
        if _switch.isOn {
            self.multiplier = 1.0
        } else {
            self.multiplier = -1.0
        }
    }
}

