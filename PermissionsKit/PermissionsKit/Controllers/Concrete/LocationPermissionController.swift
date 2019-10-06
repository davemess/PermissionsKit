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
    
    init(_ locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.delegate = self
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        assertionFailure("Do not instantiate the abstract class.")
    }
}

extension LocationPermissionController: CLLocationManagerDelegate {}

/// Concrete controller for when in use location permission access.
class LocationWhenInUsePermissionController: LocationPermissionController {
    
    override var permission: Permission { return .locationWhenInUse }
    
    override var permissionStatus: PermissionStatus {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied, .authorizedAlways:
            return .denied
        case .authorizedWhenInUse:
            return .permitted
        @unknown default:
            fatalError()
        }
    }
    
    override func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        self.resultHandler = resultHandler
        locationManager.requestWhenInUseAuthorization()
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
        @unknown default:
            fatalError()
        }
    }
}

/// Concrete controller for always location permission access.
class LocationAlwaysPermissionController: LocationPermissionController {
    
    override var permission: Permission { return .locationAlways }
    
    override var permissionStatus: PermissionStatus {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied, .authorizedWhenInUse:
            return .denied
        case .authorizedAlways:
            return .permitted
        @unknown default:
            fatalError()
        }
    }
    
    override func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        self.resultHandler = resultHandler
        locationManager.requestAlwaysAuthorization()
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
        @unknown default:
            fatalError()
        }
    }
}
