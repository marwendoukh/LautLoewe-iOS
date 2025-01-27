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
    
    init(speechEngine: SpeechEngineProvidable) {
        self.speechEngine = speechEngine
    }
    
    func didPressB() {
        self.state.isPressedB.toggle()
        self.state.isPressedD = false
        self.speechEngine.speakLetter("b")
    }
    
    func didPressD() {
        self.state.isPressedB = false
        self.state.isPressedD.toggle()
        self.speechEngine.speakLetter("d")
    }
    
}

