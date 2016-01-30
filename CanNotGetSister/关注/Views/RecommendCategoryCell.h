//
//  RecommendCategoryCell.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendType;
/// 推荐关注分类 Cell
@interface RecommendCategoryCell : UITableViewCell
@property (nonatomic, strong) RecommendType *category;
@end
