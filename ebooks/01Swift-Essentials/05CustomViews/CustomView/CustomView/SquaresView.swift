//
//  SquaresView.swift
//  CustomView
//
//  Created by dfang on 2018-7-25.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class SquaresView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.blue.cgColor)
        context?.stroke(CGRect.init(x: center.x - 50, y: center.y - 50, width: 100, height: 100))
        
        context?.setFillColor(UIColor.cyan.cgColor)
        context?.fill(CGRect.init(x: center.x - 25, y: center.y - 25, width: 50, height: 50))
        
        context?.stroke(CGRect.init(x: center.x - 25, y: center.y - 25, width: 50, height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentMode = UIViewContentMode.redraw
    }
}
