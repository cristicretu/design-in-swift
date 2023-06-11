//
//  ContentView.swift
//  SwiftUI for designers
//
//  Created by Cristian Cretu on 11.06.2023.
//

import SwiftUI

struct TextStyle: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: .rounded))
    }
}

extension View {
    func rounded(size: CGFloat = 16.0, weight: Font.Weight = .regular) -> some View {
        self.modifier(TextStyle(size: size, weight: weight))
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterialDark
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct ContentView: View {
    let direction = "111° E"
    let coordinates = "47.3769° N, 8.5417° E"
    @ObservedObject var compassHeading = CompassHeading()
    
    var body: some View {
        ZStack {
            Text("Scanning for gems")
                .rounded(size: 28.0, weight: .semibold)
                .foregroundColor(.white.opacity(0.9))
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 8)
            
            ZStack {
                // white blur
                Circle()
                    .frame(width: 300)
                    .blur(radius: 100)
                // outer white
                Circle()
                    .foregroundColor(.white.opacity(0.05))
                    .frame(width: 380)
                // bg
                Circle()
                    .frame(width: 340)
                    .foregroundColor(.black.opacity(0.94))
                
                Circle()
                    .foregroundColor(.white.opacity(0.04))
                    .frame(width: 340)
    
                Circle()
                    .foregroundColor(.black.opacity(0.5))
                    .frame(width: 260)
                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 200)
                    .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.03), lineWidth: 3)
                        )
                
                Circle()
                    .foregroundColor(.white.opacity(0.01))
                    .frame(width: 70)
                    .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.03), lineWidth: 3)
                        )
                Compass()
            }
            .scaleEffect(1.4)
            .position(x: UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 1.8)
            
            
            ZStack {
                Color(.black)
                    .background(Blur())
                    .frame(width: UIScreen.main.bounds.width, height: 500)
                    .mask(LinearGradient(
                        gradient:
                            Gradient(
                                stops: [.init(color: .black, location: 0.4),
                                        .init(color: .black, location: 0.5),
                                        .init(color: .clear, location: 1)
                                ]),
                        startPoint: .bottom, endPoint: .top
                        
                    ))
                Coordinates(direction: direction, coordinates: coordinates)
            }
            .position(x: UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 1.25)
            
        }
//        .overlay(
//            LinearGradient(
//                gradient:
//                    Gradient(
//                        stops: [.init(color: .black, location: -1),
//                                .init(color: .clear, location: 0.5),
//                                .init(color: .black, location: 2)
//                        ]),
//                startPoint: .leading, endPoint: .trailing
//
//            )
//        )
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
