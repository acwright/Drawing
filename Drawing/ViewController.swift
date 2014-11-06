//
//  ViewController.swift
//  Drawing
//
//  Created by Aaron Wright on 10/29/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func doSelect(sender: AnyObject) {
        (self.view as CanvasView).drawMode = false
        (self.view as CanvasView).selectMode = true
    }
    
    @IBAction func doDraw(sender: AnyObject) {
        (self.view as CanvasView).drawMode = true
        (self.view as CanvasView).selectMode = false
    }
    
    @IBAction func doRotate(sender: AnyObject) {
        (self.view as CanvasView).rotate()
    }
}

