//
//  Coordinates.swift
//  design
//
//  Created by Cristian Cretu on 11.06.2023.
//

import SwiftUI

struct Coordinates: View {
    let direction: String
    let coordinates: String
    
    var body: some View {
        VStack (spacing: 32){
            
            // Coordinates
            VStack {
                Text(direction)
                    .rounded(size: 48, weight: .semibold)
                    .foregroundColor(.clear)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.indigo, .purple, .blue, .indigo, .blue]),
                            startPoint: .bottomTrailing,
                            endPoint: .topLeading
                        )
                        .mask(Text(direction).rounded(size: 48, weight: .semibold))
                    )
                
                Text(coordinates)
                    .rounded(size: 18, weight: .medium)
                    .foregroundColor(Color.white.opacity(0.7))
            }
            
            // Agreement
            Text("Point your phone directly at someone to be matched with them. Unacceptable behavior is not tolerated, and may lead to a ban.")
                .rounded(size: 12)
                .foregroundColor(Color.white.opacity(0.4))
                .multilineTextAlignment(.center)
            
            // Cancel button / go back
            Button(action: {
                // Handle cancel button action
            }) {
                Text("Cancel")
                    .rounded(size: 20, weight: .semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(25)
            }
        }
    }
}
