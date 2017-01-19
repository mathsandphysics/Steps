//
//  JLHMessageViewController.swift
//  Steps
//
//  Created by mathsandphysics on 2016/12/21.
//  Copyright © 2016年 Utopia. All rights reserved.
//

import UIKit

class JLHMessageViewController: JLHBaseViewController {
    
    private lazy var popoverAnimator = PopoverAnimator()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        popoverAnimator.presentFrame = CGRect(x: 100, y: 55, width: 180, height: 250)
        let popover = PopoverViewController()
        popover.modalPresentationStyle = .custom
        popover.transitioningDelegate = popoverAnimator
        present(popover, animated: true, completion: nil)
    }
    
}



