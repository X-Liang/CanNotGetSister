//
//  MineViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon"
                                                            highlightImageName:@"mine-setting-icon-click"
                                                                        target:self
                                                                        action:@selector(rightBarButtonClicked:)];

}

- (void)rightBarButtonClicked:(UIButton *)leftButton {
    
}

@end
