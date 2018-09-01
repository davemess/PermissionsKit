//
//  Permission+PermissionPromptViewModel.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Extends Permission with factory method to generate PermissionPromptViewModel.
extension Permission {
    
    func toPromptViewModel() -> PermissionPromptViewModel {
        let icon: UIImage
        let title: String
        let reason: String
        
        let bundle = Bundle(for: PermissionPromptView.self)
        
        switch self {
        case .location:
            icon = UIImage(named: "icon_location", in: bundle, compatibleWith: nil)!
            title = NSLocalizedString("Location", comment: "")
            reason = NSLocalizedString("Location permission is necessary for determining your current location.", comment: "") // TODO: replace text
            
        case .photos:
            icon = UIImage(named: "icon_photos", in: bundle, compatibleWith: nil)!
            title = NSLocalizedString("Photos", comment: "")
            reason = NSLocalizedString("Photos permission is necessary for accessing your photo album.", comment: "") // TODO: replace text
        }
        
        let viewModel = PermissionPromptViewModel(icon: icon, title: title, reason: reason)
        return viewModel
    }
}
