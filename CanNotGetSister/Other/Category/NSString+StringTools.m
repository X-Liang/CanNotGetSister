//
//  NSString+StringTools.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/3.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "NSString+StringTools.h"
#import "NSDate+DateTools.h"

@implementation NSString (StringTools)

+ (instancetype)formatterStringByCount:(NSInteger)count placeHolder:(NSString *)placeHolder{
    NSString *ding = nil;
    
    if (count == 0) {
        return placeHolder;
    }
    
    if (count > 10000) {
        ding = [NSString stringWithFormat:@"%.1f万",count/10000.f];
    } else {
        ding = [NSString stringWithFormat:@"%zd",count];
    }
    return ding;
}

/**
 * 将 yyyy-MM-dd HH:mm:ss 类型的 dateStr, 与当前时间比较, 产生时间差的字符串
 */
+ (NSString *)convenienceTimeStrByDate:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [dateFormatter dateFromString:dateStr];
    return [self compareDate:createDate];
}

+ (NSString *)compareDate:(NSDate *)createDate {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 今年----------
    if ([createDate isThisYear]) {
        // 今天
        if ([createDate isToday]) {
            NSDateComponents *comps = [now deltaFrom:createDate];
            if (comps.hour >= 1 ) { // >= 1小时 -> hh 小时前
                return [NSString stringWithFormat:@"%zd 小时前",comps.hour];
            } else if (comps.minute >= 1) { // 1小时内 -> mm 分钟前
                return [NSString stringWithFormat:@"%zd 分钟前",comps.minute];
            } else { // 1分钟内 -> 刚刚
                return @"刚刚";
            }
        } else if ([createDate isYesterday]) {  // 昨天
            dateFormatter.dateFormat = @"昨天 HH:mm:ss";
        } else { // 其他
            dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
        }
    }
    // 不是今年-------
    // 显示 yyyy-MM-dd HH:mm:ss
    return [dateFormatter stringFromDate:createDate];
}

- (void)getYMD {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获得某个 date 的年
    [calendar component:NSCalendarUnitYear fromDate:now];
    // 获得某个 date 的月
    [calendar component:NSCalendarUnitMonth fromDate:now];
    // 获得某个 date 的日
    [calendar component:NSCalendarUnitDay fromDate:now];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    NSLog(@"%zd %zd %zd", components.year, components.month, components.day);
}

@end
