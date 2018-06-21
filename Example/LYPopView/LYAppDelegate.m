//
//  LYAppDelegate.m
//  LYPopView
//
//  Created by LUO YU on 12/19/2016.
//  Copyright (c) 2016 LUO YU. All rights reserved.
//

#import "LYAppDelegate.h"
#import "TabBaseViewController.h"
#import "TabMsgViewController.h"
#import "TabTableViewController.h"
#import "TabPickerViewController.h"
#import "TabOtherViewController.h"
#import <ConfigKit/ConfigKit.h>

@implementation LYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	UITabBarController *tabs = [[UITabBarController alloc] init];
	
	UINavigationController *navBase = [[UINavigationController alloc] initWithRootViewController:[[TabBaseViewController alloc] init]];
	navBase.title = @"basic pop";
	navBase.tabBarItem.image = [UIImage imageNamed:@"tab-ico-basic"];
	
	UINavigationController *navMsg = [[UINavigationController alloc] initWithRootViewController:[[TabMsgViewController alloc] init]];
	navMsg.tabBarItem.title = @"msg pop";
	navMsg.tabBarItem.image = [UIImage imageNamed:@"tab-ico-msg"];
	
	UINavigationController *navDate = [[UINavigationController alloc] initWithRootViewController:[[TabPickerViewController alloc] init]];
	navDate.tabBarItem.title = @"picker";
	navDate.tabBarItem.image = [UIImage imageNamed:@"tab-ico-date"];
	
	UINavigationController *navTable = [[UINavigationController alloc] initWithRootViewController:[[TabTableViewController alloc] init]];
	navTable.tabBarItem.title = @"table pop";
	navTable.tabBarItem.image = [UIImage imageNamed:@"tab-ico-list"];
	
	UINavigationController *navPicker = [[UINavigationController alloc] initWithRootViewController:[[TabOtherViewController alloc] init]];
	navPicker.tabBarItem.title = @"other";
	navPicker.tabBarItem.image = [UIImage imageNamed:@"tab-ico-picker"];
	
	tabs.viewControllers = @[navBase, navMsg, navDate, navTable, navPicker,];
	
	_window.rootViewController = tabs;
	
	[_window makeKeyAndVisible];
	
	[[ConfigKit kit] systemStyle];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
