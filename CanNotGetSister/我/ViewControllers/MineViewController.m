//
//  MineViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "MineViewController.h"
#import "MineFooterView.h"

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
    // 设置 footerView
    self.tableView.tableFooterView = [[MineFooterView alloc] init];
}

- (void)rightBarButtonClicked:(UIButton *)leftButton {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

@end
