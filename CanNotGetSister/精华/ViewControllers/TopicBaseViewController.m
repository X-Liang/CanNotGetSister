//
//  TopicBaseViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/2.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "TopicBaseViewController.h"
#import "CommentViewController.h"
#import "NewViewController.h"

#import "TopicModel.h"

#import "TopicCell.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface TopicBaseViewController ()
/// 段子数组
@property (nonatomic, strong) NSMutableArray *topics;
/// 当前页码
@property (nonatomic, assign) NSInteger currentPage;
/// 加载更多数据时需要的参数
@property (nonatomic, copy) NSString *maxTime;
/// 上一次网络请求时发送的参数
@property (nonatomic, strong) NSDictionary *preParamaters;

// 上次选中的索引
@property (nonatomic, assign) NSInteger preSelectIndex;

@property (nonatomic, copy) NSString *a;
@end

@implementation TopicBaseViewController

- (NSString *)a {
     return [self.parentViewController isKindOfClass:[NewViewController class]] ? @"newlist" : @"list";
}

/// 由子类实现
- (NSString *)type {
    return nil;
}

- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    [self setUpRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidSelected) name:TabBarDidSelectedNotification object:nil];
}

- (void)configureTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(TagsViewHeight + TagsViewY, 0, 49, 0);
    // 设置滚动条的 contentInset
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
}

- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}

/**
 * 产生问题:
 * 用户先进行下拉刷新, 网络速度慢, 没有结果返回, 之后用户进行上拉加载更多
 * 这个时候下拉数据返回, 此时会清空数据源数组中的内容, 将服务器第一页最新数据放到
 * 数据源数组中, 这是上拉加载返回数据, 将数据添加到数据源数组中, 此时数据源数组
 * 只包括第一页数据和第五页数据, 产生问题
 * 解决方法:
 * 以最后一次网络请求为主, 当两个请求按先后执行时, 以第二个返回数据为主
 */

- (void)loadData {
    
    // 结束上拉加载更多
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    self.preParamaters = parameters;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"
                             parameters:parameters
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    [self.tableView.mj_header endRefreshing];
                                    if (self.preParamaters != parameters) { // 请求过期
                                        return ;
                                    }
                                    // 字典->模型
                                    self.topics = [TopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                    self.maxTime = responseObject[@"info"][@"maxtime"];
                                    [self.tableView reloadData];
                                    // 下拉刷新成功后, 置当前的页码为第0页
                                    self.currentPage = 0;
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [self.tableView.mj_header endRefreshing];
                                    if (self.preParamaters != parameters) { // 请求过期
                                        return ;
                                    }
                                }];
    
}

// 加载更多数据
- (void)loadMoreData {
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    self.currentPage++;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    parameters[@"page"] = @(self.currentPage);
    parameters[@"maxtime"] = self.maxTime;
    self.preParamaters = parameters;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"
                             parameters:parameters
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    if (self.preParamaters != parameters) { // 请求过期
                                        return ;
                                    }
                                    // 字典->模型
                                    NSArray *topics = [TopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                    [self.topics addObjectsFromArray:topics];
                                    self.maxTime = responseObject[@"info"][@"maxtime"];
                                    
                                    [self.tableView reloadData];
                                    [self.tableView.mj_footer endRefreshing];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [self.tableView.mj_footer endRefreshing];
                                    if (self.preParamaters != parameters) { // 请求过期
                                        return ;
                                    }
                                    // 当网络失败时, 恢复页码
                                    self.currentPage--;
                                }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell" forIndexPath:indexPath];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicModel *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentViewController *commentVC = [[CommentViewController alloc] init];
    commentVC.topicModel = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - Notification
- (void)tabBarDidSelected {
    // 如果是连续点击两次, 并且选中的控制器为精华控制器, 并且显示在窗口, 刷新
    if (self.preSelectIndex == self.tabBarController.selectedIndex &&
        self.tabBarController.selectedViewController == self.navigationController &&
        [self.view isShowingInKeyWindow]) {
        [self.tableView.mj_header beginRefreshing];
    }
    // 记录这次选中的索引
    self.preSelectIndex = self.tabBarController.selectedIndex;
}

@end
