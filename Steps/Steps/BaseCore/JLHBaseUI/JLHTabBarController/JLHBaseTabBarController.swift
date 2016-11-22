//
//  JLHBaseTabBarController.swift
//  Steps
//
//  Created by mathsandphysics on 2016/11/22.
//  Copyright © 2016年 Utopia. All rights reserved.
//

import UIKit

class JLHBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let jsonPath = Bundle.main.path(forResource: "JLHTabBarSettings.json", ofType: nil) else {
            assertionFailure("获取配置文件路径失败!")
            return
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            assertionFailure("没有获取到json文件中数据!")
            return
        }
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return
        }
        
        guard let dictArray = anyObject as? [[String : AnyObject]] else {
            return
        }

        for dict in dictArray {
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            
            guard let title = dict["title"] as? String else {
                continue
            }
            
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
            
            loadChildViewController(viewControllerName: vcName, title: title, image: imageName)
        }
    }
    
    
    
    
    private func loadChildViewController(viewControllerName: String, title: String, image: String) {
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            assertionFailure("获取命名空间失败!")
            return
        }
        
        guard let childVCClass = NSClassFromString(nameSpace + "." + viewControllerName) else {
            assertionFailure("获取对应的类失败!")
            return
        }
        
        guard let childVCType = childVCClass as? UIViewController.Type else {
            assertionFailure("该类不是UIViewController类型!")
            return
        }
        
        let childVC = childVCType.init()
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: image)
        childVC.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        
        let nav = UINavigationController(rootViewController: childVC)
        
        addChildViewController(nav)
    }

}
