//
//  RecommendCategoryCell.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "RecommendCategoryCell.h"
#import "RecommendType.h"

@interface RecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@end

@implementation RecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedView.hidden = YES;
}

- (void)setCategory:(RecommendType *)category {
    self.titleLabel.text = category.name;
}

/// 点击 cell 时, 调用该方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (selected) {
        self.selectedView.hidden = NO;
        self.titleLabel.textColor = [UIColor redColor];
    } else {
        self.selectedView.hidden = YES;
        self.titleLabel.textColor = [UIColor darkGrayColor];
    }
    [super setSelected:selected animated:animated];
}
@end
