//
//  PermissionPromptView.swift
//  PermissionsKit
//
//  Created by David Messing on 5/19/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Callbacks on a PermissionPromptView.
protocol PermissionPromptViewDelegate: class {
    func permissionPromptViewDidSelectAccept(_ permissionPromptView: PermissionPromptView)
    func permissionPromptViewDidSelectDeny(_ permissionPromptView: PermissionPromptView)
}

/// Custom view for displaying permission prompt.
class PermissionPromptView: UIView {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var reasonLabel: UILabel!
    @IBOutlet private weak var acceptButton: UIButton!
    
    weak var delegate: PermissionPromptViewDelegate?
    
    // MARK: - configuration
    
    func configure(_ permission: Permission) {
        let viewModel = permission.toPromptViewModel()
        configure(viewModel)
    }
    
    func configure(_ permissionViewModel: PermissionPromptViewModel) {
        iconImageView.image = permissionViewModel.icon
        titleLabel.text = permissionViewModel.title
        reasonLabel.text = permissionViewModel.reason
        
        let acceptTitle = NSLocalizedString("Enable \(permissionViewModel.title)", comment: "")
        acceptButton.setTitle(acceptTitle, for: UIControl.State())
    }
    
    // MARK: - actions
    
    @IBAction func acceptButtonPressed(_ sender: AnyObject) {
        delegate?.permissionPromptViewDidSelectAccept(self)
    }
    
    @IBAction func denyButtonPressed(_ sender: AnyObject) {
        delegate?.permissionPromptViewDidSelectDeny(self)
    }
}
