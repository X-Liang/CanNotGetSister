//
//  CommentViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/8.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "CommentViewController.h"

#import "TopicCell.h"
#import "CommentCell.h"
#import "CommentHeaderView.h"

#import "TopicModel.h"
#import "Comment.h"

#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>

@interface CommentViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
/// 评论工具栏底部的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentBarBottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/// 最热评论
@property (nonatomic, copy) NSArray *hotComments;
/// 最新评论
@property (nonatomic, strong) NSMutableArray *latestComments;

/// 最热评论信息
@property (nonatomic, copy) Comment *topCmps;
/// 保存的 Cell 高度
@property (nonatomic, assign) CGFloat cellHeight;
/// 当前评论页码
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation CommentViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.manager.operationQueue cancelAllOperations];
    [self.manager invalidateSessionCancelingTasks:YES];
    
    if (self.topCmps) {
        self.topicModel.top_cmt = self.topCmps;
        self.topicModel.cellHeight = self.cellHeight;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    [self setUpHeader];
    [self setupRefresh];
}

- (void)configure {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem
                                              itemWithImageName:@"comment_nav_item_share_icon"
                                              highlightImageName:@"comment_nav_item_share_icon_click" target:self action:@selector(share:)];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[CommentHeaderView class] forHeaderFooterViewReuseIdentifier:@"SectionHeader"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
//    self.tableView.mj_footer.hidden = YES;
}

- (void)setUpHeader {
    // 创建 Header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = GlobalColor;
    
    // 清空传递的最热评论数组
    if (self.topicModel.top_cmt) {
        self.cellHeight = self.topicModel.cellHeight;
        self.topCmps = self.topicModel.top_cmt;
        self.topicModel.top_cmt = nil;
        [self.topicModel clearCellHeight];
    }
    
    TopicCell *cell = [TopicCell topicCell];
    cell.topic = self.topicModel;
    cell.frame = CGRectMake(0, 0, ScreenWidth, self.topicModel.cellHeight);
    
    header.height = self.topicModel.cellHeight + 10;
    [header addSubview:cell];
    self.tableView.tableHeaderView = header;
    self.tableView.backgroundColor = GlobalColor;
}

- (void)loadNewComments {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"hot"] = @"1";
    
    // 开始下个请求之前结束之前所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
                             parameters:params
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    if (![responseObject isKindOfClass:[NSDictionary class]]) {  // 没有评论数据
                                        [self.tableView.mj_header endRefreshing];
                                        return ;
                                    }
                                    // 下拉刷新成功, 当前页码置为第1页
                                    self.currentPage = 1;
                                    // 最热评论
                                    self.hotComments = [Comment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
                                    // 最新评论
                                    self.latestComments = [Comment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                                    [self.tableView reloadData];
                                    [self.tableView.mj_header endRefreshing];
                                    
                                    // 控制 footer 的状态
                                    NSInteger total = [responseObject[@"total"] integerValue];
                                    if (total <= self.latestComments.count) { // 全部加载完毕
                                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                    } else {
                                        [self.tableView.mj_footer endRefreshing];
                                    }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [self.tableView.mj_header endRefreshing];
                                }];
}

- (void)loadMoreComments {

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"page"] = @(self.currentPage+1);
    Comment *comment = [self.latestComments lastObject];
    params[@"lastcid"] = comment.ID;
    
    // 开始下个请求之前结束之前所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
                             parameters:params
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    if (![responseObject isKindOfClass:[NSDictionary class]]) {  // 没有评论数据
                                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                        return ;
                                    }
                                    
                                    // 刷新成功, 当前页码数加1
                                    self.currentPage++;
                                    // 最新评论
                                    
                                    NSArray *latestComments = [Comment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                                    // 将最新的数据添加到原有数据的最后面
                                    [self.latestComments addObjectsFromArray:latestComments];
                                    [self.tableView reloadData];
                                    [self.tableView.mj_footer endRefreshing];
                                    
                                    // 控制 footer 的状态
                                    NSInteger total = [responseObject[@"total"] integerValue];
                                    if (total <= self.latestComments.count) { // 全部加载完毕
                                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                    }else {
                                        [self.tableView.mj_footer endRefreshing];
                                    }

                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [self.tableView.mj_footer endRefreshing];
                                }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) {
        return 2;
    }
    if (latestCount) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    // 第0组, 有 hotCount 返回最热评论, 否则返回最新评论
    if (section == 0) {
        return hotCount ? : latestCount;
    }
//    self.tableView.mj_footer.hidden = latestCount == 0;
    // 第1组, 返回最新评论
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    Comment *comment = [self commentInIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}


#pragma mark - Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommentHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeader"];
    NSString *text = nil;
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        text = hotCount ? @"最热评论" : @"最新评论";
    } else {
        text = @"最新评论";
    }
    sectionHeaderView.title = text;
    return sectionHeaderView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - PrivateMethod 
/// 返回第 section 组的评论数据
- (NSArray *)commentInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (Comment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentInSection:indexPath.section][indexPath.row];
}

#pragma mark - Nofify
- (void)keyboardWillChangeFrame:(NSNotification *)notify {
    // 显示或者隐藏时的 frame
    CGRect frame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.commentBarBottomConstraint.constant = ScreenHeight - frame.origin.y;
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}


@end
