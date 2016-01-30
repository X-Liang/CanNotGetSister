//
//  RecommendType.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "RecommendType.h"

@implementation RecommendType

- (NSMutableArray *)uses {
    if (!_uses) {
        _uses = [NSMutableArray array];
    }
    return _uses;
}

@end
