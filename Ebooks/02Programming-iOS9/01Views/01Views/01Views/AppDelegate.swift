//
//  AppDelegate.swift
//  01Views
//
//  Created by dfang on 2018-9-10.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // init window
        initWindow()
        
//        testSubViews()
//        testBoundsAndInset()
//        testTransform()
//        testResizing()
//        testConstraint()
//        testConstraintVFL()
//        testGuides()
        testStackView()
        return true
    }
    
    // add subview directly in window
    func initWindow() {
        // New in iOS 9, it’s sufficient to instantiate UIWindow with no frame; the screen’s bounds will be assigned to the window’s frame for you
        window = UIWindow()
//        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        // rootVC need
        let rootVC = UIViewController.init()
        rootVC.view.backgroundColor = UIColor.lightGray
        window?.rootViewController = rootVC
        
        // show the current window and position it in front
        window?.makeKeyAndVisible()
    
        // 将rootVC的视图放在最底层
//        window?.sendSubview(toBack: rootVC.view)
    }
    // add subview outside superview
    func testSubViews() {
        // test subview outside superview
        let v1 = UIView(frame: CGRect.init(x: 113, y: 111, width: 132, height: 194))
        v1.backgroundColor = UIColor.red
        let v2 = UIView(frame: CGRect.init(x: 41, y: 56, width: 132, height: 194))
        v2.backgroundColor = UIColor.green
        let v3 = UIView(frame: CGRect.init(x: 43, y: 197, width: 160, height: 230))
        v3.backgroundColor = UIColor.cyan
        window?.addSubview(v1)
        // v2 in v1, the frame is relative to v1
        v1.addSubview(v2)
        window?.addSubview(v3)
    }
    // test bounds and insetBy
    func testBoundsAndInset() {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 113, height: 111))
        v.backgroundColor = UIColor.cyan
        window?.addSubview(v)
        
        let v1 = UIView(frame: CGRect.init(x: 113, y: 111, width: 132, height: 194))
        v1.backgroundColor = UIColor.red
        // bounds relative to self, frame is relative to superview
        // insetBy origin value is offset (dx, dy),  size adjusted by (2*dx,2*dy) relative origin rectangle
        let v2 = UIView(frame: v1.bounds.insetBy(dx: 10, dy: 10))
        v2.backgroundColor = UIColor.green
        window?.addSubview(v1)
        v1.addSubview(v2)
    
        // v2 origin and size are changed
//        v2.bounds.size.height += 20
//        v2.bounds.size.width += 20
        // v1 origin changed, origin改变实质是是将左上角坐标点值改为新的坐标点值
        v1.bounds.origin.x += 10
