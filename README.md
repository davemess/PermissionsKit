![Swift](http://img.shields.io/badge/swift-4.2-brightgreen.svg)
[![Build Status](https://travis-ci.org/davemess/PermissionsKit.svg?branch=develop)](https://travis-ci.org/davemess/PermissionsKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platform Version](https://cocoapod-badges.herokuapp.com/p/arek/badge.png)

# PermissionsKit
PermissionsKit is an easy-to-use and unified Swift API for determining and requesting access to system resources that require user permission. In addition, a simple UI is included for prompting the user for permissions.

![](./Resources/Demo.gif)

Out of the box, the following permissions are supported:

- Calendar
- Camera
- Contacts
- Location (When in Use and Always)
- Media Library
- Microphone
- Motion Activity
- Photos
- Reminders
- Speech Recognition

See [this Stack Overflow answer](https://stackoverflow.com/a/39769201/2041457) for a list of all permissions.

#### Compatibility
PermissionsKit is written in Swift and supports Swift 4.2 and iOS 12.

#### Example
See the example app for usage.

#### Documentation
Docs can be generated via [Jazzy](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwirk4ymtZ_dAhVBxoMKHcCWAi8QFjAAegQIBhAC&url=https%3A%2F%2Fgithub.com%2Frealm%2Fjazzy&usg=AOvVaw1vlowOTz3BSde6t52oKl_G) and a `docs` target is included.

---

## Installation

Recommended to use [Carthage](https://github.com/Carthage/Carthage).

- Add `github.com/davemess/PermissionsKit.git` to your Cartfile
- Perform a `carthage update`
- Embed the built product in your app's embedded frameworks.

##### __Important__

Your app _must_ define Info.plist keys for the associated permissions or it will crash when the user is prompted by the system. _(See the Info.plist in PermissionsKitExample)._ The relevant keys are:

- NSCalendarsUsageDescription
- NSCameraUsageDescription
- NSContactsUsageDescription
- NSLocationWhenInUseUsageDescription
- NSLocationAlwaysUsageDescription
- NSLocationAlwaysAndWhenInUseUsageDescription
- NSAppleMusicUsageDescription
- NSMicrophoneUsageDescription
- NSMotionUsageDescription
- NSPhotoLibraryUsageDescription
- NSRemindersUsageDescription
- NSSpeechRecognitionUsageDescription

---

## Usage

#### Objectives

PermissionsKit has two objectives:

1. Standardize and unify the authorization mechanisms for the different system resources which require authorization.
2. Provide a standard UI for prompting the user for permissions.

#### Relevant Classes

`Permission`
A enum value which defines the supported permission types.

`PermissionController`
Manages access to a specific permission. Once you have access to a PermissionController instance for a specific Permission, you can query status and/or prompt the user for permission.

`PermissionControllerProvider`
A singleton which supplies PermissionController instances for each supported Permission type.

`PermissionPromptController`
This is a protocol which exists to make managing and prompting permissions easier. A default implementation exists for UIViewController which presents

`PermissionPromptViewController`
This is included as a UI element for prompting users before the system dialog.

#### Usage Examples

You can use PermissionsKit with or without the UI component. To use without:

```swift
// Get a reference to the controller
let provider = PermissionControllerProvider.standard
let controller = provider.permissionController(.photos)

// Now you can use the controller directly to get the current status for the Photos permission.
let status = permissionStatus
switch status {
  case .unknown:
    // status is unknown, probably because the user has not been prompted
  case .permitted:
    // this permission has been granted, and you are free to use the resource
  case .denied:
    // this permission is blocked, and you should not attempt to use the resource
}
```

You can also use the included UI. For instance, conform your custom view controller to PermissionPromptController and you will get the built in functionality:

```swift
import PermissionsKit

class MyCustomViewController: UIViewController, PermissionPromptController {
  ....

  @IBAction func importPhotoButtonPressed(_ sender: Any) {
    let permission: Permission = .photos
    if shouldPromptForPermission(permission) {

      // This will present an animated view with user-facing messaging about the permission you are requesting. If the user accepts, the system prompt will be shown. If they deny, you should handle the denial.
      promptForPermission(permission, animated: true) { result in
        switch result {
          case .accepted:
            // The user accepted the custom UI and the system prompt. You are free to use the resource.
          case .denied(let permissionError):
            // The user denied. Check the error to find out why.
          }

      }
    }
  }
```
---

### Contributing

Definitely looking for contributors. Particularly UI designers.

### License

PermissionsKit is available under the MIT license. See the LICENSE file for more info.

### Credits
- Background image photo by Casey Horner on Unsplash.
- Icons from Flaticon.

---

## TODO
_Admin_
- [x] Document public interface
- [x] Update README with usage examples
- [ ] Versioning
- [ ] Unit Testing
- [ ] New UI!
