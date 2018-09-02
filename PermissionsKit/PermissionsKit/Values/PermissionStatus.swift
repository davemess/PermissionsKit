//
//  PermissionStatus.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Defines a set of possible permission statuses.
///
/// - unknown: the permission status is unknown.
/// - permitted: permission to the resource is accepted and permitted.
/// - denied: permission to the resource has been denied.
public enum PermissionStatus {
    case unknown
    case permitted
    case denied
}
