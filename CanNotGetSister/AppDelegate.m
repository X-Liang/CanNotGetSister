//
//  AppDelegate.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideView.h"
#import "RootTabBarController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RootTabBarController *rootTabBar = [[RootTabBarController alloc] init];
    self.window.rootViewController = rootTabBar;
    rootTabBar.delegate = self;
    [self.window makeKeyAndVisible];
    [GuideView show];
       
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:TabBarDidSelectedNotification object:nil userInfo:nil];
}

@end
