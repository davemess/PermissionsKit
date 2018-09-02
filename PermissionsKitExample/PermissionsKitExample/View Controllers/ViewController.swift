//
//  ViewController.swift
//  PermissionsKitExample
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import PermissionsKit
import os.log

class ViewController: UIViewController, PermissionPromptController {
    
    @IBOutlet weak var locationButton: PermissionButton!
    @IBOutlet weak var photosButton: PermissionButton!
    
    var permissionButtons: [PermissionButton] {
        return [
            locationButton,
            photosButton,
        ]
    }
    
    var permissionMapping: [PermissionButton: Permission] {
        return [
            locationButton: .location(type: .whenInUse),
            photosButton: .photos,
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        permissionMapping.forEach { (button, permission) in
            button.permission = permission
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        permissionButtons.forEach {
            $0.refresh()
        }
    }

    
    @IBAction func checkLocationPermissions(_ sender: Any) {
        let permission: Permission = .location(type: .whenInUse)
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

