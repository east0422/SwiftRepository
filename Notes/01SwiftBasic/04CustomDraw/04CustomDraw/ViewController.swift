//
//  ViewController.swift
//  04CustomDraw
//
//  Created by dfang on 2020-9-28.
//  Copyright © 2020 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addCustomView()
//        addDrawView()
    }
    
    func addCustomView() {
        let customView = CustomView.init(frame: CGRect.init(x: 60, y: 60, width: 600, height: 800))
        customView.backgroundColor = UIColor.lightText
        view.addSubview(customView)
    }
    
    func addDrawView() -> Void {
        let drawV = CustomDrawView.init(frame: view.frame)
        drawV.backgroundColor = UIColor.clear
        view.addSubview(drawV)
    }
}

