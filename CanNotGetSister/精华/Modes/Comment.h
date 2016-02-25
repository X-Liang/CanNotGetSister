//
//  Comment.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/6.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Comment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;

/// 用户
@property (nonatomic, strong) User *user;
@end
