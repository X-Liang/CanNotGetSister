//
//  TopicModel.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/2.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "TopicModel.h"
#import "Comment.h"
#import "User.h"
#import <MJExtension.h>

@implementation TopicModel
@synthesize cellHeight = _cellHeight;

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt": @"Comment"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image": @"image2",
             @"ID"          : @"id",
             @"top_cmt"     : @"top_cmt[0]"
             };
}

- (NSString *)created_at {
    return [NSString convenienceTimeStrByDate:_created_at];
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * TopicCellMargin, MAXFLOAT);
        CGFloat textHeight = [self.text boundingRectWithSize:maxSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                                     context:nil].size.height;
        // 根据帖子类型计算 Cell 高度
        _cellHeight = TopicCellTextContentMinY + textHeight + TopicCellMargin;
        
        if (self.type == TopicTypePicture) {        // 图片
            // 图片显示的宽高
            CGFloat imageWidth = maxSize.width;
            CGFloat imageHeight = imageWidth * self.height / self.width;
            if (imageHeight > TopicCellPictureMaxHeight) {
                imageHeight = TopicCellPictureDefaultHeight;
                self.overHeight = YES;
            }
            _pictureContentFrame = CGRectMake(TopicCellMargin, _cellHeight, imageWidth, imageHeight-5);
            _cellHeight += imageHeight;
        } else if (self.type == TopicTypeVoice) {   // 声音
            // 图片显示的宽高
            CGFloat imageWidth = maxSize.width;
            CGFloat imageHeight = imageWidth * self.height / self.width;
            _voiceContentFrame = CGRectMake(TopicCellMargin, _cellHeight, imageWidth, imageHeight - 5);
            _cellHeight += imageHeight;
        } else if (self.type == TopicTypeVideo) {   // 视频
            // 图片显示的宽高
            CGFloat imageWidth = maxSize.width;
            CGFloat imageHeight = imageWidth * self.height / self.width;
            _videoContentFrame = CGRectMake(TopicCellMargin, _cellHeight, imageWidth, imageHeight - 5);
            _cellHeight += imageHeight;
        }
        
        Comment *comment = self.top_cmt;
        if (comment) {
            _cellHeight += (8 + 15 + 8);
            NSString *commentContent = [NSString stringWithFormat:@"%@ : %@",comment.user.username, comment.content];
            _cellHeight += [commentContent boundingRectWithSize:maxSize
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}
                                                        context:nil].size.height;
            _cellHeight += 8;
        }
        
        _cellHeight += TopicCellMargin + TopicCellBottomBarHeight;

    }
    return _cellHeight;
}

- (void)clearCellHeight {
    _cellHeight = 0;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
}

@end
