//
//  AppDelegate.m
//  MTA-Demo
//
//  Created by WQY on 12-12-10.
//  Copyright (c) 2012年 developer. All rights reserved.
//

#import "AppDelegate.h"

#import "MTA.h"
#import "MTAConfig.h"

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
	UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];

	self.tabBarController = [[UITabBarController alloc] init];
	self.window.rootViewController = self.tabBarController;
	[self.window makeKeyAndVisible];
	[self.tabBarController setViewControllers:@[viewController1, viewController2] animated:NO];


	[[MTAConfig getInstance] setSmartReporting:YES];
	[[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_INSTANT];

	[[MTAConfig getInstance] setDebugEnable:YES];

	[MTA startWithAppkey:@"I2E3KXDU1E2W"];

	//用户分群自定义属性
	//    [MTA setUserProperty:@{@"key1":@"value1",@"key2":@"value2"}];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// 统计应用时长,结束时打点
	[MTA trackActiveEnd];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// 统计应用时长,开始时打点
	[MTA trackActiveBegin];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {


	// 原有代码
	return NO;
}

@end
