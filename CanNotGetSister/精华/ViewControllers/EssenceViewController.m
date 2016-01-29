//
//  EssenceViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "EssenceViewController.h"

@interface EssenceViewController ()

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏的内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon"
                                                            highlightImageName:@"MainTagSubIconClick"
                                                                        target:self
                                                                        action:@selector(leftBarButtonClicked:)];
    
    self.view.backgroundColor = GlobalColor;
}

- (void)leftBarButtonClicked:(UIButton *)leftButton {
    
}

@end
