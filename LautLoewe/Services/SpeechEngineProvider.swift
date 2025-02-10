//
//  SpeechEngineProvider.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import AVFoundation
import Speech

class SpeechEngineProvider: NSObject, SpeechEngineProvidable, SFSpeechRecognizerDelegate {
    
    private var speechSynthesizer = AVSpeechSynthesizer()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "de-AT"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var audioPlayer: AVAudioPlayer?
    
    @Published private(set) var recognizedText: String = ""
    @Published private(set) var isRecording: Bool = false
    
    static let shared = SpeechEngineProvider()
    
    private override init() {
        super.init()
    }
    
    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            guard let self = self,
                  status == .authorized else { return }
            DispatchQueue.main.async {
                self.speechRecognizer?.delegate = self
            }
        }
        
        AVAudioApplication.requestRecordPermission { _ in }
    }
    
    // MARK: - SFSpeechRecognizerDelegate
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if !available {
            self.stopRecording()
        }
    }
    
    func startRecording() {
        // Cancel any ongoing tasks
        self.stopRecording()
        
        do {
            
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord,
                                         mode: .spokenAudio,
                                       options: [.defaultToSpeaker, .allowBluetoothA2DP, .duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest else { return }
            
            let inputNode = self.audioEngine.inputNode
            recognitionRequest.shouldReportPartialResults = true
            
            // Get the native format from input node
            let recordingFormat = inputNode.inputFormat(forBus: 0)
            
            self.recognitionTask = self.speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
                guard let self else { return }
                if let result {
                    DispatchQueue.main.async {
                        self.recognizedText = result.bestTranscription.formattedString
                    }
                }
                if error != nil || result?.isFinal == true {
                    self.stopRecording()
                }
            }
            
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            
            self.audioEngine.prepare()
            try self.audioEngine.start()
            
            DispatchQueue.main.async {
                self.isRecording = true
            }
            
        } catch {
            print("Recording failed: \(error.localizedDescription)")
            self.stopRecording()
        }
    }
    
    func stopRecording() {
        self.audioEngine.stop()
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.recognitionRequest?.endAudio()
        self.recognitionRequest = nil
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        self.isRecording = false
    }
    
    func playWord(_ word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "de-AT")
        utterance.rate = 0.42
        utterance.volume = 0.9
        utterance.pitchMultiplier = 1.1
        self.speechSynthesizer.speak(utterance)
    }
    
    func speakLetter(_ letter: String) {
        guard let soundURL = Bundle.main.url(forResource: letter, withExtension: "m4a") else {
            print("Sound file not found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.prepareToPlay()
            self.audioPlayer?.play()
            print("Playing \(letter).m4a...")
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
}
