//
//  LayerView.swift
//  Drawing
//
//  Created by Aaron Wright on 7/25/20.
//

import SwiftUI

struct LayerView: View {
    
    @Binding var size: Int
    @Binding var pixels: Pixels
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.width > CGFloat(size * 3) ? 1 : 0) {
                ForEach(self.pixels.pixels.chunk(size: self.size), id: \.self) { row in
                    HStack(spacing: geometry.size.height > CGFloat(size * 3) ? 1 : 0) {
                        ForEach(row) { pixel in
                            PixelView(pixel: pixel)
                        }
                    }
                }
            }
        }
    }
    
}

struct LayerView_Previews: PreviewProvider {
    
    static var previews: some View {
        LayerView(size: .constant(16), pixels: .constant(Pixels(size: 16)))
            .previewLayout(.sizeThatFits)
            .frame(width: 512, height: 512)
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
    
}
