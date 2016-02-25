//
//  TopicVoiceContentView.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/6.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "TopicVoiceContentView.h"
#import "TopicModel.h"
#import <UIImageView+WebCache.h>

@interface TopicVoiceContentView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@end

@implementation TopicVoiceContentView

+ (instancetype)voiceContentView {
    return [self viewFromXib];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(TopicModel *)topic {
    _topic = topic;

    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.playCountLabel.text = [NSString stringWithFormat:@"%@播放",topic.playcount];
    // 设置图片
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]
                        placeholderImage:nil];
    
}

- (IBAction)playBtnClicked:(UIButton *)sender {
}

@end
