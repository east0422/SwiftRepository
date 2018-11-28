//
//  ViewController.swift
//  02Drawing
//
//  Created by dfang on 2018-10-29.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    let viewH:CGFloat = 200
    let viewW:CGFloat = 200
    let top:CGFloat = 60
    lazy var left: CGFloat = {
        return (self.view.frame.width - viewW) / 2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // draw image after draw: called in uiview
        let cusView1 = CustomView01.init(frame: CGRect.init(x: left, y: top, width: viewW, height: viewH))
        self.view.addSubview(cusView1)
        
        // draw image view in anywhere and anytime
//        drawImage1()
//        drawImage2()
        
//        blurAndVibrancyView()
    }
    
    func blurAndVibrancyView() {
        let blur = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.dark))
        blur.frame = CGRect.init(x: 10, y: 50, width: 200, height: 200)
        blur.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        let vib = UIVisualEffectView.init(effect: UIVibrancyEffect.init(blurEffect: blur.effect as! UIBlurEffect))
        let label = UILabel.init()
        label.text = "Blur and Vibrancy!"
        label.sizeToFit()
        vib.frame = label.frame
        vib.contentView.addSubview(label)
        vib.center = CGPoint.init(x: blur.bounds.midX, y: blur.bounds.midY)
        vib.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        blur.contentView.addSubview(vib)
        self.view.addSubview(blur)
    }
    
    func drawImage1() {
        let size = CGSize.init(width: 100, height: 100)
        let rect = CGRect.init(origin: CGPoint.zero, size: size)
        // The second argument declares whether the image should be opaque; if true the image would have a black background. The third argument specifies the image scale
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        // method1
//        let p = UIBezierPath.init(ovalIn: rect)
//        UIColor.green.setFill()
//        p.fill()
        
        // method2
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.addEllipse(in: rect)
        ctx?.setFillColor(UIColor.cyan.cgColor)
        ctx?.fillPath()
        
        let im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView1 = UIImageView.init(image: im)
        self.view.addSubview(imageView1)
    }
    
    func drawImage2() {
        let mars = UIImage.init(named: "mars1")!
        let size = CGSize.init(width: 150, height: 150)
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: size.width * 2, height: size.height * 2), false, 0)
        
        // use context draw two image horizontal
//        let context = UIGraphicsGetCurrentContext()
//        context?.draw(mars.cgImage!, in: CGRect.init(origin: CGPoint.zero, size: size))
//        context?.draw(mars.cgImage!, in: CGRect.init(origin: CGPoint.init(x: size.width, y: 0), size: size))
        
        // draw two image in horizontal
//        mars.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
//        mars.draw(in: CGRect.init(origin: CGPoint.init(x: size.width, y: 0), size: size))
        
        // draw one image center in another image
//        let curRect = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: size.width * 2, height: size.height * 2))
//        mars.draw(in:curRect)
//        mars.draw(in: CGRect.init(origin: CGPoint.init(x: curRect.midX - size.width/2, y: curRect.midY - size.height/2), size: size))
        // also can use blendMode
//       // mars.draw(in: CGRect.init(origin: CGPoint.init(x: curRect.midX - size.width/2, y: curRect.midY - size.height/2), size: size), blendMode: CGBlendMode.overlay, alpha: 1.0)
        
        // draw right half image
//        mars.draw(in: CGRect.init(x: -size.width/2, y: size.height/2, width: size.width, height: size.height))
        
        // draw half image
        let marsCG = mars.cgImage
        let marsSize = mars.size
        let marsLeft = marsCG?.cropping(to: CGRect.init(x: 0, y: 0, width: marsSize.width/2, height: marsSize.height))
        let marsRight = marsCG?.cropping(to: CGRect.init(x: marsSize.width/2, y: 0, width: marsSize.width/2, height: marsSize.height))
        UIImage.init(cgImage: marsLeft!).draw(in: CGRect.init(x: size.width/3, y: size.height/2, width: size.width/2, height: size.height))
        UIImage.init(cgImage: marsRight!).draw(in: CGRect.init(x: 2*size.width/3 + size.width/2, y: size.height/2, width: size.width/2, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView2 = UIImageView.init(image: image)
        imageView2.backgroundColor = UIColor.lightGray
        self.view.addSubview(imageView2)
    }
    
    func snapShot() {
        // snapshot all and overlay, the snapshot same as the view
//        let snapShowView = self.view.snapshotView(afterScreenUpdates: false)
        // snap the rect
        let snapShowView = self.view.resizableSnapshotView(from: CGRect.init(x: 10, y: 200, width: 300, height: 300), afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
        self.view.addSubview(snapShowView!)
        
//        UIGraphicsBeginImageContext(view.bounds.size)
//        // drawHierarchy faster than CALayer method render(in:)
////        let snapshotFinished = self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
////        print("snapshot finished:", snapshotFinished ? "Yes" : "No")
//        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        let subview = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
//        subview.image = image
////        subview.backgroundColor = UIColor.blue // image override color
//
//        self.view.addSubview(subview)
    }
    
    func cifilter() {
        let moi = UIImage.init(named:"img2")!
        let moici = CIImage.init(image: moi)!
        let moiextent = moici.extent
        let center = CIVector(x: moiextent.width/2.0, y: moiextent.height/2.0)
        let smallerDimension = min(moiextent.width, moiextent.height)
        let largerDimension = max(moiextent.width, moiextent.height)
        // first filter
        let grad = CIFilter(name: "CIRadialGradient")!
        grad.setValue(center, forKey:"inputCenter")
        grad.setValue(smallerDimension/2.0 * 0.85, forKey:"inputRadius0")
        grad.setValue(largerDimension/2.0, forKey:"inputRadius1")
        let gradimage = grad.outputImage!
        // second filter
        let blendimage = moici.applyingFilter(
            "CIBlendWithMask", parameters: [
                "inputMaskImage":gradimage
            ])
        
        UIGraphicsBeginImageContextWithOptions(moiextent.size, false, 0)
        UIImage.init(ciImage: blendimage).draw(in: moiextent)
        let im = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.imageView.image = im
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        let image = imageView.image
//        let marsTiled = image?.resizableImage(
//            withCapInsets: UIEdgeInsets.zero, resizingMode: .tile)
//        let marsTiled = image?.resizableImage(
//            withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        
        let edgeInsets = UIEdgeInsetsMake(
            (image?.size.height)!/4.0,
            (image?.size.width)!/4.0,
            (image?.size.height)!/4.0,
            (image?.size.width)!/4.0)
        let marsTiled = image?.resizableImage(
            withCapInsets: edgeInsets, resizingMode: .tile)
        imageView.image = marsTiled
        
//        snapShot()
        
//        cifilter()
        
        // use subclass of cifilter
        let vig = VignetterFilter.init()
        let moici = CIImage.init(image: UIImage.init(named: "img2")!)!
        vig.inputImage = moici
        vig.inputPercentage = 0.7
        let outim = vig.outputImage!
        let outimcg = CIContext.init().createCGImage(outim, from: outim.extent)
        self.imageView.image = UIImage.init(cgImage: outimcg!)
    }
}

