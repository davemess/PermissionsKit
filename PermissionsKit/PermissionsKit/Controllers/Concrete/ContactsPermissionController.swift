//
//  ContactsPermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 9/2/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Contacts

/// Concrete controller for photos permission.
class ContactsPermissionController: PermissionController {
    
    var permission: Permission { return .contacts }
    
    var permissionStatus: PermissionStatus {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied:
            return .denied
        case .authorized:
            return .permitted
        }
    }
    
    var shouldPromptForPermission: Bool {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        return status == .notDetermined
    }
    
    private let contactStore: CNContactStore
    
    // MARK: - Lifecycle
    
    init(_ contactStore: CNContactStore = CNContactStore()) {
        self.contactStore = contactStore
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        contactStore.requestAccess(for: .contacts) { (granted, _) in
            if granted == true {
                resultHandler(.accepted)
            } else {
                let error = PermissionError.notGranted(permission: self.permission)
                resultHandler(.denied(error: error))
            }
        }
    }
    
}
