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
    
    public var errorDescription: String? {
        switch self {
        case .notAccepted(let permission), .notGranted(let permission), .restricted(let permission):
            let permissionTitle = String(describing: permission)
            return NSLocalizedString("Unable to access your \(permissionTitle).", comment: "")
        }
    }
    
    public var failureReason: String? {
        let errorString: String
        
        switch self {
        case .notAccepted:
            errorString = NSLocalizedString("You did not accept the requested permission.", comment: "")
        case .notGranted:
            errorString = NSLocalizedString("You did not accept the system prompt.", comment: "")
        case .restricted:
            errorString = NSLocalizedString("This permission is restricted.", comment: "")
        }
        
        return errorString
    }
    
    public var recoverySuggestion: String? {
        let errorString: String
        
        switch self {
        case .notAccepted:
            errorString = NSLocalizedString("You can change your mind by selecting the option again.", comment: "")
        case .notGranted:
            errorString = NSLocalizedString("You can go to Settings to allow access.", comment: "")
        case .restricted:
            errorString = NSLocalizedString("Your permission is restricted, and you will not be able to use this feature.", comment: "")
        }
        
        return errorString
    }
}
