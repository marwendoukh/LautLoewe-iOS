//
//  PlayScreen.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import SwiftUI
import AVFoundation

struct GameState {
    var score: Int = 0
    var currentWord: Word?
    var showReward: Bool = false
    var isRecording: Bool = false
}

struct PlayScreen: View {
    
    @ObservedObject var viewModel: PlayScreenViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 10) {
                Text("Score: \(self.viewModel.state.score)")
                    .font(.title)
                    .padding()
                
                GameCardView(word: self.viewModel.state.currentWord)
                    .padding()
                
                ControlButtonView(isRecording: self.$viewModel.state.isRecording,
                                  onRecord: self.viewModel.startRecording,
                                  onStop: self.viewModel.stopRecording,
                                  onPlay: self.viewModel.playCurrentWord)
                
                NewWordButtonView(action: self.viewModel.newWord)
            }
        }
        .navigationTitle("Sprich mit mir!")
        .onAppear {
            self.viewModel.onAppear()
        }
        .alert("Super gemacht! 🌟",
               isPresented: Binding(
                get: { self.viewModel.state.showReward },
                set: { _ in }
               )) {
                   Button("Weiter") {
                       self.viewModel.onRewardConfirmed()
                   }
               }
    }
}

#Preview {
    PlayScreen(viewModel: PlayScreenViewModel(wordProvider: WordProvider(),
                                              speechEngine: SpeechEngineProvider()))
}
