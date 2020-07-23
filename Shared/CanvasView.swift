//
//  CanvasView.swift
//  Drawing
//
//  Created by Aaron Wright on 7/23/20.
//

import SwiftUI

struct CanvasView: View {
    
    @ObservedObject var pixels: Pixels
    
    @Binding var scale: CGFloat
    @Binding var primaryColor: Color
    @Binding var secondaryColor: Color
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    VStack(spacing: 1) {
                        HStack(spacing: 1) {
                            LayerView(size: $pixels.size, pixels: $pixels.pixels[0])
                                .frame(width: self.width(), height: self.height())
                            LayerView(size: $pixels.size, pixels: $pixels.pixels[1])
                                .frame(width: self.width(), height: self.height())
                        }
                        HStack(spacing: 1) {
                            LayerView(size: $pixels.size, pixels: $pixels.pixels[2])
                                .frame(width: self.width(), height: self.height())
                            LayerView(size: $pixels.size, pixels: $pixels.pixels[3])
                                .frame(width: self.width(), height: self.height())
                        }
                    }
                    .contentShape(Rectangle())
                    .gesture(
                        gesture(geometry: geometry)
                    )
                }
            }
            .frame(width: self.width() * 2, height: self.height() * 2)
        }
    }
    
    func width() -> CGFloat {
        $scale.wrappedValue * CGFloat(pixels.size)
    }

    func height() -> CGFloat {
        $scale.wrappedValue * CGFloat(pixels.size)
    }
    
    func gesture(geometry: GeometryProxy) -> some Gesture {
        #if os(iOS)
        return primaryGesture(geometry: geometry)
        #elseif os(macOS)
        return ExclusiveGesture(secondaryGesture(geometry: geometry), primaryGesture(geometry: geometry))
        #endif
    }
    
    func primaryGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0.1)
            .onChanged({ (value) in
                self.draw(at: value.location, color: self.primaryColor, geometry: geometry)
            })
    }
    
    #if os(macOS)
    func secondaryGesture(geometry: GeometryProxy) -> some Gesture {
        return DragGesture(minimumDistance: 0.1)
            .modifiers(.option)
            .onChanged({ (value) in
                self.draw(at: value.location, color: self.secondaryColor, geometry: geometry)
            })
    }
    #endif
    
    func draw(at point: CGPoint, color: Color, geometry: GeometryProxy) {
        if point.x >= 0 && point.x < geometry.size.width && point.y >= 0 && point.y < geometry.size.height {
            let x = Int(point.x / (geometry.size.width / CGFloat(pixels.size * 2)))
            let y = Int(point.y / (geometry.size.height / CGFloat(pixels.size * 2)))
            
            let pixel = self.pixel(for: CGPoint(x: x, y: y))

            if pixel.color != color {
                pixel.color = color
            }
        }
    }
    
    func pixel(for point: CGPoint) -> Pixel {
        if point.x / CGFloat(pixels.size) < 1  && point.y / CGFloat(pixels.size) < 1 {
            return pixels.pixels[0][(Int(point.y) * pixels.size) + Int(point.x)]
        }
        if point.x / CGFloat(pixels.size) >= 1  && point.y / CGFloat(pixels.size) < 1 {
            return pixels.pixels[1][(Int(point.y) * pixels.size) + Int(point.x - CGFloat(pixels.size))]
        }
        if point.x / CGFloat(pixels.size) < 1  && point.y / CGFloat(pixels.size) >= 1 {
            return pixels.pixels[2][(Int(point.y - CGFloat(pixels.size)) * pixels.size) + Int(point.x)]
        }
        if point.x / CGFloat(pixels.size) >= 1  && point.y / CGFloat(pixels.size) >= 1 {
            return pixels.pixels[3][(Int(point.y - CGFloat(pixels.size)) * pixels.size) + Int(point.x - CGFloat(pixels.size))]
        }
        
        return Pixel()
    }
    
}

struct CanvasView_Previews: PreviewProvider {
    
    static var previews: some View {
        CanvasView(pixels: Pixels(), scale: .constant(8), primaryColor: .constant(Color.black), secondaryColor: .constant(Color.white))
    }
    
}
