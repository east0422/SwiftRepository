//
//  ViewController.swift
//  SingleView
//
//  Created by dfang on 2018-7-23.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: view.bounds)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Welcome to Swift Single View!"
        view.addSubview(label)
    }
    
}

