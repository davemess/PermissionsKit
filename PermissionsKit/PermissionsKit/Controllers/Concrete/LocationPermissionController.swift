//
//  LocationPermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import CoreLocation

/// An abstract superclass for location permission.
class LocationPermissionController: NSObject, PermissionController {
    
    var permission: Permission {
        fatalError("Do not instantiate the abstract class.")
    }
    
    var permissionStatus: PermissionStatus {
        fatalError("Do not instantiate the abstract class.")
    }
    
    var shouldPromptForPermission: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    fileprivate let locationManager: CLLocationManager
    fileprivate var resultHandler: PermissionPromptResultHandler?
    
    // MARK: - Lifecycle
    
    init(_ locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.delegate = self
    }
    
    // MARK: - PermissionController
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        self.resultHandler = resultHandler
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationPermissionController: CLLocationManagerDelegate {}

/// Concrete controller for when in use location permission access.
class LocationWhenInUsePermissionController: LocationPermissionController {
    
    override var permission: Permission { return .location(type: .whenInUse) }
    
    override var permissionStatus: PermissionStatus {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied, .authorizedAlways:
            return .denied
        case .authorizedWhenInUse:
            return .permitted
        }
    }
}

extension LocationWhenInUsePermissionController {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let resultHandler = self.resultHandler else { return }
        
        switch status {
        case .notDetermined, .denied, .authorizedAlways:
            let error = PermissionError.notGranted(permission: self.permission)
            resultHandler(.denied(error: error))
        case .restricted:
            let error = PermissionError.restricted(permission: self.permission)
            resultHandler(.denied(error: error))
        case .authorizedWhenInUse:
            resultHandler(.accepted)
        }
    }
}

/// Concrete controller for always location permission access.
class LocationAlwaysPermissionController: LocationPermissionController {
    
    override var permission: Permission { return .location(type: .always) }
    
    override var permissionStatus: PermissionStatus {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied, .authorizedWhenInUse:
            return .denied
        case .authorizedAlways:
            return .permitted
        }
    }
}

extension LocationAlwaysPermissionController {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let resultHandler = self.resultHandler else { return }
        
        switch status {
        case .notDetermined, .denied, .authorizedWhenInUse:
            let error = PermissionError.notGranted(permission: self.permission)
            resultHandler(.denied(error: error))
        case .restricted:
            let error = PermissionError.restricted(permission: self.permission)
            resultHandler(.denied(error: error))
        case .authorizedAlways:
            resultHandler(.accepted)
        }
    }
}
