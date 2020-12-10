//
//  CustomDrawView.swift
//  04CustomDraw
//
//  Created by dfang on 2020-12-8.
//  Copyright © 2020 east. All rights reserved.
//

import UIKit

class CustomDrawView: UIView {
    
    var drawPath = CGMutablePath.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.addPath(drawPath)
        ctx?.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawPath.move(to: touches.first?.location(in: self) ?? CGPoint.zero)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawPath.addLine(to: touches.first?.location(in: self) ?? CGPoint.zero)
        setNeedsDisplay()
    }
}
