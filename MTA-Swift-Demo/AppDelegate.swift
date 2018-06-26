//
//  AppDelegate.swift
//  MTA-Swift-Demo
//
//  Created by tyzual on 2018/6/20.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	var tabBarController: UITabBarController?
	


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.tabBarController = UITabBarController.init()
		self.window?.rootViewController = self.tabBarController
		self.window?.makeKeyAndVisible()
		self.tabBarController?.setViewControllers([FirstViewController(nibName: "FirstViewController", bundle: nil),
												   SecondViewController(nibName: "SecondViewController", bundle: nil)], animated: true)
		
		
		MTAConfig.getInstance().debugEnable = true
		MTA.start(withAppkey: "I2E3KXDU1E2W")
		
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
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		// 可视化埋点代码
		// 若不使用可视化埋点功能
		// 可不添加这行代码
		if MTAAutoTrack.handle(url) {
			return true
		}

		// 原有代码
		return false
	}


}

