//
//  FriendTrendsViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "FriendTrendsViewController.h"

@interface FriendTrendsViewController ()

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@""
                                                            highlightImageName:@""
                                                                        target:self
                                                                        action:@selector(leftBarButtonClicked:)];
}

- (void)leftBarButtonClicked:(UIButton *)leftButton {
    
}


@end
