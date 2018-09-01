//
//  PermissionPromptResult.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

public typealias PermissionPromptResultHandler = (PermissionPromptResult) -> Void

/// Result type from permission prompt request.
public enum PermissionPromptResult {
    case accepted
    case denied(error: PermissionError)
}
