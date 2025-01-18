//
//  GameCardView.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import SwiftUI

struct GameCardView: View {
    let word: Word?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.1))
                .frame(height: 300)
            
            if let word = word {
                VStack {
                    Text(word.text)
                        .font(.system(size: 60))
                        .bold()
                    
                    Image(systemName: word.systemImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    GameCardView(word: Word(text: "Dach", systemImageName: "house.fill"))
}
