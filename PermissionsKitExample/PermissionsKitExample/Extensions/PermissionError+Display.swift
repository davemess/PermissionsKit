//
//  PermissionError+Display.swift
//  PermissionsKitExample
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import PermissionsKit

/// Extends PermissionError with display functions.
extension PermissionError: LocalizedError {
    
    public var localizedDescription: String {
        let errorString: String
        
        switch self {
            
        case .notAccepted(let permission):
            let permissionTitle = String(describing: permission)
            errorString = NSLocalizedString("Unable to access your \(permissionTitle). You can change your mind by selecting the option again.", comment: "")
            
        case .notGranted(let permission):
            let permissionTitle = String(describing: permission)
            errorString = NSLocalizedString("Unable to access your \(permissionTitle). You can go to Settings to allow access.", comment: "")
            
        case .restricted(let permission):
            let permissionTitle = String(describing: permission)
            errorString = NSLocalizedString("Unable to access your \(permissionTitle). Your permission is restricted, and you will not be able to use this feature.", comment: "")
        }
        
        return errorString
    }
}
