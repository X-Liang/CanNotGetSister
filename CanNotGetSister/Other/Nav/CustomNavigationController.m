//
//  CustomNavigationController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

+ (void)initialize {
    // 设置 NavBar 的背景图片
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *backItemButton = [self createBackButton];
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItemButton];
        // 隐藏底部的 tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句 super 要放在后面, 让 ViewController 可以在 viewDidLoad 中覆盖上面创建的 leftItem
    [super pushViewController:viewController animated:animated];
}

- (void)back:(UIButton *)button {
    [self popViewControllerAnimated:YES];
}

- (UIButton *)createBackButton {
    UIButton *backItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backItemButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backItemButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [backItemButton setTitle:@"返回" forState: UIControlStateNormal];
    [backItemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backItemButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backItemButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backItemButton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [backItemButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    //        [backItemButton sizeToFit];
    return backItemButton;
}

@end
