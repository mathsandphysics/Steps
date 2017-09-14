//
//  UITextView+Placeholder.swift
//  Steps
//
//  Created by mathsandphysics on 2017/1/28.
//  Copyright © 2017年 Utopia. All rights reserved.
//

import UIKit

fileprivate var placeholderKey: Void?

fileprivate let defaultPlaceholderColor: UIColor = getDefaultPlaceholderColor()

fileprivate func getDefaultPlaceholderColor() -> UIColor {
    let textField = UITextField()
    textField.placeholder = " "
    return textField .value(forKeyPath: "_placeholderLabel.textColor") as! UIColor
}

fileprivate func observingKeys() -> Array<String> {
    return ["attributedText",
            "bounds",
            "font",
            "frame",
            "text",
            "textAlignment",
            "textContainerInset"]
}

extension UITextView {
    
    open override class func initialize() {
        super.initialize()
        let selector: Selector = Selector(("deinit"))
         method_exchangeImplementations(class_getInstanceMethod(self, selector), class_getInstanceMethod(UITextView.self, #selector(swizzledDealloc)))
    }
    
    func swizzledDealloc() {
        NotificationCenter.default.removeObserver(self)
        if (objc_getAssociatedObject(self, &placeholderKey) as? UILabel) != nil {
            for key in observingKeys() {
                removeObserver(self, forKeyPath: key)
            }
        }
        swizzledDealloc()
    }
    
    
    public var placeholder: String? {
        let label = getPlaceholderLabel()
        return label.text
    }
    
    public func setPlaceholder(_ placeholder: String) {
        let label = getPlaceholderLabel()
        label.text = placeholder
        updatePlaceholderLabel()
    }
    
    public var placeholderColor: UIColor? {
        return getPlaceholderLabel().textColor
    }
    
    public func setPlaceholderColor(_ placeholderColor: UIColor) {
        let label = getPlaceholderLabel()
        label.textColor = placeholderColor
    }
    
    @objc private func updatePlaceholderLabel() {
        let label = getPlaceholderLabel()

        if text.characters.count > 0 {
            label.removeFromSuperview()
            return
        }
        
        if !subviews.contains(label) {            
            addSubview(label)
        }
        
        label.text = placeholder
        label.font = font
        label.textAlignment = textAlignment;
        
        let lineFragmentPadding = textContainer.lineFragmentPadding;
        let textContainerInset = self.textContainerInset
        let x = lineFragmentPadding + textContainerInset.left
        let y = textContainerInset.top
        let width = self.bounds.width - x - lineFragmentPadding - textContainerInset.right;
        let height = label.sizeThatFits(CGSize(width: width, height: 0)).height
        label.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func getPlaceholderLabel() -> UILabel {
        var label = objc_getAssociatedObject(self, &placeholderKey) as? UILabel
        if label == nil {
            label = UILabel()
            label!.textColor = defaultPlaceholderColor
            label!.numberOfLines = 0
            label!.isUserInteractionEnabled = false
            
            objc_setAssociatedObject(self, &placeholderKey, label, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceholderLabel), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
            
            for key in observingKeys() {
                addObserver(self, forKeyPath: key, options: .new, context: nil)
            }
        }
        return label!
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updatePlaceholderLabel()
    }
    
}
