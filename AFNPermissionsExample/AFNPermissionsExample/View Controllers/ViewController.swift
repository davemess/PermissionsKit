//
//  ViewController.swift
//  AFNPermissionsExample
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AFNPermissions
import os.log

class ViewController: UIViewController, PermissionPromptController {

    
    @IBAction func checkLocationPermissions(_ sender: Any) {
        let permission: Permission = .location
        self.checkPermissionWithPromptIfNecessary(permission) { result in
            switch result {
            case .accepted:
                os_log("Location permission granted")
            case .denied(let permissionError):
                switch permissionError {
                case .notAccepted(_), .notGranted(_):
                    os_log("Location permission denied: %@", permissionError.localizedDescription)
                case .restricted(_):
                    os_log("Location permission restricted")
                }
            }
        }
    }
    

    @IBAction func checkPhotosPermissions(_ sender: Any) {
        let permission: Permission = .photos
        self.checkPermissionWithPromptIfNecessary(permission) { result in
            switch result {
            case .accepted:
                os_log("Photos permission granted")
            case .denied(let permissionError):
                switch permissionError {
                case .notAccepted(_), .notGranted(_):
                    os_log("Photos permission denied: %@", permissionError.localizedDescription)
                case .restricted(_):
                    os_log("Photos permission restricted")
                }
            }
        }
    }
}

