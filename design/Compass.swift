//
//  Compass.swift
//  design
//
//  Created by Cristian Cretu on 11.06.2023.
//

import SwiftUI


struct Marker: Hashable {
    let degrees: Double
    let label: String

    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }
    
    func degreeText() -> String {
        return String(format: "%.0f°", self.degrees)
    }
    
    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "S"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "W"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "N"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "E"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double
    
    var body: some View {
        VStack {
            Text(marker.degreeText())
                .rounded(size: 20.0, weight: .bold)
                .foregroundColor(self.capsuleColor().opacity(0.5))
                .rotationEffect(self.textAngle())
                .padding(.bottom, 25)

            Capsule()
            .frame(width: self.capsuleWidth(),
                    height: self.capsuleHeight() + 195)
            .foregroundColor(self.capsuleColor().opacity(0.03))
            .padding(.bottom, 80)

            Text(marker.label)
                .rounded(weight: .bold)
                .foregroundColor(self.capsuleColor().opacity(0.7))
                .rotationEffect(self.textAngle())
                .padding(.bottom, 70)
        }
        .rotationEffect(Angle(degrees: marker.degrees))
    }
    
    private func capsuleWidth() -> CGFloat {
        return 3
    }

    private func capsuleHeight() -> CGFloat {
        return 30
    }

    private func capsuleColor() -> Color {
        return .gray
    }

    private func textAngle() -> Angle {
        return Angle(degrees: -self.compassDegress - self.marker.degrees)
    }
}

struct Compass: View {
    
    var body: some View {
        ZStack {
            ForEach(Marker.markers(), id: \.self) { marker in
                CompassMarkerView(marker: marker, compassDegress: 0)
            }
        }
    }
}

