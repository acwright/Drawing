//
//  PixelObjectView.swift
//  Drawing
//
//  Created by Aaron Wright on 7/22/20.
//

import SwiftUI

struct PixelObjectView: View {
    
    @ObservedObject var pixel: PixelObject
    
    var body: some View {
        Rectangle()
            .fill(self.pixel.color)
    }
    
}

struct PixelObjectView_Previews: PreviewProvider {
    
    static var previews: some View {
        PixelObjectView(pixel: PixelObject())
    }
    
}
