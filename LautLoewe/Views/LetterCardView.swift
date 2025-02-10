//
//  LetterCardView.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 27.01.25.
//

import SwiftUI

struct LetterCardView: View {
    let letter: String
    let color: Color
    let associatedImage: String
    @Binding var isPressed: Bool
    
    var body: some View {
        ZStack {
            // Background
            Color.gray.opacity(0.2)
            
            // Content
            ZStack {
                Text(self.letter)
                    .font(.custom(self.isPressed ? "Ausgangsschrift  Normal" : "MM Schuldruck",
                                  size: 80))
                    .foregroundColor(self.color)
                
                if self.isPressed {
                    Image(self.associatedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .offset(y: 60)
                }
            }
        }
        .frame(width: 180, height: 180)
        .background(Color.gray.opacity(0.2))
    }
}
