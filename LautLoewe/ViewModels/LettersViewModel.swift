//
//  LettersViewModel.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 27.01.25.
//

import Foundation
import Combine

class LettersViewModel: ObservableObject {
    
    @Published var state = LettersState()
    
    private let speechEngine: SpeechEngineProvidable
    private var currentTimer: AnyCancellable?

    init(speechEngine: SpeechEngineProvidable) {
        self.speechEngine = speechEngine
    }
    
    func didPressB() {
        self.currentTimer?.cancel()
        self.state.isPressedB.toggle()
        self.state.isPressedD = false
        if self.state.isPressedB {
            self.speechEngine.speakLetter("b")
            self.resetStateAfterDelay()
        }
    }
    
    func didPressD() {
        self.currentTimer?.cancel()
        self.state.isPressedB = false
        self.state.isPressedD.toggle()
        if self.state.isPressedD {
            self.speechEngine.speakLetter("d")
            self.resetStateAfterDelay()
        }
    }
    
    private func resetStateAfterDelay() {
        self.currentTimer = Just(())
                .delay(for: .seconds(5), scheduler: DispatchQueue.main)
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    self.state.isPressedB = false
                    self.state.isPressedD = false
                }
        }
    
}

