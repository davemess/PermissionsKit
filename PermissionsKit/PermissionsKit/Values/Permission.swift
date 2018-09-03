//
//  Permission.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Defines a set of iOS permissions.
public enum Permission: CaseIterable {
    case calendar
    case camera
    case contacts
    case locationWhenInUse
    case locationAlways
    case media
    case microphone
    case motion
    case photos
    case reminders
    case speech
}

extension Permission: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .calendar:
            return NSLocalizedString("calendar", comment: "")
        case .camera:
            return NSLocalizedString("camera", comment: "")
        case .contacts:
            return NSLocalizedString("contacts", comment: "")
        case .locationWhenInUse:
            return NSLocalizedString("location when in use", comment: "")
        case .locationAlways:
            return NSLocalizedString("location always", comment: "")
        case .media:
            return NSLocalizedString("media", comment: "")
        case .microphone:
            return NSLocalizedString("microphone", comment: "")
        case .motion:
            return NSLocalizedString("motion", comment: "")
        case .photos:
            return NSLocalizedString("photos", comment: "")
        case .reminders:
            return NSLocalizedString("reminders", comment: "")
        case .speech:
            return NSLocalizedString("speech", comment: "")
        }
    }
    
}
