//
//  GuideView.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/1.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "GuideView.h"

@implementation GuideView

+ (instancetype)guideView {
    return [self viewFromXib];
}

+ (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *loadVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    // 本地与当前版本号不同, 显示引导
    if (![currentVersion isEqualToString:loadVersion]) {
        GuideView *guideView = [GuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (IBAction)close:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
