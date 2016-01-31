//
//  RecommendTag.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/30.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendTag : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
