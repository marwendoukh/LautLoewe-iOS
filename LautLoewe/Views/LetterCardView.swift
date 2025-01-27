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
        
        VStack {
            if self.isPressed {
                VStack {
                    Text(self.letter)
                        .font(.custom("Ausgangsschrift  Normal", size: 60))
                        .foregroundColor(self.color)
                    Image(self.associatedImage)
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Text(self.letter)
                    .font(.custom("MM Schuldruck", size: 80))
                    .foregroundColor(self.color)
            }
        }
        .frame(width: 180, height: 180)
        .background(Color.gray.opacity(0.2))
    }
}
