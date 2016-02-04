//
//  VerticalButton.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/31.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configure];
}

- (void)configure {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
