//
//  PermissionPromptViewControllerPresentationController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Acts as a presentation controller for PermissionPromptViewController during modal presenations.
class PermissionPromptViewControllerPresentationController: UIPresentationController {
    
    lazy var chromeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.35)
        
        return view
    }()
    
    // MARK: - layout
    
    override func containerViewWillLayoutSubviews() {
        let containerView = self.containerView!
        let presentedView = self.presentedView!
        
        chromeView.frame = containerView.bounds
        presentedView.frame = frameOfPresentedViewInContainerView
    }
    
    // MARK: - presentation
    
    override func presentationTransitionWillBegin() {
        
        guard let containerView = self.containerView else { return }
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        
        chromeView.frame = containerView.bounds
        chromeView.alpha = 0.0
        containerView.addSubview(chromeView)
        containerView.addSubview(presentedViewController.view)
        
        coordinator.animate(alongsideTransition: { _ in
            self.chromeView.alpha = 1.0
            }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if completed == false {
            chromeView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        
        coordinator.animate(alongsideTransition: { _ in
            self.chromeView.alpha = 0.0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed == true {
            chromeView.removeFromSuperview()
        }
    }
}
