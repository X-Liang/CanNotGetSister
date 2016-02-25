//
//  User.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/6.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/// 用户名
@property (nonatomic, copy) NSString *username;
/// 性别
@property (nonatomic, copy) NSString *sex;
/// 头像
@property (nonatomic, copy) NSString *profile_image;
@end
