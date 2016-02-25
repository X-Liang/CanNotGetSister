//
//  DeleteBackTextField.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "DeleteBackTextField.h"

@implementation DeleteBackTextField

- (void)deleteBackward {
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}

@end
