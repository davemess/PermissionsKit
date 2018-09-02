//
//  PermissionControllerProvider.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// A singleton provider for supplying PermissionControllers.
public class PermissionControllerProvider {
    
    // MARK: - Lifecycle
    
    /// Returns the default provider object.
    public static let standard = PermissionControllerProvider()
    private init() {}
    
    // MARK: - Properties
    
    private lazy var contactsPermissionController: ContactsPermissionController = {
        let controller = ContactsPermissionController()
        return controller
    }()
    
    private lazy var alwaysLocationPermissionController: LocationPermissionController = {
        let controller = LocationAlwaysPermissionController()
        return controller
    }()
    
    private lazy var whenInUseLocationPermissionController: LocationPermissionController = {
        let controller = LocationWhenInUsePermissionController()
        return controller
    }()
    
    private lazy var photosPermissionController: PhotosPermissionController = {
        return PhotosPermissionController()
    }()
    
    // MARK: - Public
    
    /// Returns a controller for the specified permission.
    ///
    /// - Parameter permission: the requested permission resource.
    /// - Returns: a controller for the specified permission.
    public func permissionController(_ permission: Permission) -> PermissionController {
        switch permission {
        case .contacts:
            return contactsPermissionController
        case .locationWhenInUse:
            return whenInUseLocationPermissionController
        case .locationAlways:
            return alwaysLocationPermissionController
        case .photos:
            return photosPermissionController
        }
    }
    
}
