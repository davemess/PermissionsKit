//
//  LocationPermissionController.swift
//  AFNPermissions
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import CoreLocation

/// Concrete controller for location permission.
class LocationPermissionController: NSObject, PermissionController {
    
    var permission: Permission { return .location }
    
    private let locationManager: CLLocationManager
    private var resultHandler: PermissionPromptResultHandler?
    
    // MARK: - lifecycle
    
    init(_ locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.delegate = self
    }
    
    // MARK: - public
    
    func permissionStatus() -> PermissionStatus {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied:
            return .denied
        case .authorizedAlways, .authorizedWhenInUse:
            return .permitted
        }
    }
    
    func shouldPromptForPermission() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        self.resultHandler = resultHandler
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationPermissionController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let resultHandler = self.resultHandler else { return }
        
        switch status {
        case .notDetermined, .denied:
            let error = PermissionError.notGranted(permission: self.permission)
            resultHandler(.denied(error: error))
        case .restricted:
            let error = PermissionError.restricted(permission: self.permission)
            resultHandler(.denied(error: error))
        case .authorizedAlways, .authorizedWhenInUse:
            resultHandler(.accepted)
        }
    }
}

