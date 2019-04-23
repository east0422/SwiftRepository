//
//  ViewController.swift
//  04Animation
//
//  Created by dfang on 2019-4-1.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testImageAnimation()
    }
    
    @IBAction func stopAnimationClicked(_ sender: UIButton) {
        // the “animation movie” is whipped away instantly, “jumping” the view to its final position
//        self.imageView.layer.removeAllAnimations()
        
        self.imageView.layer.position = (self.imageView.layer.presentation()?.position)!
        self.imageView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.1) {
            self.imageView.center.y += 200
        }
    }
    
    // test UIImageView animationImages animation
    func testImageAnimation() {
//        let mars1 = UIImage.init(named: "mars1.png")!
//        let mars2 = UIImage.init(named: "mars2.png")!
//        UIGraphicsBeginImageContextWithOptions(mars1.size, false, 0)
//        let empty = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        let arr = [mars1, empty, mars2, empty, mars1]
//        imageView.animationImages = arr
//        imageView.animationDuration = 5
//        imageView.animationRepeatCount = 3  // default 0, repeat forever
//        imageView.startAnimating()
        
        // test another
//        var arr = [UIImage]()
//        let w : CGFloat = 18
//        for i in 0 ..< 6 {
//            UIGraphicsBeginImageContextWithOptions(CGSize.init(width: w, height: w), false, 0)
//            let con = UIGraphicsGetCurrentContext()!
//            con.setFillColor(UIColor.red.cgColor)
//            let ii = CGFloat(i)
//            con.addEllipse(in: CGRect.init(x: 0 + ii, y: 0 + ii, width: w - ii * 2, height: w - ii * 2))
//            con.fillPath()
//            let im = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            arr.append(im!)
//        }
//
//        imageView.image = UIImage.animatedImage(with: arr, duration:0.5)
        
        
        // the imageView jumps to its new position and then view slowly turns red
//        UIView.animate(withDuration: 2.0) {
//            self.view.backgroundColor = UIColor.red
////            self.imageView.center.y += 200
//            UIView.performWithoutAnimation {
//                self.imageView.center.y += 100
//            }
//        }
        
        // the animation will run from start to finish (in the given duration time), and will then run from finish to start(also in the given duration time)
//        let origX = self.view.center.x
//        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.autoreverse, animations: {
//            self.view.center.x += 100
//        }) { (Bool) in
//            self.view.center.x = origX
//        }
        
    
//        UIView.animate(withDuration: 2) {
//            self.view.center.x += 100
//        }
//        sleep(1)
//        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
//             self.view.center.y += 100
//        }, completion: nil)
        
        
        // start animation and stop when click stop button
        UIView.animate(withDuration: 5) {
            self.imageView.center.y += 200
        }
    }
}

