//
//  RootViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.blue
        tabBar.barTintColor = UIColor.white
    
        let homeVC = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeStoryboardId")
        let mineVC = UIStoryboard.init(name: "Mine", bundle: nil).instantiateViewController(withIdentifier: "MineStoryboardId")
        addChildVC(homeVC, childTitle: "首页", imageName: "home")
        addChildVC(mineVC, childTitle: "个人中心", imageName: "mine")
    }
    
    // 添加子控制器
    private func addChildVC(_ childVC: UIViewController, childTitle: String, imageName: String) {
        childVC.title = childTitle
        childVC.tabBarItem.image = UIImage.init(named: imageName)
        addChild(UINavigationController.init(rootViewController: childVC))
    }
}
