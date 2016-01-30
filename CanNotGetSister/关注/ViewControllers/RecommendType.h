//
//  RecommendType.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 推荐关注的 Model
@interface RecommendType : NSObject

/// id
@property (nonatomic, copy) NSString *id;
/// 名称
@property (nonatomic, copy) NSString *name;
/// 数量
@property (nonatomic, copy) NSString *count;

/// 这个类别对应的用户信息
@property (nonatomic, strong) NSMutableArray *uses;
/// 总页数
@property (nonatomic, assign) NSUInteger total;
/// 当前页码
@property (nonatomic, assign) NSUInteger currentPage;
@end
