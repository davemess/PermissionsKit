//
//  PermissionError.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Defines errors that may be encountered when attempting to select permissions.
public enum PermissionError: Error {
    
    /**
     Defines the type of error that was recieved.
     
     - NotAccepted: The user did not accept the application prompt. Recovery can be made by selecting the option again.
     - NotGranted: The user has denied the application access. Recovery can be made in Settings.
     - Restricted: The user is restricted from accessing the permission. Recover cannot be made.
     */
    case notAccepted(permission: Permission)
    case notGranted(permission: Permission)
    case restricted(permission: Permission)
}
