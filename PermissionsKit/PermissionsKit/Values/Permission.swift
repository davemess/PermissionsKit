//
//  Permission.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Defines a set of iOS permissions.
public enum Permission: CaseIterable {
    case photos
    case locationWhenInUse
    case locationAlways
    // TODO: add remaining permissions
}

extension Permission: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .photos:
            return NSLocalizedString("photos", comment: "")
        case .locationWhenInUse:
            return NSLocalizedString("location when in use", comment: "")
        case .locationAlways:
            return NSLocalizedString("location always", comment: "")
        }
    }
    
}
