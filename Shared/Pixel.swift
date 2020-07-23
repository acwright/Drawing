//
//  Pixel.swift
//  Drawing
//
//  Created by Aaron Wright on 7/22/20.
//

import SwiftUI

class Pixel: ObservableObject, Identifiable {
    
    var id: UUID = UUID()
    
    @Published var color: Color = Color.clear
    
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
        hasher.combine(ObjectIdentifier(self))
    }
    
}

// MARK: - Equatable

extension Pixel: Equatable {
    
    static func == (lhs: Pixel, rhs: Pixel) -> Bool {
        lhs.id == rhs.id
    }
    
}
