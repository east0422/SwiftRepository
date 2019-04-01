//
//  ViewController.swift
//  03Layers (layers and sublayers)
//
//  Created by dfang on 2018-12-10.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testLayers1();
    }
    
    // Manipulating the Layer Hierarchy (zPostion)
    func testLayers1() {
        let lay1 = CALayer()
        lay1.backgroundColor = UIColor.red.cgColor
        lay1.frame = CGRect.init(x: 113, y: 111, width: 132, height: 194)
        lay1.zPosition = 1 // default 0
        view.layer.addSublayer(lay1)
        
        let lay2 = CALayer()
        lay2.backgroundColor = UIColor.green.cgColor
        lay2.frame = CGRect.init(x: 41, y: 56, width: 132, height: 194)
//        lay1.masksToBounds = true // invisible beyond the bounds of lay2 layer
        lay1.addSublayer(lay2)
        
        let lay3 = CALayer()
        lay3.backgroundColor = UIColor.blue.cgColor
        lay3.frame = CGRect.init(x: 43, y: 197, width: 160, height: 230)
//        lay3.zPosition = 3;
        // add image into layer(just cgimage)
        lay3.contents = UIImage.init(named: "fish.jpg")?.cgImage
        view.layer.addSublayer(lay3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

