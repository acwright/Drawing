//
//  CanvasViewController.swift
//  Drawing
//
//  Created by Aaron Wright on 1/25/15.
//  Copyright (c) 2015 Aaron Wright. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rectView1 = RectangleView(frame: CGRect(x: 30, y: 30, width: 100, height: 100))
        rectView1.debugColor = UIColor.green
        rectView1.fillColor = UIColor.yellow
        rectView1.strokeColor = UIColor.black
        rectView1.strokeWidth = 1.0
        self.view.addSubview(rectView1)
        
        let rectView2 = RectangleView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        rectView2.debugColor = UIColor.green
        rectView2.fillColor = UIColor.blue
        rectView2.cornerRadius = 10.0
        self.view.addSubview(rectView2)
    }

}
