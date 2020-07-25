//
//  PixelObject.swift
//  Drawing
//
//  Created by Aaron Wright on 7/22/20.
//

import SwiftUI

class PixelObject: ObservableObject, Identifiable {
    
    var id: UUID = UUID()
    
    @Published var color: Color = Color.black
    
}

// MARK: - Methods

extension PixelObject {
    
    static func empty(size: Int) -> [PixelObject] {
        var data: [PixelObject] = []
        
        for _ in 1...(size * size) {
            data.append(PixelObject())
        }
        
        return data
    }
    
}

// MARK: - Hashable

extension PixelObject: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
}

// MARK: - Equatable

extension PixelObject: Equatable {
    
    static func == (lhs: PixelObject, rhs: PixelObject) -> Bool {
        lhs.id == rhs.id
    }
    
}
