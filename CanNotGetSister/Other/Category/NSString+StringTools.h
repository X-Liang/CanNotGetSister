//
//  NSString+StringTools.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/3.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringTools)

+ (instancetype)formatterStringByCount:(NSInteger)count placeHolder:(NSString *)placeHolder;

+ (NSString *)convenienceTimeStrByDate:(NSString *)dateStr;
@end
