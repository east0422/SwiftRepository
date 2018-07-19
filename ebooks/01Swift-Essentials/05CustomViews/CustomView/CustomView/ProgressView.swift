//
//  ProgressView.swift
//  CustomView
//
//  Created by dfang on 2018-7-25.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressView: UIView {

    let circleLayer = CAShapeLayer.init()
    let stopLayer = CAShapeLayer.init()
    let progressLayer = CAShapeLayer.init()
    @IBInspectable var progressValue:CGFloat = 0.5
    let maskLayer = CAShapeLayer.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        setupUI()
    }

    func setupUI() {
        for _layer in [progressLayer, circleLayer, stopLayer] {
            _layer.strokeColor = UIColor.black.cgColor
            _layer.fillColor = nil
            self.layer.addSublayer(_layer)
        }
        
        progressLayer.lineWidth = 10
        progressLayer.strokeColor = UIColor.blue.cgColor
        
        updateUI()
    }
    
    func updateUI() {
        let radius: CGFloat = 100
        let rect = CGRect.init(x: self.center.x - radius, y: self.center.y - radius, width: radius * 2, height: radius * 2)
        
        circleLayer.path = UIBezierPath.init(ovalIn: rect).cgPath
        
        stopLayer.fillColor = UIColor.black.cgColor
        stopLayer.path = UIBezierPath.init(rect: rect.insetBy(dx: rect.width / 3, dy: rect.height / 3)).cgPath
        
        let center = CGPoint.init(x: rect.midX, y: rect.midY)
        
//        let endAngle = -CGFloat.pi / 2 + CGFloat.pi * 2 * progressValue
//        progressLayer.path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: endAngle, clockwise: true).cgPath
        
        progressLayer.path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 3 / 2, clockwise: true).cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progressValue
        
        maskLayer.path = circleLayer.path
        progressLayer.mask = maskLayer
    }
}
