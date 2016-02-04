//
//  TopicCell.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/3.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "TopicCell.h"
#import "TopicModel.h"

#import "TopicPictureContentView.h"

#import <UIImageView+WebCache.h>

@interface TopicCell ()
/// 头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/// 时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/// 顶
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/// 踩
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/// 分享
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/// 评论
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/// 新浪 V 认证
@property (weak, nonatomic) IBOutlet UIImageView *vImageView;
/// 文本内容 Label
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;

/// 图片帖子中间的内容
@property (nonatomic, weak) TopicPictureContentView *pictureView;
@end

@implementation TopicCell

- (TopicPictureContentView *)pictureView {
    if (!_pictureView) {
        TopicPictureContentView *pictureView = [TopicPictureContentView pictureView];
        _pictureView = pictureView;
        [self.contentView addSubview:pictureView];
    }
    return _pictureView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(TopicModel *)topic {
    _topic = topic;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.created_at;
    if (topic.isSinaV) {
        self.vImageView.hidden = NO;
    } else {
        self.vImageView.hidden = YES;
    }
    [self.dingBtn setTitle:[NSString formatterStringByCount:topic.ding placeHolder:@"顶"] forState:UIControlStateNormal];
    [self.caiBtn setTitle:[NSString formatterStringByCount:topic.cai placeHolder:@"踩"] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString formatterStringByCount:topic.repost placeHolder:@"分享"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString formatterStringByCount:topic.comment placeHolder:@"评论"] forState:UIControlStateNormal];
    
    // 设置帖子文字内容
    self.textContentLabel.text = topic.text;
    
    // 根据类型添加相应的内容到 cell 中间
    if (topic.type == TopicTypePicture) {
        self.pictureView.topic = self.topic;
        self.pictureView.frame = topic.pictureContentFrame;
    }
}

- (void)setFrame:(CGRect)frame {
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= frame.origin.x * 2;
    frame.size.height -= margin;
    [super setFrame:frame];
}

@end
