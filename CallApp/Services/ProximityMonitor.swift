//
//  ProximityMonitor.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import UIKit

class ProximityMonitor {
    private let device = UIDevice.current
    
    init() {
        device.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(proximityChanged),
                                               name: UIDevice.proximityStateDidChangeNotification,
                                               object: nil)
    }
    
    deinit {
        print("ProximityMonitor deinit")
        device.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func proximityChanged() {
        if device.proximityState {
            UIApplication.shared.isIdleTimerDisabled = true
        } else {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}
