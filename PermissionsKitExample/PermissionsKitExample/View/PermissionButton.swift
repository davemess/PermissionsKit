//
//  PermissionButton.swift
//  PermissionsKitExample
//
//  Created by David Messing on 9/2/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import PermissionsKit

class PermissionButton: UIButton {

    var permission: Permission?
    
    func refresh() {
        guard let permission = self.permission else {
            return
        }
        
        let controller = PermissionControllerFactory.sharedInstance.permissionController(permission)
        let status = controller.permissionStatus()
        switch status {
        case .unknown:
            setTitleColor(.black, for: .normal)
        case .permitted:
            setTitleColor(.green, for: .normal)
        case .denied:
            setTitleColor(.red, for: .normal)
        }
    }
}
