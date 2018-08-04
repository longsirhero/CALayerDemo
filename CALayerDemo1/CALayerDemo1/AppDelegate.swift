//
//  AppDelegate.swift
//  CALayerDemo1
//
//  Created by WingChing Yip on 2018/8/4.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        // 1、绘制方式一：
        window?.rootViewController = ViewController()
        // 2、绘制方式二
//        window?.rootViewController = NextViewController()
        
        return true
    }

}

