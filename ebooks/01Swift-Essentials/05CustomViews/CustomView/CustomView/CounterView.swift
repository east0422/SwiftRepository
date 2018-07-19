//
//  CounterView.swift
//  CustomView
//
//  Created by dfang on 2018-7-25.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class CounterView: UIView {
    
    @IBOutlet weak var counter:UILabel!
    
    @IBAction func stepperChanged(stepper:UIStepper) {
        counter.text = "Count is \(stepper.value)"
    }
}
