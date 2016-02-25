//
//  TopicCell.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/3.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "TopicCell.h"

#import "TopicModel.h"
#import "Comment.h"
#import "User.h"

#import "TopicPictureContentView.h"
#import "TopicVoiceContentView.h"
#import "TopicVideoContentView.h"

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
/// 最热评论
@property (weak, nonatomic) IBOutlet UILabel *topHotCommentLabel;
/// 最热评论父控件
@property (weak, nonatomic) IBOutlet UIView *topHotCommentSuperView;

/// 图片帖子中间的内容
@property (nonatomic, weak) TopicPictureContentView *pictureView;
/// 声音帖子中间的内容
@property (nonatomic, weak) TopicVoiceContentView *voiceView;
/// 视频帖子中间内容
@property (nonatomic, weak) TopicVideoContentView *videoView;
@end

@implementation TopicCell

+ (instancetype)topicCell {
    return [self viewFromXib];
}

- (TopicPictureContentView *)pictureView {
    if (!_pictureView) {
        TopicPictureContentView *pictureView = [TopicPictureContentView pictureView];
        _pictureView = pictureView;
        [self.contentView addSubview:pictureView];
    }
    return _pictureView;
}

- (TopicVoiceContentView *)voiceView {
    if (!_voiceView) {
        TopicVoiceContentView *voiceView = [TopicVoiceContentView voiceContentView];
        _voiceView = voiceView;
        [self.contentView addSubview:voiceView];
    }
    return _voiceView;
}

- (TopicVideoContentView *)videoView {
    if (!_videoView) {
        TopicVideoContentView *videoView = [TopicVideoContentView voideView];
        _videoView = videoView;
        [self.contentView addSubview:videoView];
    }
    return _videoView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTopic:(TopicModel *)topic {
    _topic = topic;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.created_at;
    self.vImageView.hidden = !topic.isSinaV;

    [self.dingBtn setTitle:[NSString formatterStringByCount:topic.ding placeHolder:@"顶"] forState:UIControlStateNormal];
    [self.caiBtn setTitle:[NSString formatterStringByCount:topic.cai placeHolder:@"踩"] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString formatterStringByCount:topic.repost placeHolder:@"分享"] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString formatterStringByCount:topic.comment placeHolder:@"评论"] forState:UIControlStateNormal];
    
    // 设置帖子文字内容
    self.textContentLabel.text = topic.text;
    
    // 根据类型添加相应的内容到 cell 中间
    if (topic.type == TopicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.pictureView.topic = self.topic;
        self.pictureView.frame = topic.pictureContentFrame;
    } else if (topic.type == TopicTypeVoice) {
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceContentFrame;
    } else if (topic.type == TopicTypeVideo) {
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoContentFrame;
    } else {
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    Comment *comment = topic.top_cmt;
    if (comment) {
        self.topHotCommentSuperView.hidden = NO;
        self.topHotCommentLabel.text = [NSString stringWithFormat:@"%@ : %@",comment.user.username, comment.content];
    } else {
        self.topHotCommentSuperView.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= frame.origin.x * 2;
    frame.size.height = self.topic.cellHeight - margin;

    [super setFrame:frame];
}

@end
