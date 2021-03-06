//
//  Pixel.swift
//  Drawing (iOS)
//
//  Created by Aaron Wright on 7/25/20.
//

import SwiftUI

struct Pixel: Identifiable {
    
    let id: UUID = UUID()
    
    var color: Color = Color.black
    
}

// MARK: - Methods

extension Pixel {
    
    static func empty(size: Int) -> [Pixel] {
        var data: [Pixel] = []
        
        for _ in 1...(size * size) {
            data.append(Pixel())
        }
        
        return data
    }
    
}

// MARK: - Hashable

extension Pixel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

// MARK: - Equatable

extension Pixel: Equatable {
    
    static func == (lhs: Pixel, rhs: Pixel) -> Bool {
        lhs.id == rhs.id
    }
    
}
