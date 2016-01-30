//
//  RecommendUser.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendUser : NSObject
/*
 "uid": "8918517",
 "screen_name": "泡面来了",
 "introduction": "",
 "fans_count": "9021",
 "tiezi_count": 17,
 "header": "http:%/%/img.spriteapp.cn%/profile%/large%/2014%/10%/22%/544712a631641_mini.jpg",
 "gender": 2,
 "is_follow": 0
 */
/// 用户 id
@property (nonatomic, copy) NSString *uid;
/// 用户名
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *fans_count;
@property (nonatomic, copy) NSString *tiezi_count;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, strong) NSNumber *is_follow;

@end
