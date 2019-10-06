//
//  MotionPermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 9/2/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import CoreMotion

/// Concrete controller for motion access.
class MotionPermissionController: PermissionController {
    
    var permission: Permission { return .motion }
    
    var permissionStatus: PermissionStatus {
        let status = CMMotionActivityManager.authorizationStatus()
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
        let status = CMMotionActivityManager.authorizationStatus()
        return status == .notDetermined
    }
    
    private let activityManager: CMMotionActivityManager
    
    // MARK: - Lifecycle
    
    init(_ activityManager: CMMotionActivityManager = CMMotionActivityManager()) {
        self.activityManager = activityManager
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        guard CMMotionActivityManager.isActivityAvailable() else {
            let error = PermissionError.restricted(permission: self.permission)
            resultHandler(.denied(error: error))
            return
        }
        
        let date = Date()
        activityManager.queryActivityStarting(from: date, to: date, to: .main) { (_, error) in
            guard let error = error else {
                resultHandler(.accepted)
                return
            }
            
            let authErrorCodes: [Int] = [
                Int(CMErrorMotionActivityNotAuthorized.rawValue),
                Int(CMErrorNotAuthorized.rawValue)
            ]
            
            let cmError = error as NSError
            if authErrorCodes.contains(cmError.code) {
                let error = PermissionError.notGranted(permission: self.permission)
                resultHandler(.denied(error: error))
            }
        }
    }
    
}
