//
//  PermissionError.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Defines errors that may be encountered when attempting to access permissions.
///
/// - notAccepted: The user did not accept the application prompt. Recovery can be made by selecting the option again.
/// - notGranted: The user has denied the application access. Recovery can be made in Settings.
/// - restricted: The user is restricted from accessing the permission. Recover cannot be made.
public enum PermissionError: Error {
    case notAccepted(permission: Permission)
    case notGranted(permission: Permission)
    case restricted(permission: Permission)
}
