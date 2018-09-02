//
//  PermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Defines a protocol for managing app permissions.
public protocol PermissionController {
    var permission: Permission { get }
    
    func permissionStatus() -> PermissionStatus
    func shouldPromptForPermission() -> Bool
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler)
}
