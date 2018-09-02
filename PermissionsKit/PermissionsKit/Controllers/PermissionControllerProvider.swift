//
//  PermissionControllerProvider.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import CoreLocation

/// A singleton provider for supplying PermissionControllers.
public class PermissionControllerProvider {
    
    // MARK: - Lifecycle
    
    /// Returns the default provider object.
    public static let standard = PermissionControllerProvider()
    private init() {}
    
    // MARK: - Properties
    
    private lazy var alwaysLocationPermissionController: LocationPermissionController = {
        let locationManager = CLLocationManager()
        let controller = LocationAlwaysPermissionController(locationManager)
        return controller
    }()
    
    private lazy var whenInUseLocationPermissionController: LocationPermissionController = {
        let locationManager = CLLocationManager()
        let controller = LocationWhenInUsePermissionController(locationManager)
        return controller
    }()
    
    private lazy var photosPermissionController: PhotosPermissionController = {
        PhotosPermissionController()
    }()
    
    // MARK: - Public
    
    /// Returns a controller for the specified permission.
    ///
    /// - Parameter permission: the requested permission resource.
    /// - Returns: a controller for the specified permission.
    public func permissionController(_ permission: Permission) -> PermissionController {
        switch permission {
        case .location(let type):
            switch type {
            case .always:
                return alwaysLocationPermissionController
            case .whenInUse:
                return whenInUseLocationPermissionController
            }
        case .photos:
            return photosPermissionController
        }
    }
    
}
