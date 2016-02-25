//
//  CommentHeaderView.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/9.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "CommentHeaderView.h"

@interface CommentHeaderView ()
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation CommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = GlobalColor;
        UILabel *label = [[UILabel alloc] init];
        label.textColor = XLColor(67, 67, 67, 1);
        label.width = ScreenWidth;
        label.x = 10;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.contentLabel = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.contentLabel.text = title;
}

@end
