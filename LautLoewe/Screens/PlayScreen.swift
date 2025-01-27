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
    var isRecording: Bool = false
    var isRightAnswer: Bool?
}

struct PlayScreen: View {
    
    @ObservedObject var viewModel: PlayScreenViewModel
    
    @State private var backgroundColor = Color.clear
    
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
        .background(self.backgroundColor)
        .animation(.easeInOut(duration: 0.3), value: self.backgroundColor)
        .onChange(of: viewModel.state.isRightAnswer) { newValue in
            if let isRight = newValue {
                self.backgroundColor = isRight ? .green : .red.opacity(0.3)
                // Reset background after 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.viewModel.resetAnswer()
                }
            } else {
                self.backgroundColor = .clear
            }
        }
        .navigationTitle("Sprich mit mir!")
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}

#Preview {
    PlayScreen(viewModel: PlayScreenViewModel(wordProvider: WordProvider(),
                                              speechEngine: SpeechEngineProvider.shared))
}
