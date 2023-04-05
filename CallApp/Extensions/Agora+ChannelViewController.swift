//
//  Agora+ChannelViewController.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import AgoraRtcKit
import AVFoundation

extension ChannelViewController: AgoraRtcEngineDelegate {
    func joinChannel() async {
        if await !self.checkForPermissions() { return }
        let option = AgoraRtcChannelMediaOptions()
        option.clientRoleType = .broadcaster
        option.channelProfile = .communication
        agoraEngine.joinChannel(
            byToken: "007eJxTYLB8tH2RE8MlnuIXnYe/GGtcT7m1cUeIzOOvbWomzxkD9NQVGBJTLCxMEhMTzZONLUxSLVIsTZNNjdOSDQ0NjC3NU9MMs7p1UhoCGRl4j/UzMTJAIIjPzuCcmJPjWFDAwAAAx0EgLA==",
            channelId: "CallApp",
            uid: 0, mediaOptions: option,
            joinSuccess: { (channel, uid, elapsed) in }
        )
    }
    
    func leaveChannel() { agoraEngine.leaveChannel(nil) }
    
    func initializeAgoraEngine() {
        let config = AgoraRtcEngineConfig()
        config.appId = "ad884aaa7c384e8d95c53fc110397ef1"
        config.audioScenario = .gameStreaming
        agoraEngine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
        Task {
            await joinChannel()
            agoraEngine.adjustRecordingSignalVolume(0)
        }
    }
    
    func checkForPermissions() async -> Bool { await self.avAuthorization(mediaType: .audio) }
    
    func avAuthorization(mediaType: AVMediaType) async -> Bool {
        let mediaAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch mediaAuthorizationStatus {
        case .denied, .restricted: return false
        case .authorized: return true
        case .notDetermined:
            return await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: mediaType) { granted in
                    continuation.resume(returning: granted)
                }
            }
        @unknown default: return false
        }
    }
}
