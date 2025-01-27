//
//  SpeechEngineProvidable.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

protocol SpeechEngineProvidable {
    func requestPermissions()
    func startRecording()
    func stopRecording()
    func playWord(_ word: String)
    var recognizedText: String { get }
    var isRecording: Bool { get }
    func speakLetter(_ letter: String)
}
