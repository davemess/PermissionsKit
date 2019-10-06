//
//  PermissionPromptController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// A prompt controller defines functions for prompting the user for access to
/// a resource.
public protocol PermissionPromptController {
    
    /// Used to determine current status for the specified permission.
    ///
    /// - Parameter permission: the permission that is being requested.
    /// - Returns: a status value indicating the current permission status.
    func permissionStatus(_ permission: Permission) -> PermissionStatus
    
    /// Used to determined if the user should be prompted for access to the
    /// specific resource.
    ///
    /// - Parameter permission: the permission that is being requested.
    /// - Returns: a value indicating if the user should be prompted.
    func shouldPromptForPermission(_ permission: Permission) -> Bool
    
    /// Used to prompt the user for access to the specific resource.
    ///
    /// - Parameters:
    ///   - permission: the permission that is being requested.
    ///   - animated: determines if the prompt will be animated.
    ///   - resultHandler: a handler which contains the prompt result.
    func promptForPermission(_ permission: Permission, animated: Bool, resultHandler: @escaping PermissionPromptResultHandler)
}

// MARK: - Default implementations of prompt controller functions.
public extension PermissionPromptController {
    
    var provider: PermissionControllerProvider {
        return PermissionControllerProvider.standard
    }
    
    func permissionStatus(_ permission: Permission) -> PermissionStatus {
        let controller = provider.permissionController(permission)
        return controller.permissionStatus
    }
    
    func shouldPromptForPermission(_ permission: Permission) -> Bool {
        let controller = provider.permissionController(permission)
        return controller.shouldPromptForPermission
    }
}
