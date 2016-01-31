//
//  RecommendTagCell.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/30.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "RecommendTagCell.h"
#import "RecommendTag.h"
#import <UIImageView+WebCache.h>

@interface RecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *flowButton;
@end

@implementation RecommendTagCell

- (void)setRecommendTag:(RecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.nameLabel setText:recommendTag.theme_name];
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    [self.countLabel setText:subNumber];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 0.5;
    [super setFrame:frame];
}

@end
