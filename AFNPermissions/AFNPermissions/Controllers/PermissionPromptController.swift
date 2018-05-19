//
//  PermissionPromptController.swift
//  AFNPermissions
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Defines a protocol for prompting users for permissions.
public protocol PermissionPromptController {
    func permissionStatus(_ permission: Permission) -> PermissionStatus
    func shouldPromptForPermission(_ permission: Permission) -> Bool
    func promptForPermission(_ permission: Permission, resultHandler: @escaping PermissionPromptResultHandler)
}

/// Default implementation of a PermissionPromptController for view controllers.
public extension PermissionPromptController where Self: UIViewController {
    
    public func permissionStatus(_ permission: Permission) -> PermissionStatus {
        let controller = PermissionControllerFactory.sharedInstance.permissionController(permission)
        return controller.permissionStatus()
    }
    
    public func shouldPromptForPermission(_ permission: Permission) -> Bool {
        let controller = PermissionControllerFactory.sharedInstance.permissionController(permission)
        return controller.shouldPromptForPermission()
    }
    
    public func promptForPermission(_ permission: Permission, resultHandler: @escaping PermissionPromptResultHandler) {
        let controller = PermissionControllerFactory.sharedInstance.permissionController(permission)
        let handler: PermissionPromptResultHandler = { result in
            self.dismiss(animated: true) {
                resultHandler(result)
            }
        }
        
        let promptViewController = PermissionPromptViewController(controller, resultHandler: handler)
        present(promptViewController, animated: true, completion: nil)
    }
}
