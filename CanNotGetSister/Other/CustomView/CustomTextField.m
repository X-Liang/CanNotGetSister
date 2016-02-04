//
//  CustomTextField.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/1.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "CustomTextField.h"
#import <objc/runtime.h>

static NSString *TextFieldPlaceHolderLabelTextColor = @"placeholderLabel.textColor";

@implementation CustomTextField

+ (void)initialize {
    [self getAllProperties];
}

/// 获得所有成员变量
+ (void)getAllIVar {
    unsigned int count = 0;
    // 拷贝所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (NSInteger index = 0; index < count; index++) {
        // 取出成员变量
        Ivar ivar = ivars[index];
        // 打印成员变量名称
        NSLog(@"%s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    // 释放
    free(ivars);
}

/// 获得所有属性
+ (void)getAllProperties {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    for (NSInteger index = 0; index < count; index++) {
        // 取出成员变量
        objc_property_t property = properties[index];
        // 打印属性名称,类型
        NSLog(@"%s %s",property_getName(property), property_getAttributes(property));
    }
    // 释放
    free(properties);
}

- (void)awakeFromNib {
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:TextFieldPlaceHolderLabelTextColor];
    // 光标颜色与文字颜色一致
    self.tintColor = self.textColor;
}

// 成为第一响应者会调用
- (BOOL)becomeFirstResponder {
    [self setValue:self.textColor forKeyPath:TextFieldPlaceHolderLabelTextColor];
    return [super becomeFirstResponder];
}

// 取消第一相应者会调用
- (BOOL)resignFirstResponder {
    [self setValue:[UIColor grayColor] forKeyPath:TextFieldPlaceHolderLabelTextColor];

    return [super resignFirstResponder];
}

// 光标聚焦时, 会调用该方法
//- (void)setHighlighted:(BOOL)highlighted {
//    [self setValue:self.textColor forKeyPath:@"placeholderLabel.textColor"];
//}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    [self setValue:placeHolderColor forKeyPath:TextFieldPlaceHolderLabelTextColor];
}

@end
