//
//  PlayViewModel.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import Foundation
import Combine

class PlayScreenViewModel: ObservableObject {
    
    @Published var state = GameState()
    
    private let wordProvider: WordProvidable
    private let speechEngine: SpeechEngineProvidable
    private var recordingTimer: AnyCancellable?
    
    init(wordProvider: WordProvidable, speechEngine: SpeechEngineProvidable) {
        self.wordProvider = wordProvider
        self.speechEngine = speechEngine
    }
    
    func onAppear() {
        self.speechEngine.requestPermissions()
        self.newWord()
    }
    
    func newWord() {
        self.state.currentWord = self.wordProvider.getRandomWord()
    }
    
    func startRecording() {
        self.state.isRecording = true
        
        self.speechEngine.startRecording()
        
        // Start timer to automatically stop recording after 1 second
        self.recordingTimer?.cancel()
        self.recordingTimer = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.stopRecording()
                    
                }
            }
    }
    
    func stopRecording() {
        self.state.isRecording = false
        
        self.speechEngine.stopRecording()
        self.checkRecognizedWord()
        
        self.recordingTimer?.cancel()
        self.recordingTimer = nil
    }
    
    private func checkRecognizedWord() {
        guard let currentWord = self.state.currentWord?.text.lowercased(),
              let recognizedWord = self.speechEngine.recognizedText.lowercased()
            .components(separatedBy: .whitespacesAndNewlines)
            .first
        else { return }
        
        debugPrint("recognized Word: \(recognizedWord)")
        self.state.isRightAnswer = currentWord == recognizedWord
        if currentWord == recognizedWord {
            self.state.score += 1
        }
    }
    
    func playCurrentWord() {
        if let word = self.state.currentWord?.text {
            self.speechEngine.playWord(word)
        }
    }
    
    func resetAnswer() {
        let previousAnswer = self.state.isRightAnswer
        self.state.isRightAnswer = nil
        if previousAnswer == true {
            self.newWord()
        }
    }
}
