//
//  JLHPopoverPresentationController.swift
//  Steps
//
//  Created by mathsandphysics on 2016/12/21.
//  Copyright © 2016年 Utopia. All rights reserved.
//

import UIKit

class JLHPopoverPresentationController: UIPresentationController {
    lazy var coverView: UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = CGRect(x: 100, y: 55, width: 180, height: 250)
        setupCoverView()
    }
}

extension JLHPopoverPresentationController {
    func setupCoverView() {
        containerView?.insertSubview(coverView, at: 0)
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        coverView.frame = containerView!.bounds
        let tap = UITapGestureRecognizer(target: self, action: #selector(JLHPopoverPresentationController.coverClick))
        coverView.addGestureRecognizer(tap)
    }
    
    func coverClick(tap: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
