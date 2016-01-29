//
//  UIBarButtonItem+BarButtonTools.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "UIBarButtonItem+BarButtonTools.h"

@implementation UIBarButtonItem (BarButtonTools)

+ (instancetype)itemWithImageName:(NSString *)imageName
               highlightImageName:(NSString *)highlightImageName
                           target:(id)target
                           action:(SEL)action
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    leftButton.size = leftButton.currentImage.size;
    return [[self alloc] initWithCustomView:leftButton];
}

@end
