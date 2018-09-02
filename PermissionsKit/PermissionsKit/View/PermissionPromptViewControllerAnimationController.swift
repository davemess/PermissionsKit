//
//  PermissionPromptViewControllerAnimationController.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Acts as an animation controller during transitions to and from PermissionPromptViewController.
class PermissionPromptViewControllerAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting: Bool
    
    // MARK: - lifecycle
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentationTransition(transitionContext)
        } else {
            animateDismissalTransition(transitionContext)
        }
    }
    
    // MARK: - private
    
    private func animatePresentationTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let containerView = transitionContext.containerView
        
        presentedView.alpha = 0
        containerView.addSubview(presentedView)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration,
                                   delay: 0,
                                   options: [.curveEaseOut],
                                   animations: {
                                    presentedView.alpha = 1
            },
                                   completion: {(completed: Bool) -> Void in
                                    transitionContext.completeTransition(completed)
        })
    }
    
    private func animateDismissalTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentedViewController = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration,
                                   animations: {
                                    presentedViewController.alpha = 0
            },
                                   completion: {(completed: Bool) -> Void in
                                    transitionContext.completeTransition(completed)
        })
    }
}
