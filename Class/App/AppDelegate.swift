//
//  AppDelegate.swift
//  ModengWallet
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        // 集成友盟
        let umConfig = UMAnalyticsConfig()
        umConfig.appKey = "5a8902a3f29d980406000816"
        umConfig.channelId = "App Store"
        MobClick.start(withConfigure: umConfig)
        
        // 小米推送
        MiPushSDK.registerMiPush(self)
        
        // 检查用户登录状态
        checkLoginStatus()
        
        // 加载页面
        let tabbarVC = LGTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbarVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func checkLoginStatus() {
        LGUserService.sharedService.checkLogin { isLogin, error in
            if error == nil {
                if !isLogin! {
                    // 登录过期
                    LGUserModel.currentUser.logout()
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(kNotificationLoginExpired)
                    }
                }
            } else {
                LGUserModel.currentUser.logout()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(kNotificationLogout)
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MiPushSDK.bindDeviceToken(deviceToken)
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
        
        // 检查用户登录状态
        checkLoginStatus()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: MiPushSDKDelegate, UNUserNotificationCenterDelegate {
    
}
