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

        let rectView1 = RectangleView(frame: CGRectMake(30, 30, 100, 100))
        rectView1.debugColor = UIColor.greenColor()
        rectView1.fillColor = UIColor.yellowColor()
        rectView1.strokeColor = UIColor.blackColor()
        rectView1.strokeWidth = 1.0
        self.view.addSubview(rectView1)
        
        let rectView2 = RectangleView(frame: CGRectMake(50, 50, 100, 100))
        rectView2.debugColor = UIColor.greenColor()
        rectView2.fillColor = UIColor.blueColor()
        rectView2.cornerRadius = 10.0
        self.view.addSubview(rectView2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
