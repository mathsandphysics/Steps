//
//  JLHMessageViewController.swift
//  Steps
//
//  Created by mathsandphysics on 2016/12/21.
//  Copyright © 2016年 Utopia. All rights reserved.
//

import UIKit

class JLHMessageViewController: JLHBaseViewController {
    
    // MARK:- 测试代码
    fileprivate lazy var textInput = UITextView(frame: CGRect(origin: CGPoint(x: 0, y: 64), size: CGSize(width: UIScreen.main.bounds.size.width, height: 40)))
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textInput.isFirstResponder {
            view.endEditing(true)
        } else {
            textInput.becomeFirstResponder()
            textInput.text = "开始输入名字"
        }
    }
    
    fileprivate lazy var popoverAnimator = PopoverAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    fileprivate func createUI() {
        // MARK:- 测试代码
        //        textInput.isUserInteractionEnabled = true
        //        textInput.font = UIFont.systemFont(ofSize: 14)
        //        textInput.setPlaceholder("请输入你的名字")
        //        textInput.delegate = self
        //        view.addSubview(textInput)
        
    }
}

extension JLHMessageViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

extension JLHMessageViewController {
    func popoverMenu() {
        let popover = PopoverViewController()
        popover.modalPresentationStyle = .custom
        popoverAnimator.presentFrame = CGRect(x: 100, y: 55, width: 180, height: 250)
        popoverAnimator.closure = {(_ isPresented : Bool) -> () in
            JLH_Log(message: isPresented)
        }
        popover.transitioningDelegate = popoverAnimator
        present(popover, animated: true, completion: nil)
    }
}


