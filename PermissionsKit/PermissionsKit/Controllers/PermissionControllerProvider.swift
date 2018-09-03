//
//  PermissionControllerProvider.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// A singleton provider for supplying PermissionControllers.
public class PermissionControllerProvider {
    
    // MARK: - Lifecycle
    
    /// Returns the default provider object.
    public static let standard = PermissionControllerProvider()
    private init() {}
    
    // MARK: - Properties
    
    private lazy var calendarPermissionController: CalendarPermissionController = {
        let controller = CalendarPermissionController()
        return controller
    }()
    
    private lazy var cameraPermissionController: CameraPermissionController = {
        let controller = CameraPermissionController()
        return controller
    }()
    
    private lazy var contactsPermissionController: ContactsPermissionController = {
        let controller = ContactsPermissionController()
        return controller
    }()
    
    private lazy var alwaysLocationPermissionController: LocationPermissionController = {
        let controller = LocationAlwaysPermissionController()
        return controller
    }()
    
    private lazy var whenInUseLocationPermissionController: LocationPermissionController = {
        let controller = LocationWhenInUsePermissionController()
        return controller
    }()
    
    private lazy var mediaPermissionController: MediaPermissionController = {
        let controller = MediaPermissionController()
        return controller
    }()
    
    private lazy var microphonePermissionController: MicrophonePermissionController = {
        let controller = MicrophonePermissionController()
        return controller
    }()
    
    private lazy var motionPermissionController: MotionPermissionController = {
        let controller = MotionPermissionController()
        return controller
    }()
    
    private lazy var photosPermissionController: PhotosPermissionController = {
        let controller = PhotosPermissionController()
        return controller
    }()
    
    private lazy var remindersPermissionController: RemindersPermissionController = {
        let controller = RemindersPermissionController()
        return controller
    }()
    
    private lazy var speechPermissionController: SpeechPermissionController = {
        let controller = SpeechPermissionController()
        return controller
    }()
    
    // MARK: - Public
    
    /// Returns a controller for the specified permission.
    ///
    /// - Parameter permission: the requested permission resource.
    /// - Returns: a controller for the specified permission.
    public func permissionController(_ permission: Permission) -> PermissionController {
        switch permission {
        case .calendar:
            return calendarPermissionController
        case .camera:
            return cameraPermissionController
        case .contacts:
            return contactsPermissionController
        case .locationWhenInUse:
            return whenInUseLocationPermissionController
        case .locationAlways:
            return alwaysLocationPermissionController
        case .media:
            return mediaPermissionController
        case .microphone:
            return microphonePermissionController
        case .motion:
            return motionPermissionController
        case .photos:
            return photosPermissionController
        case .reminders:
            return remindersPermissionController
        case .speech:
            return speechPermissionController
        }
    }
    
}
