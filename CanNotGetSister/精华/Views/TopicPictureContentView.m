//
//  TopicPictureContentView.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/4.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "TopicPictureContentView.h"
#import "ShowPictureViewController.h"

#import "TopicModel.h"

#import <UIImageView+WebCache.h>

@interface TopicPictureContentView ()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@end

@implementation TopicPictureContentView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TopicPictureContentView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentImageView.userInteractionEnabled = YES;
    [self.contentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentImage:)]];
}

- (void)setTopic:(TopicModel *)topic {
    _topic = topic;
    // 设置图片
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]
                             placeholderImage:nil
                                      options:0
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         self.progressView.hidden = NO;
                                         NSInteger progress = receivedSize / expectedSize;
                                     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         self.progressView.hidden = YES;
                                         // 如果是大图, 进行裁剪
                                         if (topic.overHeight) {
                                             self.contentImageView.image = [image shapeImageTopAreaInTargetSize:topic.pictureContentFrame.size];
                                         }
                                         
                                     }];
    
    // 判断是否为 Gif, 方法一: 判断拓展名
    // 获得 URL 中内容的拓展名
    NSString *extension = topic.large_image.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    // 方法二, 取出图片数据, 取出图片数据中的第一个字节, 就可以判断图片的真实类型
    // 判断是否显示点击查看全图按钮
    if (topic.overHeight) { // 大图
        self.seeBigButton.hidden = NO;
    } else {
        self.seeBigButton.hidden = YES; // 非大图
    }
}


- (void)tapContentImage:(id)sender {
    ShowPictureViewController *picVC = [[ShowPictureViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picVC animated:YES completion:nil];
}

@end
