//
//  CameraPermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 9/2/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import AVFoundation

/// Concrete controller for camera access.
class CameraPermissionController: PermissionController {
    
    var permission: Permission { return .camera }
    
    var permissionStatus: PermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied:
            return .denied
        case .authorized:
            return .permitted
        @unknown default:
            fatalError()
        }
    }
    
    var shouldPromptForPermission: Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        return status == .notDetermined
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        DispatchQueue.main.async {
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted == true {
                    resultHandler(.accepted)
                } else {
                    let error = PermissionError.notGranted(permission: self.permission)
                    resultHandler(.denied(error: error))
                }
            }
        }
    }
}
