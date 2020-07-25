//
//  CanvasView.swift
//  Drawing
//
//  Created by Aaron Wright on 7/25/20.
//

import SwiftUI

struct CanvasView: View {
    
    @Binding var pixels: Pixels
    
    @Binding var scale: CGFloat
    @Binding var primaryColor: Color
    @Binding var secondaryColor: Color
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    LayerView(size: $pixels.size, pixels: $pixels)
                    .drawingGroup()
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
                pixels.pixels[y * pixels.size + x] = Pixel(color: color)
            }
        }
    }

    func pixel(for point: CGPoint) -> Pixel {
        return pixels.pixels[(Int(point.y) * pixels.size) + Int(point.x)]
    }
    
}

struct CanvasView_Previews: PreviewProvider {
    
    static var previews: some View {
        CanvasView(pixels: .constant(Pixels(size: 16)), scale: .constant(8), primaryColor: .constant(Color.black), secondaryColor: .constant(Color.white))
    }
    
}
