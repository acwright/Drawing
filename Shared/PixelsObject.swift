//
//  PixelsObject.swift
//  Drawing
//
//  Created by Aaron Wright on 7/23/20.
//

import SwiftUI

class PixelsObject: ObservableObject {
    
    @Published var size: Int
    @Published var pixels: [PixelObject]
 
    init(size: Int = 16) {
        self.size = size
        self.pixels = PixelObject.empty(size: size)
    }
    
    func resize(to size: Int) {
        self.size = size
        self.pixels = PixelObject.empty(size: size)
    }
    
    func clear() {
        for pixel in pixels {
            pixel.color = Color.black
        }
    }
    
    func random() {
        for pixel in pixels {
            pixel.color = Color(red: .random(in: 0...1),
                                green: .random(in: 0...1),
                                blue: .random(in: 0...1))
        }
    }
    
}
