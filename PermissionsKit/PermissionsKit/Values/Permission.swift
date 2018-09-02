//
//  Permission.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Defines a set of iOS permissions.
public enum Permission {
    case photos
    case location(type: LocationAccessType)
    // TODO: add remaining permissions
}

/// Defines options for location permission access.
public enum LocationAccessType {
    case whenInUse
    case always
}
