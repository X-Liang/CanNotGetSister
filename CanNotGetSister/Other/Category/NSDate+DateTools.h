//
//  NSDate+DateTools.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/3.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateTools)

/// 比较 date 和 self 的时间差值
- (NSDateComponents *)deltaFrom:(NSDate *)date;

/// 是否是今年
- (BOOL)isThisYear;

/// 是否是今天
- (BOOL)isToday;

/// 是否是昨天
- (BOOL)isYesterday;

@end
