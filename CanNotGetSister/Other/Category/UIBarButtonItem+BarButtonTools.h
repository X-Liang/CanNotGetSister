//
//  UIBarButtonItem+BarButtonTools.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarButtonTools)

+ (instancetype)itemWithImageName:(NSString *)imageName
               highlightImageName:(NSString *)highlightImageName
                           target:(id)target
                           action:(SEL)action;
@end
