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
    let coordinates = "47.3769° N, 8.5417° E"
    @ObservedObject var compassHeading = CompassHeading()
    
    @State var compassState: String = "111° E"
    @State var animate = false

    var body: some View {
        ZStack {
            Text("Scanning for gems")
                .rounded(size: 24.0, weight: .semibold)
                .foregroundColor(.white.opacity(0.9))
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 10)
            
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
                
                
                // blob
                
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.indigo, .purple, .blue, .indigo, .blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .blur(radius: 40)
                    .frame(width: 120)
                
                Circle()
                    .trim(from: 0.5, to: 1)

                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.indigo, .white]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .blur(radius: 20)
                    .frame(width: 100)
                    .rotationEffect(Angle(degrees: -Double(Int(self.compassHeading.degrees))))
                    .scaleEffect(self.animate ? 1 : 0.7)
                    .opacity(self.animate ? 1 : 0.6)
                    .onAppear { self.animate.toggle() }
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))

                
                Compass(compasDegrees: self.compassHeading.degrees)
            }
            .rotationEffect(Angle(degrees: Double(Int(self.compassHeading.degrees))))
            .scaleEffect(1.5)
            .animation(Animation.spring(), value: self.compassState)
            .position(x: UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 1.8)
            .onReceive(compassHeading.objectWillChange) { _ in
                updateCompassState()
            }
            
            
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
                Coordinates(direction: compassState, coordinates: coordinates)
            }
            .position(x: UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 1.25)
            
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .statusBar(hidden: true)
    }
    
    func updateCompassState() {
        let direction: Double = abs(compassHeading.degrees)
        var letter: String = ""

        if direction >= 337.5 || direction < 22.5 {
            letter = "N"
        } else if direction >= 22.5 && direction < 67.5 {
            letter = "NE"
        } else if direction >= 67.5 && direction < 112.5 {
            letter = "E"
        } else if direction >= 112.5 && direction < 157.5 {
            letter = "SE"
        } else if direction >= 157.5 && direction < 202.5 {
            letter = "S"
        } else if direction >= 202.5 && direction < 247.5 {
            letter = "SW"
        } else if direction >= 247.5 && direction < 292.5 {
            letter = "W"
        } else {
            letter = "NW"
        }

        compassState = "\(Int(direction))° \(letter)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
