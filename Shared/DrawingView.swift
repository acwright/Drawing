//
//  DrawingView.swift
//  Shared
//
//  Created by Aaron Wright on 7/21/20.
//

import SwiftUI

struct DrawingView: View {
    
    @StateObject private var pixelObjects: PixelsObject = PixelsObject()
    @State private var pixels: Pixels = Pixels()
    
    @State private var primaryColor: Color = .white
    @State private var secondaryColor: Color = .clear
    @State private var scale: CGFloat = 8
    @State private var objects: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                ColorPicker(selection: $primaryColor, supportsOpacity: false, label: {})
                    .frame(width: 30, height: 30)
                
                Spacer()
                
                Button {
                    objects.toggle()
                } label: {
                    Text(objects ? "Use Structs" : "Use Objects")
                }
                
                HStack {
                    Button {
                        pixelObjects.random()
                        pixels.random()
                    } label: {
                        Text("Randomize")
                    }
                    
                    Button {
                        pixelObjects.clear()
                        pixels.clear()
                    } label: {
                        Text("Clear")
                    }
                    
                    Button {
                        if pixelObjects.size > 1 {
                            pixelObjects.resize(to: pixelObjects.size - 1)
                        }
                        if pixels.size > 1 {
                            pixels.resize(to: pixels.size - 1)
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                    
                    Text("\(Int(pixels.size)) px")
                    
                    Button {
                        pixelObjects.resize(to: pixels.size + 1)
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
            }
            .zIndex(1)
            .padding(20)
            .background(Color.black.opacity(0.6))
            .cornerRadius(8)
            
            if objects {
                CanvasObjectView(pixels: pixelObjects, scale: $scale, primaryColor: $primaryColor, secondaryColor: $secondaryColor)
            } else {
                CanvasView(pixels: $pixels, scale: $scale, primaryColor: $primaryColor, secondaryColor: $secondaryColor)
            }
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
