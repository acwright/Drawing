//
//  PixelView.swift
//  Drawing
//
//  Created by Aaron Wright on 7/22/20.
//

import SwiftUI

struct PixelView: View {
    
    @ObservedObject var pixel: Pixel
    
    var body: some View {
        Rectangle()
            .fill(self.pixel.color)
    }
    
}

struct PixelView_Previews: PreviewProvider {
    
    static var previews: some View {
        PixelView(pixel: Pixel())
    }
    
}
