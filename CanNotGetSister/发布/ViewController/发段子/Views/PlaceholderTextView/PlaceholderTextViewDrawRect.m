//
//  PlaceholderTextView.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "PlaceholderTextViewDrawRect.h"

@interface PlaceholderTextViewDrawRect ()

@end

@implementation PlaceholderTextViewDrawRect

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderTextColor = [UIColor lightGrayColor];
        self.alwaysBounceVertical = YES;    // 垂直方向上永远有弹簧效果
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textChanged)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
    }
    return self;
}

- (void)textChanged {
    [self setNeedsDisplay];
}

// 方案一: 通过 drawRect 方法将 placeholder 文字画在 View上
- (void)drawRect:(CGRect)rect {
    if (self.hasText || self.attributedText.length) {
        return;
    }
    
    CGRect textRect = CGRectMake(5, 8, self.width - 10, self.height);
    [self.placeholder drawInRect:textRect withAttributes:@{NSFontAttributeName: self.font,
                                                           NSForegroundColorAttributeName: self.placeholderTextColor}];
}

#pragma mark - Setter/ Getter
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

@end
