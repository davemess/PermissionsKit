//
//  PermissionControllerProvider.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import CoreLocation

/// Defines a protocol for providing permission controllers.
protocol PermissionControllerProvider {
    func permissionController(_ permission: Permission) -> PermissionController
}

/// Default permission controller factory provider.
class PermissionControllerFactory: PermissionControllerProvider {
    
    static let sharedInstance = PermissionControllerFactory()
    private init() {}
    
    private lazy var locationPermissionController: LocationPermissionController = {
        let locationManager = CLLocationManager()
        let controller = LocationPermissionController(locationManager)
        return controller
    }()
    private var photosPermissionController = PhotosPermissionController()
    
    func permissionController(_ permission: Permission) -> PermissionController {
        switch permission {
        case .location:
            return locationPermissionController
        case .photos:
            return photosPermissionController
        }
    }
    
}
