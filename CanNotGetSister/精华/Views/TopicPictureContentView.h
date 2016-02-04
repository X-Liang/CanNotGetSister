//
//  TopicPictureContentView.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/4.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicModel;

/// 图片帖子中间的图片内容
@interface TopicPictureContentView : UIView
@property (nonatomic, strong) TopicModel *topic;

+ (instancetype)pictureView;

@end
