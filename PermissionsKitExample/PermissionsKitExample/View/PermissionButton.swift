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

    var permission: Permission? {
        didSet {
            if let permission = permission {
                let title = String(format: "Check %@ Permissions", String(describing: permission).capitalized)
                setTitle(title, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 5.0
        layer.backgroundColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        
        titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    }
    
    func refresh() {
        guard let permission = self.permission else {
            return
        }
        
        let controller = PermissionControllerProvider.standard.permissionController(permission)
        let status = controller.permissionStatus
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
