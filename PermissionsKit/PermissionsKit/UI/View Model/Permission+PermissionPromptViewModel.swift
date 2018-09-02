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
    
    private var displayTitle: String {
        return String(describing: self).capitalized
    }
    
    private var iconImage: UIImage {
        let bundle = Bundle(for: PermissionPromptView.self)
        
        switch self {
        case .contacts:
            return UIImage(named: "icon_contacts", in: bundle, compatibleWith: nil)!
        case .locationAlways:
            return UIImage(named: "icon_location", in: bundle, compatibleWith: nil)!
        case .locationWhenInUse:
            return UIImage(named: "icon_location", in: bundle, compatibleWith: nil)!
        case .photos:
            return UIImage(named: "icon_photos", in: bundle, compatibleWith: nil)!
        }
    }
    
    private var displayReason: String {
        // TODO: replace text
        switch self {
        case .contacts:
            return NSLocalizedString("Contacts permission is necessary for accessing your list of contacts.", comment: "")
        case .locationAlways:
            return NSLocalizedString("Location permission is necessary for determining your current location.", comment: "")
        case .locationWhenInUse:
            return NSLocalizedString("Location permission is necessary for determining your current location.", comment: "")
        case .photos:
            return NSLocalizedString("Photos permission is necessary for accessing your photo album.", comment: "")
        }
    }
    
    func toPromptViewModel() -> PermissionPromptViewModel {
        let viewModel = PermissionPromptViewModel(icon: iconImage, title: displayTitle, reason: displayReason)
        return viewModel
    }
}
