//
//  TopicCell.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/3.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicModel;
/// 段子 Cell
@interface TopicCell : UITableViewCell
@property (nonatomic, strong) TopicModel *topic;
+ (instancetype)topicCell;
@end
