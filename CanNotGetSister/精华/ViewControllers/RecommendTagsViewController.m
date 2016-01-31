//
//  RecommendTagsViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/30.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "RecommendTagsViewController.h"

#import "RecommendTag.h"

#import "RecommendTagCell.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface RecommendTagsViewController ()
@property (nonatomic, copy) NSArray *tags;
@end

@implementation RecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
    [self configureTableView];
    [self loadData];
}

- (void)loadData {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"
                             parameters:params
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    [SVProgressHUD dismiss];
                                    self.tags = [RecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
                                    [self.tableView reloadData];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [SVProgressHUD showErrorWithStatus:@"加载标签失败"];
                                }];
}

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendTagCell" bundle:nil]
         forCellReuseIdentifier:@"RecommendTagCell"];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GlobalColor;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendTagCell" forIndexPath:indexPath];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}

@end
