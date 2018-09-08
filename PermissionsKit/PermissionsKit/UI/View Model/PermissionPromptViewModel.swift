//
//  PermissionPromptViewModel.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// View model for configuring a PermissionPromptView.
public struct PermissionPromptViewModel {
    
    public let icon: UIImage
    public let title: String
    public let reason: String
    
    public init(icon: UIImage, title: String, reason: String) {
        self.icon = icon
        self.title = title
        self.reason = reason
    }
}
