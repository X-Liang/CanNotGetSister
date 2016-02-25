//
//  TopicVoideContentView.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/6.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicModel;
@interface TopicVideoContentView : UIView
@property (nonatomic, strong) TopicModel *topic;
+ (instancetype)voideView;
@end
