//
//  PermissionPromptResult.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// A result action occurring from a permission prompt.
public typealias PermissionPromptResultHandler = (PermissionPromptResult) -> Void

/// Result types from a permission prompt request.
///
/// - accepted: the prompt for permission has been accepted.
/// - denied: the prompt for permission has been denied.
public enum PermissionPromptResult {
    case accepted
    case denied(error: PermissionError)
}
