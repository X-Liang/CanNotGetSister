//
//  PublishViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/4.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "PublishViewController.h"
#import "VerticalButton.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *slognImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    slognImageView.y = ScreenHeight * .2f;
    slognImageView.centerX = ScreenWidth * .5f;
    [self.view addSubview:slognImageView];
    
    [self createBtn];
}

- (void)createBtn {
    NSUInteger clos = 3;
    CGFloat btnWidth = 72.f;
    CGFloat btnHeight = btnWidth + 30;
    CGFloat sectionMargin = 10;
    CGFloat btnsMargin = (ScreenWidth - 2 * sectionMargin - clos * btnWidth) / 2.f;
    CGFloat btnStartY = (ScreenHeight - 2 * btnHeight - 10) * .5f;
    NSArray *images = @[
                        @"publish-audio", @"publish-offline", @"publish-picture", @"", @"publish-review", @"publish-text",@"publish-video"
                        ];
//    NSArray *titles = @[];
    for (NSInteger index = 0; index < 6; index++) {
        VerticalButton *btn = [[VerticalButton alloc] init];
        btn.frame = CGRectMake(sectionMargin + (index % clos)  * (btnsMargin + btnWidth), btnStartY + index / clos * (btnHeight + 5), btnWidth, btnHeight);
        [btn setImage:[UIImage imageNamed:images[index]] forState:UIControlStateNormal];
//        [btn setTitle:titles[index] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
