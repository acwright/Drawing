//
//  LayerObjectView.swift
//  Drawing
//
//  Created by Aaron Wright on 7/21/20.
//

import SwiftUI

struct LayerObjectView: View {
    
    @Binding var size: Int
    @Binding var pixels: [PixelObject]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.width > CGFloat(size * 3) ? 1 : 0) {
                ForEach(self.pixels.chunk(size: self.size), id: \.self) { row in
                    HStack(spacing: geometry.size.height > CGFloat(size * 3) ? 1 : 0) {
                        ForEach(row) { pixel in
                            PixelObjectView(pixel: pixel)
                        }
                    }
                }
            }
        }
    }
    
}

struct LayerObjectView_Previews: PreviewProvider {
    
    static var previews: some View {
        LayerObjectView(size: .constant(16), pixels: .constant(PixelObject.empty(size: 16)))
            .previewLayout(.sizeThatFits)
            .frame(width: 512, height: 512)
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
    
}
