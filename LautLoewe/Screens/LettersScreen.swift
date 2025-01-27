//
//  LettersScreen.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 27.01.25.
//

import SwiftUI
import AVFoundation

struct LettersState {
    var isPressedB = false
    var isPressedD = false
}

struct LettersScreen: View {
    
    @StateObject private var viewModel = LettersViewModel(speechEngine: SpeechEngineProvider.shared)
    
    var body: some View {
        
        HStack(spacing: 30) {
            LetterCardView(
                letter: "b",
                color: Color.green,
                associatedImage: "leaf",
                isPressed: self.$viewModel.state.isPressedB
            )
            .onTapGesture {
                self.viewModel.didPressB()
            }
            
            LetterCardView(
                letter: "d",
                color: Color.red,
                associatedImage: "can",
                isPressed: self.$viewModel.state.isPressedD
            )
            .onTapGesture {
                self.viewModel.didPressD()
            }
        }
        
    }
}

// Preview
#Preview {
    LettersScreen()
}
