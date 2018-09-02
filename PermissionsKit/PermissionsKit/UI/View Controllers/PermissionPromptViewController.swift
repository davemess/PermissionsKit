//
//  PermissionPromptViewController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// View controller subclass for displaying permission prompts.
class PermissionPromptViewController: UIViewController {
    
    @IBOutlet private weak var permissionView: PermissionPromptView!
    
    let permissionController: PermissionController
    let resultHandler: PermissionPromptResultHandler
    
    // MARK: - Lifecycle
    
    init(_ permissionController: PermissionController, resultHandler: @escaping PermissionPromptResultHandler) {
        self.permissionController = permissionController
        self.resultHandler = resultHandler
        
        let bundle = Bundle(for: PermissionPromptViewController.self)
        super.init(nibName: nil, bundle: bundle)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    // MARK: - view Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - view
    
    private func configureView() {
        view.backgroundColor = UIColor.clear
        
        let permission = permissionController.permission
        permissionView.configure(permission)
        permissionView.delegate = self
    }
}

extension PermissionPromptViewController: PermissionPromptViewDelegate {
    
    func permissionPromptViewDidSelectAccept(_ permissionPromptView: PermissionPromptView) {
        permissionController.promptForPermission(resultHandler)
    }
    
    func permissionPromptViewDidSelectDeny(_ permissionPromptView: PermissionPromptView) {
        let permission = permissionController.permission
        let error = PermissionError.notAccepted(permission: permission)
        resultHandler(.denied(error: error))
    }
}

/// Extends PermissionPromptViewController with functionality for UIViewControllerTransitioningDelegate.
extension PermissionPromptViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        guard presented == self else {
            return nil
        }
        
        return PermissionPromptViewControllerPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard presented == self else {
            return nil
        }
        
        return PermissionPromptViewControllerAnimationController(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard dismissed == self else {
            return nil
        }
        
        return PermissionPromptViewControllerAnimationController(isPresenting: false)
    }
}
