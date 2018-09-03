//
//  MediaPermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 9/3/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import MediaPlayer

/// Concrete controller for media library access.
class MediaPermissionController: PermissionController {

    var permission: Permission { return .media }
    
    var permissionStatus: PermissionStatus {
        let status = MPMediaLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied:
            return .denied
        case .authorized:
            return .permitted
        }
    }
    
    var shouldPromptForPermission: Bool {
        let status = MPMediaLibrary.authorizationStatus()
        return status == .notDetermined
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        MPMediaLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                switch status {
                case .notDetermined, .denied:
                    let error = PermissionError.notGranted(permission: self.permission)
                    resultHandler(.denied(error: error))
                case .restricted:
                    let error = PermissionError.restricted(permission: self.permission)
                    resultHandler(.denied(error: error))
                case .authorized:
                    resultHandler(.accepted)
                }
            }
        }
    }
}

import Speech

/// Concrete controller for speech recognition access.
class SpeechPermissionController: PermissionController {

    var permission: Permission { return .speech }
    
    var permissionStatus: PermissionStatus {
        let status = SFSpeechRecognizer.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied:
            return .denied
        case .authorized:
            return .permitted
        }
    }
    
    var shouldPromptForPermission: Bool {
        let status = SFSpeechRecognizer.authorizationStatus()
        return status == .notDetermined
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        SFSpeechRecognizer.requestAuthorization { (status) in
            DispatchQueue.main.async {
                switch status {
                case .notDetermined, .denied:
                    let error = PermissionError.notGranted(permission: self.permission)
                    resultHandler(.denied(error: error))
                case .restricted:
                    let error = PermissionError.restricted(permission: self.permission)
                    resultHandler(.denied(error: error))
                case .authorized:
                    resultHandler(.accepted)
                }
            }
        }
    }
}