//        v1.bounds.origin.y += 10
    }
    // test transform
    func testTransform() {
        let v1 = UIView(frame:CGRect.init(x: 113, y: 111, width: 132, height: 194))
        v1.backgroundColor = UIColor.yellow
        let v2 = UIView.init(frame:v1.bounds.insetBy(dx: 10, dy: 10))
        v2.backgroundColor = UIColor.green
        window?.addSubview(v1)
        v1.addSubview(v2)
        v1.transform = CGAffineTransform(rotationAngle: 45 * CGFloat(Float.pi)/180.0)
        print(v1.frame)
    }
    // test resizing, rotate device to demo
    func testResizing() {
        let v1 = UIView.init(frame: CGRect.init(x: 100, y: 111, width: 150, height: 194))
        v1.frame = (window?.bounds)!
        v1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v1.backgroundColor = UIColor.yellow
        let v2 = UIView(frame:CGRect.init(x: 0, y: 0, width: 100, height: 10))
        v2.backgroundColor = UIColor.green
        let v3 = UIView(frame:CGRect.init(x: v1.bounds.width - 80, y: v1.bounds.height - 80, width: 80, height: 80))
        v3.backgroundColor = UIColor.blue
        window?.addSubview(v1)
        v1.addSubview(v2)
        v1.addSubview(v3)
        v2.autoresizingMask = UIViewAutoresizing.flexibleWidth
        v3.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin,  UIViewAutoresizing.flexibleTopMargin]
        
        // delay 3 second to resize superview v1 if not rotate device
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//            v1.bounds.size.width += 50
//            v1.bounds.size.height -= 50
//        }
    }
    // test constraint
    func testConstraint() {
        let v1 = UIView(frame:CGRect.init(x: 100, y: 111, width: 132, height: 194))
        v1.backgroundColor = UIColor.green
        let v2 = UIView.init()
        v2.backgroundColor = UIColor.yellow
        let v3 = UIView()
        v3.backgroundColor = UIColor.blue
        window?.addSubview(v1)
        v1.addSubview(v2)
        v1.addSubview(v3)
        v2.translatesAutoresizingMaskIntoConstraints = false
        v3.translatesAutoresizingMaskIntoConstraints = false
        v1.addConstraint(
            NSLayoutConstraint(item: v2,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: v1,
                               attribute: .leading,
                               multiplier: 1, constant: 0)
        )
        v1.addConstraint(
            NSLayoutConstraint(item: v2,
                               attribute: NSLayoutAttribute.trailing,
                               relatedBy: .equal,
                               toItem: v1,
                               attribute: .trailing,
                               multiplier: 1, constant: 0)
        )
        v1.addConstraint(
            NSLayoutConstraint(item: v2,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: v1,
                               attribute: .top,
                               multiplier: 1, constant: 10)
        )
        v2.addConstraint(
            NSLayoutConstraint(item: v2,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1, constant: 10)
        )
        v3.addConstraint(
            NSLayoutConstraint(item: v3,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1, constant: 20)
        )
        v3.addConstraint(
            NSLayoutConstraint(item: v3,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1, constant: 20)
        )
        v1.addConstraint(
            NSLayoutConstraint(item: v3,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: v1,
                               attribute: .trailing,
                               multiplier: 1, constant: 0)
        )
        v1.addConstraint(
            NSLayoutConstraint(item: v3,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: v1,
                               attribute: .bottom,
                               multiplier: 1, constant: 0)
        )
    }
    // test constraint with VFL
    func testConstraintVFL() {
        let v1 = UIView()
        v1.backgroundColor = UIColor.green
        v1.translatesAutoresizingMaskIntoConstraints = false
        let v2 = UIView()
        v2.backgroundColor = UIColor.yellow
        v2.translatesAutoresizingMaskIntoConstraints = false
        let v3 = UIView()
        v3.backgroundColor = UIColor.blue
        v3.translatesAutoresizingMaskIntoConstraints = false
        window?.addSubview(v1)
        window?.addSubview(v2)
        window?.addSubview(v3)
        // construct constraints
        let c1 = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v":v1])
        let c2 = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v":v2])
        let c3 = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v":v3])
        let c4 = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(100)-[v(20)]", options: [], metrics: nil, views: ["v":v1])
        let c5with = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[v1]-(20)-[v2(20)]-(20)-[v3(20)]", options: [], metrics: nil,
            views: ["v1":v1, "v2":v2, "v3":v3])
        let c5without = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[v1]-(20)-[v3(20)]", options: [], metrics: nil,
            views: ["v1":v1, "v3":v3])
        
        var constraintsWith = [NSLayoutConstraint]()
        var constraintsWithout = [NSLayoutConstraint]()
        // first set of constraints
        constraintsWith.append(contentsOf: c1)
        constraintsWith.append(contentsOf: c2)
        constraintsWith.append(contentsOf: c3)
        constraintsWith.append(contentsOf: c4)
        constraintsWith.append(contentsOf: c5with)
        
        // second set of constraints
        constraintsWithout.append(contentsOf: c1)
        constraintsWithout.append(contentsOf: c3)
        constraintsWithout.append(contentsOf: c4)
        constraintsWithout.append(contentsOf: c5without)
        
        // apply first set
        NSLayoutConstraint.activate(constraintsWith)
        // delay execute
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { (timer) in
                if v2.superview != nil {
                    v2.removeFromSuperview()
                    NSLayoutConstraint.deactivate(constraintsWith)
                    NSLayoutConstraint.activate(constraintsWithout)
                } else {
                    self.window?.addSubview(v2)
                    NSLayoutConstraint.deactivate(constraintsWithout)
                    NSLayoutConstraint.activate(constraintsWith)
                }
            })
        }
    }
    // test guide and margin
    func testGuides() {
        let mainView = UIView.init(frame: (window?.frame)!)
        mainView.backgroundColor = UIColor.white
        window?.addSubview(mainView)
        
        let v1 = UIView()
        v1.backgroundColor = UIColor.green
        v1.translatesAutoresizingMaskIntoConstraints = false
        let v2 = UIView()
        v2.backgroundColor = UIColor.yellow
        v2.translatesAutoresizingMaskIntoConstraints = false
        let v3 = UIView()
        v3.backgroundColor = UIColor.blue
        v3.translatesAutoresizingMaskIntoConstraints = false
        let v4 = UIView()
        v4.backgroundColor = UIColor.brown
        v4.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(v1)
        mainView.addSubview(v2)
        mainView.addSubview(v3)
        mainView.addSubview(v4)
        let guides = [UILayoutGuide(), UILayoutGuide(), UILayoutGuide()]
        for guide in guides {
            mainView.addLayoutGuide(guide)
        }
        NSLayoutConstraint.activate([
            // view widths are equal
            v1.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            v2.widthAnchor.constraint(equalTo: v1.widthAnchor),
            v3.widthAnchor.constraint(equalTo: v1.widthAnchor),
            v4.widthAnchor.constraint(equalTo: v1.widthAnchor),
            // view heighs are equal
            v1.heightAnchor.constraint(equalToConstant: 50),
            v2.heightAnchor.constraint(equalTo: v1.heightAnchor),
            v3.heightAnchor.constraint(equalTo: v1.heightAnchor),
            v4.heightAnchor.constraint(equalTo: v1.heightAnchor),
            // guide heights are equal!
            guides[1].heightAnchor.constraint(equalTo: guides[0].heightAnchor),
            guides[2].heightAnchor.constraint(equalTo: guides[0].heightAnchor),
            // bottom of each view is top of following guide
            v1.bottomAnchor.constraint(equalTo: guides[0].topAnchor),
            v2.bottomAnchor.constraint(equalTo: guides[1].topAnchor),
            v3.bottomAnchor.constraint(equalTo: guides[2].topAnchor),
            // top of each view is bottom of preceding guide
            v2.topAnchor.constraint(equalTo: guides[0].bottomAnchor),
            v3.topAnchor.constraint(equalTo: guides[1].bottomAnchor),
            v4.topAnchor.constraint(equalTo: guides[2].bottomAnchor),
            // top view top and bottom view bottom
            v1.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 60),
            v4.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -60),
        ])
    }
    // test Stack Views
    func testStackView() {
        let mainView = UIView.init(frame: (window?.frame)!)
        mainView.backgroundColor = UIColor.white
        window?.addSubview(mainView)
        
        let v1 = UIView()
        v1.backgroundColor = UIColor.green
        v1.translatesAutoresizingMaskIntoConstraints = false
        let v2 = UIView()
        v2.backgroundColor = UIColor.yellow
        v2.translatesAutoresizingMaskIntoConstraints = false
        let v3 = UIView()
        v3.backgroundColor = UIColor.blue
        v3.translatesAutoresizingMaskIntoConstraints = false
        let v4 = UIView()
        v4.backgroundColor = UIColor.brown
        v4.translatesAutoresizingMaskIntoConstraints = false
        // give the stack view arranged subviews
        let sv = UIStackView(arrangedSubviews: [v1, v2, v3, v4])
        // configure the stack view
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 50
        // constrain the stack view
        sv.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(sv)
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo:mainView.safeAreaLayoutGuide.topAnchor),
            sv.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            sv.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            sv.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

