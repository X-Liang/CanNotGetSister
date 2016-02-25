//
//  PlaceholderTextView.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 拥有占位文字的 TextView, 通过 DrawRect 方法实现
@interface PlaceholderTextViewDrawRect : UITextView
/// 占位文字
@property (nonatomic, copy) NSString *placeholder;
/// 占位文字颜色
@property (nonatomic, strong) UIColor *placeholderTextColor;

@end
