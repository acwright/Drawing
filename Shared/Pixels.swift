//
//  Pixels.swift
//  Drawing
//
//  Created by Aaron Wright on 7/23/20.
//

import SwiftUI

class Pixels: ObservableObject {
    
    @Published var size: Int
    @Published var pixels: [[Pixel]]
 
    init(size: Int = 16) {
        var pixels: [[Pixel]] = []
        pixels.append(Pixel.empty(size: size))
        pixels.append(Pixel.empty(size: size))
        pixels.append(Pixel.empty(size: size))
        pixels.append(Pixel.empty(size: size))
        
        self.size = size
        self.pixels = pixels
    }
    
    func resize(to size: Int) {
        var pixels: [[Pixel]] = []
        pixels.append(Pixel.empty(size: size))
        pixels.append(Pixel.empty(size: size))
        pixels.append(Pixel.empty(size: size))
        pixels.append(Pixel.empty(size: size))
        
        self.size = size
        self.pixels = pixels
    }
    
    func clear() {
        for pixelSet in pixels {
            for pixel in pixelSet {
                pixel.color = Color.black
            }
        }
    }
    
    func random() {
        for pixelSet in pixels {
            for pixel in pixelSet {
                pixel.color = Color(red: .random(in: 0...1),
                                    green: .random(in: 0...1),
                                    blue: .random(in: 0...1))
            }
        }
    }
    
}
