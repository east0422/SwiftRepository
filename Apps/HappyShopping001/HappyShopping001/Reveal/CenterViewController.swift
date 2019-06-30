//
//  CenterViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-22.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        self.navigationItem.title = "中间"
        
        let revealVC = self.revealViewController()
        if (revealVC != nil) {
            self.view.addGestureRecognizer(revealVC!.panGestureRecognizer())
        }
    }
}
