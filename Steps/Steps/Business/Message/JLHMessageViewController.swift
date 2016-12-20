//
//  JLHMessageViewController.swift
//  Steps
//
//  Created by mathsandphysics on 2016/12/21.
//  Copyright © 2016年 Utopia. All rights reserved.
//

import UIKit

class JLHMessageViewController: JLHBaseViewController {
    
    var isPresented = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let popover = PopoverViewController()
        popover.modalPresentationStyle = .custom
        popover.transitioningDelegate = self
        present(popover, animated: true, completion: nil)
    }
    
}


// MARK: - 自定义转场代理人
extension JLHMessageViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {        
        return JLHPopoverPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
// MARK: - 实现弹出动画的对象
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
// MARK: - 实现消失动画的对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

// MARK: - 转场动画弹出和消失的方法
extension JLHMessageViewController : UIViewControllerAnimatedTransitioning {
    // MARK: - 动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    // MARK: - 通过转场上下文获取弹出的view和消失的view
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? presentedAnimation(using: transitionContext) : dismissAnimation(using: transitionContext)
    }
}

extension JLHMessageViewController {
    func presentedAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let presentedView = transitionContext.view(forKey: .to)!
        transitionContext.containerView.addSubview(presentedView)
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let dismissView = transitionContext.view(forKey: .from)!
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        }) { (_) in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
