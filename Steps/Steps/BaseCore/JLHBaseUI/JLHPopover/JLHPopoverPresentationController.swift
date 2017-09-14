//
//  JLHPopoverPresentationController.swift
//  Steps
//
//  Created by mathsandphysics on 2016/12/21.
//  Copyright © 2016年 Utopia. All rights reserved.
//

import UIKit

class JLHPopoverPresentationController: UIPresentationController {
    
    var presentedFrame: CGRect = .zero
    
    fileprivate lazy var coverView: UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = presentedFrame
        setupCoverView()
    }
}

extension JLHPopoverPresentationController {
    func setupCoverView() {
        containerView?.insertSubview(coverView, at: 0)
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.45)
        coverView.frame = containerView!.bounds
        let tap = UITapGestureRecognizer(target: self, action: #selector(JLHPopoverPresentationController.coverClick))
        coverView.addGestureRecognizer(tap)
    }
    
    func coverClick(tap: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
