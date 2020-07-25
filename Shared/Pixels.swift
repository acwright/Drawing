//
//  Pixels.swift
//  Drawing
//
//  Created by Aaron Wright on 7/25/20.
//

import SwiftUI

struct Pixels {
    
    var size: Int
    var pixels: [Pixel]
 
    init(size: Int = 16) {
        self.size = size
        self.pixels = Pixel.empty(size: size)
    }
    
    mutating func resize(to size: Int) {
        self.size = size
        self.pixels = Pixel.empty(size: size)
    }
    
    mutating func clear() {
        pixels = pixels.map({ (pixel) -> Pixel in
            Pixel(color: .black)
        })
    }
    
    mutating func random() {
        pixels = pixels.map { (pixel) -> Pixel in
            Pixel(color: Color(red: .random(in: 0...1),
                               green: .random(in: 0...1),
                               blue: .random(in: 0...1)))
        }
    }
    
}
