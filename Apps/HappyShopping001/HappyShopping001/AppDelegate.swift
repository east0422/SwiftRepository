//
//  AppDelegate.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import SWRevealViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        // 抽屉效果
//        let leftVC = UINavigationController.init(rootViewController: LeftViewController.init())
//        let centerVC = UINavigationController.init(rootViewController: CenterViewController.init())
//        let rightVC = UINavigationController.init(rootViewController: RightViewController.init())
//
//        let rootVC = SWRevealViewController.init(rearViewController: leftVC, frontViewController: centerVC)
//        rootVC?.rightViewController = rightVC
//        rootVC?.setFrontViewPosition(FrontViewPosition.left, animated: true)
        
        // 登录视图
        let loginVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginStoryboardId")
        // 已登录进入主根视图，未登录就进入登录视图
        let rootVC =  (UserInfoModel.fetchUserInfo() != nil) ? RootViewController() : UINavigationController.init(rootViewController: loginVC)

        self.window = UIWindow.init(frame: SCREEN_BOUNDS)
        // 设置背景色
        self.window?.backgroundColor = BGCOLOR
        // 设置根视图
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        
        return true
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

