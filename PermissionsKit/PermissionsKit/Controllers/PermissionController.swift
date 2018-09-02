//
//  PermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// A PermissionController manages access to a specific permission. Concrete
/// classes exist for each supported permission type. For each new permission
/// type, an associated controller should be created to manage access. In most
/// cases, concrete controllers should remain internal to the library.
public protocol PermissionController {
    
    /// The associated permission which the controller manages.
    var permission: Permission { get }
   
    /// Returns the current status for the associated Permission.
    var permissionStatus: PermissionStatus { get }
    
    /// Returns a value indicating if you should prompt the user for permission.
    /// Permission to a resource can be restricted or denied; in both cases, you
    /// should not prompt the user. Usually, you only prompt the user if status
    /// is undetermined.
    var shouldPromptForPermission: Bool { get }
    
    /// This action triggers the system prompt to request permission to the
    /// associated resource.
    ///
    /// - Parameter resultHandler: a handler which will contain the prompt result.
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler)
}
