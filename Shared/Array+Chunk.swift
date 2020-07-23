//
//  Array+Chunck.swift
//  Drawing
//
//  Created by Aaron Wright on 7/22/20.
//

import Foundation

extension Array {
    
    func chunk(size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            return Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
}
