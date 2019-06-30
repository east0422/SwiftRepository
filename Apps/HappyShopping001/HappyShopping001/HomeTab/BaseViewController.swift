//
//  BaseViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置背景颜色
        self.view.backgroundColor = BGCOLOR
        // 设置用户信息
        self.navigationItem.title = UserInfoModel.fetchUserInfo()?.mobile ?? "默认标题"
        // 返回按钮标题
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
}
