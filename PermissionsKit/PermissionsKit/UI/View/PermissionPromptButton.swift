//
//  PermissionPromptButton.swift
//  PermissionsKit
//
//  Created by David Messing on 9/3/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// <#Description#>
class PermissionPromptButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 10.0        
    }

}
