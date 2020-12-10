//
//  CustomView.swift
//  04CustomDraw
//
//  Created by dfang on 2020-9-28.
//  Copyright © 2020 east. All rights reserved.
//

import UIKit

class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        
        ctx?.move(to: CGPoint.init(x: 0, y: 0))
        
        // 绘制线条
        ctx?.addLine(to: CGPoint.init(x: 100, y: 60))
        ctx?.addLine(to: CGPoint.init(x: 80, y: 100))
        
        ctx?.setStrokeColor(UIColor.red.cgColor)
        ctx?.setLineWidth(5)
        
        ctx?.strokePath()
        
        // 弧线
        let center = CGPoint.init(x: 90, y: 90)
        ctx?.move(to: center)
        ctx?.addArc(center: center, radius: 80, startAngle: 0, endAngle: CGFloat.pi * 2 * 0.6, clockwise: false)
        ctx?.addLine(to: center)
        ctx?.setFillColor(UIColor.lightGray.cgColor)
        ctx?.fillPath()
        
        // 弧线外边框
        ctx?.move(to: center)
        ctx?.addArc(center: center, radius: 80, startAngle: 0, endAngle: CGFloat.pi * 2 * 0.6, clockwise: false)
        ctx?.addLine(to: center)
        ctx?.setStrokeColor(UIColor.green.cgColor)
        ctx?.strokePath()
        
        
        // 1 绘制图片
        let img = UIImage.init(named: "003.jpg")
        let imgRect = CGRect.init(x: 0, y: 100, width: 300, height: 400)
        
        // 2.1 使用UIKit绘制不需要处理
//        img?.draw(in: imgRect)
        
        // 保存状态
        ctx?.saveGState()

        // 2.2 使用CoreGraphics绘制y坐标需要翻转
        ctx?.translateBy(x: 0, y: 700)
        ctx?.scaleBy(x: 1.0, y: -1.0)
        guard let cgimg = img?.cgImage else { return }
        ctx?.draw(cgimg, in: imgRect)

        // 恢复状态
        ctx?.restoreGState()
    }
}
