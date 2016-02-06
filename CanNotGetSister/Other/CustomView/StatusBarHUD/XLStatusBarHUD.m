//
//  XLStatusBarHUD.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "XLStatusBarHUD.h"
static NSUInteger Time = 2;

@implementation XLStatusBarHUD
/// 全局窗口
static UIWindow *window = nil;
static NSTimer *timer = nil;
+ (UIWindow *)window {
    if (!window) {
        window = [[UIWindow alloc] init];
        window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
        window.hidden = NO;
        window.windowLevel = UIWindowLevelAlert;
    }
    return window;
}

+ (void)showMessage:(NSString *)msg image:(UIImage *)image {
    [timer invalidate];
    
    UIWindow *window = [self window];
    window.backgroundColor = [UIColor blackColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window.bounds;
    [btn setTitle:msg forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [window addSubview:btn];
    
    // 定时消失
    timer = [NSTimer scheduledTimerWithTimeInterval:Time
                                     target:self
                                   selector:@selector(hide)
                                   userInfo:nil
                                    repeats:NO];
}

+ (void)showMessage:(NSString *)msg {
    [timer invalidate];
    
    UIWindow *window = [self window];
    window.backgroundColor = [UIColor blackColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window.bounds;
    [btn setTitle:msg forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [window addSubview:btn];
    
    // 定时消失
    timer = [NSTimer scheduledTimerWithTimeInterval:Time
                                             target:self
                                           selector:@selector(hide)
                                           userInfo:nil
                                            repeats:NO];
}

+ (void)showSuccess:(NSString *)msg {
    [timer invalidate];

    UIWindow *window = [self window];
    window.backgroundColor = [UIColor blackColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window.bounds;
    [btn setTitle:msg forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [window addSubview:btn];
    
    // 定时消失
    timer = [NSTimer scheduledTimerWithTimeInterval:Time
                                             target:self
                                           selector:@selector(hide)
                                           userInfo:nil
                                            repeats:NO];
}

+ (void)showError:(NSString *)msg {
    [timer invalidate];

    UIWindow *window = [self window];
    window.backgroundColor = [UIColor redColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window.bounds;
    [btn setTitle:msg forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [window addSubview:btn];
    
    // 定时消失
    timer = [NSTimer scheduledTimerWithTimeInterval:Time
                                             target:self
                                           selector:@selector(hide)
                                           userInfo:nil
                                            repeats:NO];
}

+ (void)showLoading {
    UIWindow *window = [self window];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window.bounds;
    [btn setTitle:@"正在加载中..." forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [btn.titleLabel sizeToFit];
    CGSize titleSize = btn.titleLabel.bounds.size;
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityView startAnimating];
    CGPoint center = activityView.center;
    center.x = (window.bounds.size.width - titleSize.width) * .5f - 20;
    activityView.center = center;
    [window addSubview:btn];
    [window addSubview:activityView];
}

+ (void)hide {
    [self window].hidden = YES;
}
@end
