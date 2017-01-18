//
//  AppDelegate.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/2.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let indexVC = IndexViewController(nibName: "IndexViewController", bundle: nil)
        let channelVC = IndexViewController(nibName: "ChannelViewController", bundle: nil)
        let watchVC = IndexViewController(nibName: "WatchViewController", bundle: nil)
        let mineVC = IndexViewController(nibName: "MineViewController", bundle: nil)
        
        indexVC.title = "首页"
        channelVC.title = "频道"
        watchVC.title = "关注"
        mineVC.title = "我的"
        
        indexVC.tabBarItem = UITabBarItem(title: "首页", image: #imageLiteral(resourceName: "tab_bar_icon_one_normal"), selectedImage: #imageLiteral(resourceName: "tab_bar_icon_one_selected"))
        
        channelVC.tabBarItem = UITabBarItem(title: "频道", image: #imageLiteral(resourceName: "tab_bar_icon_two_normal"), selectedImage: #imageLiteral(resourceName: "tab_bar_icon_two_selected"))
        
        watchVC.tabBarItem = UITabBarItem(title: "关注", image: #imageLiteral(resourceName: "tab_bar_icon_three_normal"), selectedImage: #imageLiteral(resourceName: "tab_bar_icon_three_selected"))
        
        mineVC.tabBarItem = UITabBarItem(title: "我的", image: #imageLiteral(resourceName: "tab_bar_icon_four_normal"), selectedImage: #imageLiteral(resourceName: "tab_bar_icon_four_selected"))
        
        let mainTabBar = UITabBarController()
        
        mainTabBar.tabBar.tintColor = UIColor(colorLiteralRed: 193/255, green: 60/255, blue: 73/255, alpha: 1)
        
        mainTabBar.viewControllers = [indexVC,channelVC,watchVC,mineVC]
        window?.rootViewController = mainTabBar
        
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

