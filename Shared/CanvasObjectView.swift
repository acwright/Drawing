//
//  CanvasObjectView.swift
//  Drawing
//
//  Created by Aaron Wright on 7/23/20.
//

import SwiftUI

struct CanvasObjectView: View {
    
    @ObservedObject var pixels: PixelsObject
    
    @Binding var scale: CGFloat
    @Binding var primaryColor: Color
    @Binding var secondaryColor: Color
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    LayerObjectView(size: $pixels.size, pixels: $pixels.pixels)
                    .frame(width: self.width(), height: self.height())
                    .contentShape(Rectangle())
                    .gesture(
                        gesture(geometry: geometry)
                    )
                    .onHover { inside in
                        #if os(macOS)
                        if inside {
                            NSCursor.crosshair.push()
                        } else {
                            NSCursor.pop()
                        }
                        #endif
                    }
                }
            }
            .frame(width: self.width(), height: self.height())
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
            let x = Int(point.x / (geometry.size.width / CGFloat(pixels.size)))
            let y = Int(point.y / (geometry.size.height / CGFloat(pixels.size)))
            
            let pixel = self.pixel(for: CGPoint(x: x, y: y))

            if pixel.color != color {
                pixel.color = color
            }
        }
    }
    
    func pixel(for point: CGPoint) -> PixelObject {
        pixels.pixels[(Int(point.y) * pixels.size) + Int(point.x)]
    }
    
}

struct CanvasObjectView_Previews: PreviewProvider {
    
    static var previews: some View {
        CanvasObjectView(pixels: PixelsObject(), scale: .constant(8), primaryColor: .constant(Color.black), secondaryColor: .constant(Color.white))
    }
    
}
