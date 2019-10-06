//
//  EventStorePermissionController.swift
//  PermissionsKit
//
//  Created by David Messing on 9/2/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import EventKit

/// An abstract superclass for event permissions.
class EventStorePermissionController: PermissionController {
    
    var entityType: EKEntityType {
        fatalError("Do not instantiate the abstract class.")
    }
    
    var permission: Permission {
        switch entityType {
        case .event:
            return .calendar
        case .reminder:
            return .reminders
        @unknown default:
            fatalError()
        }
    }
    
    var permissionStatus: PermissionStatus {
        let status = EKEventStore.authorizationStatus(for: entityType)
        switch status {
        case .notDetermined:
            return .unknown
        case .restricted, .denied:
            return .denied
        case .authorized:
            return .permitted
        @unknown default:
            fatalError()
        }
    }
    
    var shouldPromptForPermission: Bool {
        let status = EKEventStore.authorizationStatus(for: entityType)
        return status == .notDetermined
    }
    
    private let eventStore: EKEventStore
    
    // MARK: - Lifecycle
    
    init(_ eventStore: EKEventStore = EKEventStore()) {
        self.eventStore = eventStore
    }
    
    func promptForPermission(_ resultHandler: @escaping PermissionPromptResultHandler) {
        eventStore.requestAccess(to: entityType) { (granted, error) in
            if granted == true {
                resultHandler(.accepted)
            } else {
                let error = PermissionError.notGranted(permission: self.permission)
                resultHandler(.denied(error: error))
            }
        }
    }
}

/// Concrete class for calendar permission.
class CalendarPermissionController: EventStorePermissionController {
    
    override var entityType: EKEntityType { return .event }
}

/// Concrete class for reminders permission.
class RemindersPermissionController: EventStorePermissionController {
    
    override var entityType: EKEntityType { return .reminder }
}
