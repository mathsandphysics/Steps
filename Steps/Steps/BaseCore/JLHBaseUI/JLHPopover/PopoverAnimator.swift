//
//  PopoverAnimator.swift
//  Steps
//
//  Created by mathsandphysics on 2017/1/20.
//  Copyright © 2017年 Utopia. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    /** 标识present状态 */
    var isPresented = false
    var presentFrame = CGRect.zero
    var animationDuration = 0.5
    
    var closure : ((_ isPresented : Bool) -> ())?
}

// MARK: - 自定义转场代理人
extension PopoverAnimator : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = JLHPopoverPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentFrame
        return presentation
    }
    
    // MARK: - 实现弹出动画的对象
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        closure!(isPresented)
        return self
    }
    
    // MARK: - 实现消失动画的对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        closure!(isPresented)
        return self
    }
}

// MARK: - 转场动画弹出和消失的方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning {
    // MARK: - 动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    // MARK: - 通过转场上下文获取弹出的view和消失的view
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? presentedAnimation(using: transitionContext) : dismissAnimation(using: transitionContext)
    }
}


extension PopoverAnimator {
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
