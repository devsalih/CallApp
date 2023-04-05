//
//  SpeechService.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import Speech

class SpeechService {
    var transcriptionHandler: ((String) -> Void)?
    
    private let synthesizer = AVSpeechSynthesizer()
    private let audioSession = AVAudioSession.sharedInstance()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "tr-TR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    func speak(text: String) {
        do {
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat)
            try audioSession.setActive(true)
        } catch {
            print("Failed to activate audio session: \(error.localizedDescription)")
        }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        try? audioSession.setActive(false)
    }
    
    func startRecording() throws {
        guard let recognitionTask = self.recognitionTask, recognitionTask.state == .running else {
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            let inputNode = audioEngine.inputNode
            
            guard let recognitionRequest = recognitionRequest else {
                throw SpeechRecognitionError.audioEngineError
            }
            
            recognitionRequest.shouldReportPartialResults = true
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { [weak self] (result, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    self.stopRecording()
                    return
                }
                
                guard let result = result else { return }
                self.transcriptionHandler?(result.bestTranscription.formattedString)
            })
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, _ in
                guard let self = self else { return }
                self.recognitionRequest?.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            return
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest?.endAudio()
        recognitionRequest = nil
    }
    
    enum SpeechRecognitionError: Error { case audioEngineError }
}
