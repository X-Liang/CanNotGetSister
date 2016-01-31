//
//  FriendTrendsViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "FriendTrendsViewController.h"
#import "RecommendAttentionViewController.h"
#import "LoginRegisterViewController.h"
@interface FriendTrendsViewController ()

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon"
                                                            highlightImageName:@"friendsRecommentIcon-click"
                                                                        target:self
                                                                        action:@selector(leftBarButtonClicked:)];
}

- (void)leftBarButtonClicked:(UIButton *)leftButton {
    RecommendAttentionViewController *recommAttentionVC = [[RecommendAttentionViewController alloc] init];
    [self.navigationController pushViewController:recommAttentionVC animated:YES];
}

- (IBAction)loginRegisterBtnAction:(UIButton *)sender {
    LoginRegisterViewController *loginRegister = [[LoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
}

@end
