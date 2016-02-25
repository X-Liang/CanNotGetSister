//
//  DeleteBackTextField.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteBackTextField : UITextField
@property (nonatomic, copy) void(^deleteBlock)();
@end
