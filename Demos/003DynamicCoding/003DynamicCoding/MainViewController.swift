//
//  MainViewController.swift
//  003DynamicCoding
//
//  Created by dfang on 2018-8-27.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
//        addChildVC(childVC: HomeViewController.init(), title: "home")
//        addChildVC(childVC: MessageViewController(), title: "message")
//        addChildVC(childVC: DiscoveryViewController.init(), title: "discovery")
//        addChildVC(childVC: ProfileViewController(), title: "profile")
        
        // 动态编码，依据传入控制器的名字创建控制器
        addChildVC(childVCName: "HomeViewController", title: "home")
        addChildVC(childVCName: "MessageViewController", title: "message")
        addChildVC(childVCName: "DiscoveryViewController", title: "discovery")
        addChildVC(childVCName: "ProfileViewController", title: "profile")
    }
    
    func addChildVC(childVCName: String, title: String) {
         // 系统类前面不需要添加命名空间
//        print(NSClassFromString("NSString"))
//        print(NSClassFromString("UIViewController"))
        // 获取命名空间
        guard var targetName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("Get CFBundleExecutable nil!")
            return
        }
//        print("targetName:" + targetName)
        
        guard let firstChar = targetName.first else {
            print("first character is nil")
            return
        }
        if ("0123456789".contains(firstChar)) { // 首字符为数字就讲首字符替换为下划线
            targetName.replaceSubrange(targetName.startIndex...targetName.startIndex, with: "_")
        }
//         print("after targetName:" + targetName)
        // 自定义类前面需要添加命名空间
        guard let Class = NSClassFromString(targetName + "." + childVCName) as? UIViewController.Type else {
            print("Class is nil")
            return
        }
        print(Class)
        addChildVC(childVC: Class.init(), title: title)
    }
    // 添加子控制器
    func addChildVC(childVC: UIViewController, title: String) {
//        print(childVC) // <_03DynamicCoding.HomeViewController: 0x102842040>
        childVC.title = title // navbar title
        let navVC = UINavigationController.init(rootViewController: childVC)
        navVC.title = title  // tabbar title
        addChildViewController(navVC)
    }
    
}
