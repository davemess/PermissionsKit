//
//  ViewController.swift
//  PermissionsKitExample
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import PermissionsKit
import os.log

class ViewController: UIViewController, PermissionPromptController {
    
    @IBOutlet weak private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadView()
    }
    
    private func configureView() {
        Permission.allCases.forEach { (permission) in
            let button = PermissionButton(type: .system)
            button.permission = permission
            button.addTarget(self, action: #selector(checkPermissions), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    private func reloadView() {
        stackView.arrangedSubviews.forEach { (view) in
            if let button = view as? PermissionButton {
                button.refresh()
            }
        }
    }
    
    @IBAction func checkPermissions(_ sender: PermissionButton) {
        guard let permission = sender.permission else { return }
        
        self.checkPermissionWithPromptIfNecessary(permission) { result in
            let permissionDescription = String(describing: permission).capitalized
            let alertController: UIAlertController
            
            switch result {
            case .accepted:
                alertController = UIAlertController(title: "Permission Accepted", message: "You have accepted \(permissionDescription) permission.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                    self.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(action)
                
                os_log("%@ permission granted", permissionDescription)
            case .denied(let permissionError):
                alertController = UIAlertController(title: permissionError.errorDescription, message: permissionError.failureReason! + " " + permissionError.recoverySuggestion!, preferredStyle: .alert)
                
                switch permissionError {
                case .notAccepted(_):
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    
                case .notGranted(_):
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (_) in
                        let url = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    })
                    alertController.addAction(settingsAction)
                    
                    os_log("%@ permission denied: %@", permissionDescription, permissionError.localizedDescription)
                case .restricted(_):
                    let action = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    
                    os_log("%@ permission restricted", permissionDescription)
                }
            }
            
            self.present(alertController, animated: true, completion: nil)
            self.reloadView()
        }
    }
}

