//
//  DrawingView.swift
//  Shared
//
//  Created by Aaron Wright on 7/21/20.
//

import SwiftUI

struct DrawingView: View {
    
    @StateObject private var pixels: Pixels = Pixels()
    
    @State private var primaryColor: Color = .white
    @State private var secondaryColor: Color = .clear
    @State private var scale: CGFloat = 8
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                ColorPicker(selection: $primaryColor, supportsOpacity: false, label: {})
                    .frame(width: 30, height: 30)
                
                Spacer()
                
                Button {
                    pixels.random()
                } label: {
                    Text("Randomize")
                }
                
                Button {
                    pixels.clear()
                } label: {
                    Text("Clear")
                }
                
                Button {
                    if pixels.size > 1 {
                        pixels.resize(to: pixels.size - 1)
                    }
                } label: {
                    Image(systemName: "minus")
                }
                
                Text("\(Int(pixels.size)) px")
                
                Button {
                    pixels.resize(to: pixels.size + 1)
                } label: {
                    Image(systemName: "plus")
                }
                
                Button {
                    if self.scale > 1 {
                        self.scale -= 1
                    }
                } label: {
                    Image(systemName: "minus.magnifyingglass")
                }
                
                Text("\(Int($scale.wrappedValue)) x")
                
                Button {
                    self.scale += 1
                } label: {
                    Image(systemName: "plus.magnifyingglass")
                }
            }
            .zIndex(1)
            .padding(20)
            .background(Color.black.opacity(0.6))
            .cornerRadius(8)
            
            CanvasView(pixels: pixels, scale: $scale, primaryColor: $primaryColor, secondaryColor: $secondaryColor)
        }
        .padding()
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
    }
    
}

struct DrawingView_Previews: PreviewProvider {
    
    static var previews: some View {
        DrawingView()
            .previewLayout(.sizeThatFits)
    }
    
}
