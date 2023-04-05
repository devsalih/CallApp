//
//  ChannelViewController.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import UIKit
import Firebase
import AgoraRtcKit
import AVFoundation

class ChannelViewController: UIViewController {
    var agoraEngine: AgoraRtcEngineKit!
    let receiverLabel = UILabel()
    let senderLabel = UILabel()
    let speech = SpeechService()
    let firebase = FirebaseService()
    var listener: ListenerRegistration? = nil
    var i = 0
    private var proximityMonitor: ProximityMonitor? = ProximityMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initializeAgoraEngine()
        startRecording()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.global(qos: .userInitiated).async {AgoraRtcEngineKit.destroy()}
        firebase.deleteHistory()
        speech.stopRecording()
        speech.stopSpeaking()
        firebase.removeListener(listener: listener)
        proximityMonitor = nil
    }
}

extension ChannelViewController {
    func startRecording() {
        firebase.deleteHistory()
        try? speech.startRecording()
        let user = firebase.getCurrentUser()
        speech.transcriptionHandler = { text in
            self.firebase.addDocument(collection: "CallApp", documentId: user?.uid ?? "", data: [
                "text" : text,
                "lastUpdated": FieldValue.serverTimestamp(),
                "email" : user?.email ?? "",
            ])
        }
        listener = firebase.addListener(collection: "CallApp") { result in
            self.senderLabel.text = ""
            self.receiverLabel.text = ""
            do {
                let documents = try result.get().documents
                documents.forEach { document in
                    let data = document.data()
                    let message = data["text"] as? String ?? ""
                    let id = document.documentID
        
                    if id == user?.uid {
                        self.senderLabel.text = message
                    } else {
                        self.receiverLabel.text = message
                        let words = message.components(separatedBy: " ")
                        if words.count > self.i {
                            self.speech.speak(text: words[self.i])
                            self.i += 1
                        }
                    }
                }
            } catch { print(error) }
        }
    }
}
