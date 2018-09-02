//
//  MicrophonePermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 9/2/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import AVFoundation

/// Concrete controller for camera access.
class MicrophonePermissionController: PermissionController {
    
    var permission: Permission { return .microphone }
    
    var permissionStatus: PermissionStatus {
        let status = audioSession.recordPermission
        switch status {
        case .undetermined:
            return .unknown
        case .denied:
            return .denied
        case .granted:
            return .permitted
        }
    }
    
    var shouldPromptForPermission: Bool {
        let status = audioSession.recordPermission
        return status == .undetermined
    }
    
    private let audioSession: AVAudioSession
    
    // MARK: - Lifecycle
    
    init(_ audioSession: AVAudioSession = AVAudioSession()) {
        self.audioSession = audioSession
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        audioSession.requestRecordPermission({ (granted) in
            if granted == true {
                resultHandler(.accepted)
            } else {
                let error = PermissionError.notGranted(permission: self.permission)
                resultHandler(.denied(error: error))
            }
        })
    }
}
