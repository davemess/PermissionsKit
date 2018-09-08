//
//  PermissionPromptProvider.swift
//  PermissionsKit
//
//  Created by David Messing on 9/8/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Describes a protocol for supplying view configurations for a Permission.
public protocol PermissionPromptProvider {
    
    /// Returns a view model for the specified permission.
    func viewModel(for permission: Permission) -> PermissionPromptViewModel
}

/// A default prompt provider.
final class DefaultPromptProvider: PermissionPromptProvider {
    
    func viewModel(for permission: Permission) -> PermissionPromptViewModel {
        return permission.toPromptViewModel()
    }
}
