//
//  PublishView.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/5.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "PublishView.h"
#import "VerticalButton.h"

@implementation PublishView

+ (instancetype)publishView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *slognImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slognImageView.y = ScreenHeight * .2f;
    slognImageView.centerX = ScreenWidth * .5f;
    [self addSubview:slognImageView];
    
    [self createBtn];
}

- (void)createBtn {
    NSUInteger clos = 3;
    CGFloat btnWidth = 72.f;
    CGFloat btnHeight = btnWidth + 30;
    CGFloat sectionMargin = 10;
    CGFloat btnsMargin = (ScreenWidth - 2 * sectionMargin - clos * btnWidth) / 2.f;
    CGFloat btnStartY = (ScreenHeight - 2 * btnHeight - 10) * .5f;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    for (NSInteger index = 0; index < images.count; index++) {
        VerticalButton *btn = [[VerticalButton alloc] init];
        btn.frame = CGRectMake(sectionMargin + (index % clos)  * (btnsMargin + btnWidth), btnStartY + index / clos * (btnHeight + 5), btnWidth, btnHeight);
        [btn setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
        [btn setTitle:titles[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:btn];
    }
}

static UIWindow *window = nil;
+ (void)show {
    window = [[UIWindow alloc] init];
    window.frame = [UIScreen mainScreen].bounds;
    window.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
    window.hidden = NO;
    PublishView *publishView = [PublishView publishView];
    publishView.frame = window.bounds;
    [window addSubview:publishView];
}

- (IBAction)cancle:(UIButton *)sender {
    
}

@end
