//
//  TwoLabels.swift
//  CustomView
//
//  Created by dfang on 2018-7-25.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class TwoLabels: UIView {
    var left:UILabel = UILabel.init()
    var right:UILabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initContentView()
    }

    func initContentView() {
        left.text = "Left"
        right.text = "Right"
        addSubview(left)
        addSubview(right)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        for subview in self.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        let namedViews = ["left":left,"right":right]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[left]-[right]-|", options: NSLayoutFormatOptions.alignAllTop, metrics: nil, views: namedViews))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[left]-|", options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: namedViews))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[right]-|", options: NSLayoutFormatOptions.alignAllRight, metrics: nil, views: namedViews))
        
        super.updateConstraints()
    }
}
