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
    // TODO: add remaining permissions
//    case bluetooth
    case calendar
    case camera
//    case cloudKit
    case contacts
    case locationWhenInUse
    case locationAlways
//    case media
    case microphone
//    case motion
//    case music
    case photos
    case reminders
//    case speech
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
        case .microphone:
            return NSLocalizedString("microphone", comment: "")
        case .photos:
            return NSLocalizedString("photos", comment: "")
        case .reminders:
            return NSLocalizedString("reminders", comment: "")
        }
    }
    
}
