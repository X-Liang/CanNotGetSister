//
//  PublishViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/4.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishWordViewController.h"
#import "CustomNavigationController.h"

#import "VerticalButton.h"

#import <POP.h>

static CGFloat const AnimationDelay = 0.05;
@interface PublishViewController ()
@property (nonatomic, strong) NSMutableArray *animateItems;
@end

@implementation PublishViewController

- (NSMutableArray *)animateItems {
    if (!_animateItems) {
        _animateItems = [NSMutableArray array];
    }
    return _animateItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBtn];
}

- (void)createBtn {
    
    self.view.userInteractionEnabled = NO;
    
    NSUInteger clos = 3;
    CGFloat btnWidth = 72.f;
    CGFloat btnHeight = btnWidth + 30;
    CGFloat sectionMargin = 10;
    CGFloat btnsMargin = (ScreenWidth - 2 * sectionMargin - clos * btnWidth) / 2.f;
    CGFloat btnStartY = (ScreenHeight - 2 * btnHeight - 10) * .5f;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    for (NSInteger index = 0; index < 6; index++) {
        VerticalButton *btn = [[VerticalButton alloc] init];
        btn.tag = 1024 + index;
        [btn setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
        [btn setTitle:titles[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        CGFloat endX = sectionMargin + (index % clos)  * (btnsMargin + btnWidth);
        CGFloat endY = btnStartY + index / clos * (btnHeight + 5);
        CGFloat beginY = endX - ScreenHeight;
        // 添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(endX, beginY, btnWidth, btnHeight)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(endX, endY, btnWidth, btnHeight)];
        // 加强弹簧效果
        anim.springBounciness = 10;
        anim.springSpeed = 15.f;
        anim.beginTime = CACurrentMediaTime() + AnimationDelay * index;
        [btn pop_addAnimation:anim forKey:nil];
        
        [self.animateItems addObject:btn];
    }
    
    UIImageView *slognImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slognImageView.centerY = ScreenHeight * .2f - ScreenHeight;
    slognImageView.centerX = ScreenWidth * .5f;
    [self.view addSubview:slognImageView];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(slognImageView.centerX, slognImageView.centerY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(slognImageView.centerX, ScreenHeight * .2f)];
    anim.springBounciness = 10;
    anim.springSpeed = 15.f;
    anim.beginTime = CACurrentMediaTime() + images.count * AnimationDelay;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            self.view.userInteractionEnabled = YES;
        }
    }];
    [slognImageView pop_addAnimation:anim forKey:nil];
    [self.animateItems addObject:slognImageView];
}

/**
 * CoreAnimation 动画只能添加到 Layer 上
 * Pop 可以添加到任何对象上
 * CoreAnimation 仅仅是表象, 并不是真正修改过对象的 frame, size
 * Pop 会实时修改对象属性, 真正修改对象属性
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancleWithComplationBlock:nil];
}

- (void)cancleWithComplationBlock:(void (^)())completionBlock {
    self.view.userInteractionEnabled = NO;
    [self.animateItems enumerateObjectsUsingBlock:^(UIView *animateItem, NSUInteger idx, BOOL * _Nonnull stop) {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(animateItem.centerX, animateItem.centerY + ScreenHeight)];
        anim.beginTime = CACurrentMediaTime() + (self.animateItems.count - idx) * AnimationDelay;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (idx == 0) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                if (finished) {
                    self.view.userInteractionEnabled = YES;
                    [self dismissViewControllerAnimated:NO completion:nil];
                    !completionBlock ? : completionBlock();
                }
            }];
        }
        [animateItem pop_addAnimation:anim forKey:nil];
    }];
}

- (void)btnClicked:(UIButton *)btn {
    NSUInteger index = btn.tag-1024;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self cancleWithComplationBlock:^{
        UIViewController *vc = nil;
        switch (index) {
            case 0:
            case 1:
            case 2: {
                vc = [[PublishWordViewController alloc] init];
                vc = [[CustomNavigationController alloc] initWithRootViewController:vc];
            }
                break;
            case 3:
            case 4:
            case 5:
            {
                vc = [[UIViewController alloc] init];
                vc.view.backgroundColor = [UIColor whiteColor];
            }
                break;
                
            default:
                break;
        }
        [window.rootViewController presentViewController:vc animated:YES completion:nil];
    }];
}

- (IBAction)dismiss:(id)sender {
    [self cancleWithComplationBlock:nil];
}

@end
