//
//  PermissionPromptViewModel.swift
//  AFNPermissions
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// View model for configure a PermissionPromptView.
struct PermissionPromptViewModel {
    
    let icon: UIImage
    let title: String
    let reason: String
    
    init(icon: UIImage, title: String, reason: String) {
        self.icon = icon
        self.title = title
        self.reason = reason
    }
}
