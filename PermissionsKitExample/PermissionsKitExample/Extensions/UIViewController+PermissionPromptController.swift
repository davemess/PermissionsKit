//
//  UIViewController+PermissionPromptController.swift
//  PermissionsKitExample
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import PermissionsKit

/// Default implementation of a PermissionPromptController for view controllers.
extension PermissionPromptController where Self: UIViewController {
    
    public func checkPermissionWithPromptIfNecessary(_ permission: Permission, resultHandler: @escaping PermissionPromptResultHandler) {
        let status = permissionStatus(permission)
        
        switch status {
        case .unknown:
            if shouldPromptForPermission(permission) {
                promptForPermission(permission, resultHandler: resultHandler)
            } else {
                let error = PermissionError.notGranted(permission: permission)
                resultHandler(.denied(error: error))
            }
            
        case .permitted:
            resultHandler(.accepted)
            
        case .denied:
            let error = PermissionError.notGranted(permission: permission)
            resultHandler(.denied(error: error))
        }
    }
}
