//
//  CustomTabBar.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "CustomTabBar.h"
#import "PublishViewController.h"
#import "PublishView.h"

#import "XLStatusBarHUD.h"

@interface CustomTabBar ()
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        /// 设置背景图片
        self.backgroundImage = [UIImage imageNamed:@""];
        [self createPublishButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置发布按钮的 frame
    self.publishButton.center = CGPointMake(self.bounds.size.width * .5, self.bounds.size.height * .5f);
    // 设置其他 UITabBarItem 的 frame
    CGFloat itemHeight = self.bounds.size.height;
    CGFloat itemWidth = self.bounds.size.width * .2;
    CGFloat itemY = 0;
    __block NSUInteger index = 0;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            subView.frame = CGRectMake(itemWidth * index++, itemY, itemWidth, itemHeight);
        }
        if (index == 2) {
            index++;
        }
    }];
}

- (void)createPublishButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
    button.bounds = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:self action:@selector(showPublishVC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.publishButton = button;
}

- (void)showPublishVC:(UIButton *)btn {
    // 方法一: 通过弹出模态视图
    [self method_1];
    
    // 方法二: 通过添加子视图
//    [self method_2];
    
//    [XLStatusBarHUD showLoading];
}

- (void)method_1 {
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

- (void)method_2 {
    [PublishView show];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    publicView.frame = window.bounds;
//    [window addSubview:publicView];
}

@end
