//
//  CustomView01.swift
//  02Drawing
//
//  Created by dfang on 2018-11-20.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class CustomView01: UIView {
    var image: UIImage!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.setNeedsDisplay() // cause drawRect to be called
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // backgroundColor is nil and opaque is true the background will be black
        self.isOpaque = false
        self.backgroundColor = UIColor.lightGray
        
        
        // When drawing directly into a view (as with drawRect: or drawLayer:inContext:), if the view’s background color is nil or a color with even a tiny bit of transparency, the result of CGContextClearRect will appear to be transparent, punching a hole right through the view including its background color; if the background color is completely opaque, the result of CGContextClearRect will be black
        // clear rect black
//        self.backgroundColor = UIColor.init(red: 0.8, green: 0.7, blue: 0.6, alpha: 1.0)
        // clear rect transparency
        self.backgroundColor = UIColor.init(red: 0.8, green: 0.7, blue: 0.6, alpha: 0.99)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // draw view will not over bounds
    override func draw(_ rect: CGRect) {
//        if var im = self.image {
//            if let asset = self.image.imageAsset {
//                let tc = self.traitCollection
//                im = asset.image(with: tc)
//            }
//            im.draw(at: CGPoint.zero)
//        }

//        draw1(rect)
        
//        drawPathAndShapes()
//        drawPathAndShapes2()
        
        clearRect()
    }
    
    // override draw(rect:)
//    override func draw(_ layer: CALayer, in ctx: CGContext) {
//        let rect = CGRect.init(x: 0, y: 0, width: 100, height: 100)
//        //        UIGraphicsPushContext(ctx)
//        //        let p = UIBezierPath.init(ovalIn:rect)
//        //        UIColor.red.setFill()
//        //        p.fill()
//        //        UIGraphicsPopContext()
//
//        ctx.addEllipse(in: rect)
//        ctx.setFillColor(UIColor.red.cgColor)
//        ctx.fillPath()
//    }
    
    // after draw: called can use the UIKit convenience methods directly
    func draw1(_ rect: CGRect) {
        // use UIKit convenience methods directly after draw: called
//        let p = UIBezierPath.init(ovalIn: rect)
//        UIColor.blue.setFill()
//        p.fill()
        
        // get current context then draw
        let context = UIGraphicsGetCurrentContext()
        //  Core Graphics
        context?.addEllipse(in: rect)
        context?.setFillColor(UIColor.blue.cgColor)
        context?.fillPath()
    }
    
    // core graphics
    func drawPathAndShapes() {
        let ctx = UIGraphicsGetCurrentContext()
        // top red triangle
        ctx?.addLines(between: [CGPoint.init(x: 100, y: 0),
                                CGPoint.init(x: 50, y: 50),
                                CGPoint.init(x: 150, y: 50)
                                ])
        ctx?.setFillColor(UIColor.red.cgColor)
        ctx?.fillPath()
        // center black rectangle
        ctx?.move(to: CGPoint.init(x: 70, y: 50))
        ctx?.addRect(CGRect.init(origin: CGPoint.init(x: 70, y: 50), size: CGSize.init(width: 60, height: 100)))
        ctx?.setFillColor(UIColor.black.cgColor)
        ctx?.fillPath()
        // bottom black triangle
        ctx?.addLines(between: [CGPoint.init(x: 70, y: 150),
                                CGPoint.init(x: 100, y: 110),
                                CGPoint.init(x: 130, y: 150)])
        ctx?.setFillColor(UIColor.white.cgColor)
        ctx?.fillPath()
    }
    
    // uikit
    func drawPathAndShapes2() {
        let p = UIBezierPath()
        // top red triangle
        UIColor.red.set()
        p.move(to: CGPoint.init(x: 100, y: 0))
        p.addLine(to: CGPoint.init(x: 50, y: 50))
        p.addLine(to: CGPoint.init(x: 150, y: 50))
        p.fill()
        // center
        p.removeAllPoints()
        UIColor.black.set()
        p.move(to: CGPoint.init(x: 100, y: 50))
        p.addLine(to: CGPoint.init(x: 100, y: 150))
        p.lineWidth = 60
        p.stroke()
        // bottom
        p.removeAllPoints()
        UIColor.white.set()
        p.move(to: CGPoint.init(x: 70, y: 150))
        p.addLine(to: CGPoint.init(x: 100, y: 110))
        p.addLine(to: CGPoint.init(x: 130, y: 150))
        p.fill()
    }
    
    func clearRect() {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(UIColor.blue.cgColor)
        ctx?.fill(CGRect.init(x: 0, y: 0, width: 100, height: 100))
        ctx?.clear(CGRect.init(x: 0, y: 0, width: 30, height: 30))
    }
}
