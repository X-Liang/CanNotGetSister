//
//  Comment.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/6.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "Comment.h"
#import <MJExtension.h>
@implementation Comment

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end
