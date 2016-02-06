//
//  XLStatusBarHUD.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLStatusBarHUD : NSObject
+ (void)showMessage:(NSString *)msg image:(UIImage *)image;
+ (void)showMessage:(NSString *)msg;
+ (void)showSuccess:(NSString *)msg;
+ (void)showError:(NSString *)msg;
+ (void)showLoading;
+ (void)hide;

@end
