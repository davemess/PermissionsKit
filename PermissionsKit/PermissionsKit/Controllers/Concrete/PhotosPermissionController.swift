//
//  PhotosPermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Photos

/// Concrete controller for photos permission.
class PhotosPermissionController: PermissionController {
    
    var permission: Permission { return .photos }
    
    func permissionStatus() -> PermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied:
            return .denied
        case .authorized:
            return .permitted
        }
    }
    
    func shouldPromptForPermission() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        return status == .notDetermined
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        PHPhotoLibrary.requestAuthorization { status in
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

