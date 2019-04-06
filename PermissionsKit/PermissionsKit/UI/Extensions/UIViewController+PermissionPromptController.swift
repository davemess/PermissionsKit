//
//  UIViewController+PermissionPromptController.swift
//  PermissionsKit
//
//  Created by David Messing on 9/2/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Default implementation of a PermissionPromptController for view controllers.
/// Your view controllers should declare conformance to PermissionPromptController
/// to get prompt behavior for free.
public extension PermissionPromptController where Self: UIViewController {
    
    func promptForPermission(_ permission: Permission, animated: Bool, resultHandler: @escaping PermissionPromptResultHandler) {
        let controller = provider.permissionController(permission)
        let handler: PermissionPromptResultHandler = { result in
            self.dismiss(animated: animated) {
                resultHandler(result)
            }
        }
        
        let promptViewController = PermissionPromptViewController(controller, resultHandler: handler)
        present(promptViewController, animated: animated, completion: nil)
    }
}
