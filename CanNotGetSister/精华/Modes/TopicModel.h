//
//  TopicModel.h
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/2.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject
/** 发帖人的昵称 */
@property (copy, nonatomic) NSString *name;
/** 头像的图片url地址 */
@property (copy, nonatomic) NSString *profile_image;
/** 系统审核通过后创建帖子的时间 */
@property (copy, nonatomic) NSString *created_at;
/** 帖子的内容 */
@property (copy, nonatomic) NSString *text;
/** 踩的人数 */
@property (assign, nonatomic) int hate;
/** 踩的人数 */
@property (assign, nonatomic) int cai;
/** 顶的数量*/
@property (assign, nonatomic) int ding;
/** 帖子的被评论数量 */
@property (assign, nonatomic) int comment;
/** 转发的数量 */
@property (assign, nonatomic) int repost;
/** 新浪 V 认证*/
@property (nonatomic, assign, getter=isSinaV) BOOL sina_v;
@property (nonatomic, assign) TopicType type;
/** 图片内容的地址*/
// 小图
@property (nonatomic, copy) NSString *small_image;
// 大图
@property (nonatomic, copy) NSString *large_image;
// 中图
@property (nonatomic, copy) NSString *middle_image;
/** 图片宽度*/
@property (nonatomic, assign) CGFloat width;
/** 图片高度*/
@property (nonatomic, assign) CGFloat height;
/** 图片内容空间的 frame*/
@property (nonatomic, assign, readonly) CGRect pictureContentFrame;
/** 图片是否超出最大高度*/
@property (nonatomic, assign) BOOL overHeight;
/** 模型对应的 Cell 高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
