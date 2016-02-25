//
//  TagButton.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "TagButton.h"

@implementation TagButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = XLColor(74, 139, 209, 1.f);
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.x = 5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * 5;
}

@end
