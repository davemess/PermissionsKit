//
//  PermissionsKit.swift
//  PermissionsKit
//
//  Created by David Messing on 9/8/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Entry point for configuring PermissionsKit.
final public class PermissionsKit {
    
    static var provider: PermissionPromptProvider = DefaultPromptProvider()
    
    /// Used to configure the SDK with a custom prompt configuration.
    ///
    /// - Parameter provider: a custom prompt provider.
    static public func configure(_ provider: PermissionPromptProvider) {
        self.provider = provider
    }
}
