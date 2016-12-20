//
//  UIButton+Extension.swift
//  Steps
//
//  Created by mathsandphysics on 2016/12/21.
//  Copyright © 2016年 Utopia. All rights reserved.
//

import UIKit

extension UIButton {
    
    /** 便利构造函数, 需要明确调用self.init */
    convenience init (imageName: String, backgroudImageName: String) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: backgroudImageName), for: .normal)
        setBackgroundImage(UIImage(named: backgroudImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
