//
//  ShapeView.swift
//  Drawing
//
//  Created by Aaron Wright on 10/30/14.
//  Copyright (c) 2014 Aaron Wright. All rights reserved.
//

import UIKit

class ShapeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup() {
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.5)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if let backgroundColor = self.backgroundColor {
            backgroundColor.setFill()
            CGContextFillRect(UIGraphicsGetCurrentContext(), self.bounds)
        }
    }

}
