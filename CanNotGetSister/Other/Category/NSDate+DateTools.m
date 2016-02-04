//
//  NSDate+DateTools.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/3.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "NSDate+DateTools.h"

@implementation NSDate (DateTools)

- (NSDateComponents *)deltaFrom:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |
                                    NSCalendarUnitMonth | NSCalendarUnitDay |
                                    NSCalendarUnitHour | NSCalendarUnitMinute |
                                    NSCalendarUnitSecond
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components;

}

- (BOOL)isThisYear {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:now];
    NSInteger createYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == createYear;
}

- (BOOL)isToday {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowCom = [calendar components:unit fromDate:now];
    NSDateComponents *createCom = [calendar components:unit fromDate:self];
    return createCom.year == nowCom.year &&
           createCom.month == nowCom.month &&
           createCom.day == nowCom.day;
}

- (BOOL)isYesterday {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:now]];
    NSDate *createDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:self]];
    NSDateComponents *coms = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:createDate toDate:nowDate options:0];
    return coms.year == 0 && coms.month == 0 && coms.day == 1;
}


@end
