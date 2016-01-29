//
//  RootTabBarController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "RootTabBarController.h"
#import "EssenceViewController.h"
#import "NewViewController.h"
#import "FriendTrendsViewController.h"
#import "MineViewController.h"
#import "CustomTabBar.h"
#import "CustomNavigationController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self childViewController:[[EssenceViewController alloc] init]
                        title:@"精华"
                itemImageName:@"tabBar_essence_icon"
        itemSelectedImageName:@"tabBar_essence_click_icon"];
    
    [self childViewController:[[NewViewController alloc] init]
                        title:@"新贴"
                itemImageName:@"tabBar_new_icon"
        itemSelectedImageName:@"tabBar_new_click_icon"];
    
    [self childViewController:[[FriendTrendsViewController alloc] init]
                        title:@"关注"
                itemImageName:@"tabBar_friendTrends_icon"
        itemSelectedImageName:@"tabBar_friendTrends_click_icon"];
    
    [self childViewController:[[MineViewController alloc] init]
                        title:@"我"
                itemImageName:@"tabBar_me_icon"
        itemSelectedImageName:@"tabBar_me_click_icon"];
    
    [self setValue:[[CustomTabBar alloc] init] forKey:@"tabBar"];
    
}

/// 初始化子控制器
- (void)childViewController:(UIViewController *)viewController
                      title:(NSString *)title
                        itemImageName:(NSString *)imageName
                itemSelectedImageName:(NSString *)selectedImageName {
    // 添加导航控制器, 将导航控制器作为tabBar 子控制器
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:viewController];
    
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    [self addChildViewController:nav];
}

@end
