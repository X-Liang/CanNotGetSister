//
//  GoTopWindow.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/10.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "GoTopWindow.h"

@implementation GoTopWindow

static UIWindow *window = nil;
+ (void)initialize {
    window = [[UIWindow alloc] init];
    window.frame = CGRectMake(0, 0, ScreenWidth, 20);
    window.windowLevel = UIWindowLevelAlert;
    [window addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWindow)]];
}

+ (void)show {
    window.hidden = NO;
}

+ (void)hidden {
    window.hidden = YES;
}

+ (void)clickWindow {
    
}

+ (void)searchScrollViewInView:(UIView *)superView {
    [superView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGRect newFrame = [subView.superview convertRect:subView.frame toView:[UIApplication sharedApplication].keyWindow];
//        // 子视图不隐藏, alpha>0.01 , 在 keyWindow 坐标系下与 keyWindow 相交
//        BOOL isShowingInCurrentWindow = subView.window == [UIApplication sharedApplication].keyWindow && !subView.hidden && subView.alpha > 0.01 && CGRectIntersectsRect([UIApplication sharedApplication].keyWindow.bounds, newFrame);
        if ([subView isKindOfClass:[UIScrollView class]] && [subView isShowingInKeyWindow]) {
            UIScrollView *sbView = (UIScrollView *)subView;
            CGPoint offset = sbView.contentOffset;
            offset.y = -sbView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
    }];
}

@end
