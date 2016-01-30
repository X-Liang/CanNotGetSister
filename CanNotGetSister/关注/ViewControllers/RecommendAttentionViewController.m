//
//  RecommendAttentionViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "RecommendAttentionViewController.h"

#import "RecommendCategoryCell.h"
#import "RecommendUserCell.h"

#import "RecommendType.h"
#import "RecommendUser.h"

#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>


@interface RecommendAttentionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, copy) NSArray *categories;
@property (nonatomic, copy) NSArray *users;
/// 上一次选择的分类的位置
@property (nonatomic, assign) NSUInteger preSelectedIndex;
/// 上一次的请求参数
@property (nonatomic, strong) NSMutableDictionary *preParams;
/// AFN
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation RecommendAttentionViewController

#pragma mark - 控制器销毁
/// 控制器销毁
- (void)dealloc {
    // 停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GlobalColor;
    self.title = @"推荐关注";
    [self loadCategories];
    [self configureTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return self.categories.count;
    } else if ([tableView isEqual:self.userTableView]) {
        RecommendType *category = self.categories[[[self.tableView indexPathForSelectedRow] row]];
        [self checkFooterStatus:category];
        return [category.uses count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        RecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCategoryCell" forIndexPath:indexPath];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else if ([tableView isEqual:self.userTableView]) {
        RecommendType *category = self.categories[[[self.tableView indexPathForSelectedRow] row]];
        RecommendUserCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"RecommendUserCell" forIndexPath:indexPath];
        userCell.user = category.uses[indexPath.row];
        return userCell;
    } else {
        return nil;
    }
    
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableView]) {
        return 45;
    } else if ([tableView isEqual:self.userTableView]) {
        return 65;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    RecommendType *category = self.categories[indexPath.row];
    
    if ([category.uses isVailed]) {
        [self.userTableView reloadData];
    } else {
        category.currentPage = 1;
        [self.userTableView reloadData];
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - PrivateMethod
/// 配置两个 tableView
- (void)configureTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendCategoryCell" bundle:nil]
         forCellReuseIdentifier:@"RecommendCategoryCell"];
    [self.userTableView registerNib:[UINib nibWithNibName:@"RecommendUserCell" bundle:nil]
             forCellReuseIdentifier:@"RecommendUserCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.tableView.contentInset;
    self.userTableView.tableFooterView = [UIView new];
    [self setUpRefresh];
}
/// 添加刷新控件
- (void)setUpRefresh {
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        RecommendType *category = self.categories[[self.tableView indexPathForSelectedRow].row];
        // 下拉刷新, 当前为第一页数据
        category.currentPage = 1;
        // 清除之前的所有旧数据
        [category.uses removeAllObjects];
        [self loadUsersWithCategory:category
                               page:[NSString stringWithFormat:@"%d",category.currentPage]
                            success:^{
                                [self.userTableView.mj_header endRefreshing];
                            } failure:^{
                                [self.userTableView.mj_header endRefreshing];
                            }];
        
    }];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        RecommendType *category = self.categories[[self.tableView indexPathForSelectedRow].row];
        [self loadUsersWithCategory:category
                               page:[NSString stringWithFormat:@"%d",++category.currentPage]
                            success:nil
                            failure:^{
                                [self.userTableView.mj_footer endRefreshing];
                            }];
    }];
    self.userTableView.mj_footer.hidden = YES;
}

- (void)loadCategories {
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 发送请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
           parameters:parameters
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  // 服务器返回数据
                  self.categories = [RecommendType mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                  [self.tableView reloadData];
                  
                  // 默认选中第0行
                  [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                              animated:YES
                                        scrollPosition:UITableViewScrollPositionTop];
                  [[self.categories firstObject] setCurrentPage:1];
                  [self loadUsersWithCategory:[self.categories firstObject]
                                         page:nil
                                      success:^{
                                          // 隐藏指示器
                                          [SVProgressHUD dismiss];
                                      } failure:^{
                                          [SVProgressHUD dismiss];
                                          [SVProgressHUD showErrorWithStatus:@"加载推荐内容失败, 请稍后再试"];
                                      }];
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  // 显示失败信息
                  [SVProgressHUD showErrorWithStatus:@"加载推荐内容失败, 请稍后再试"];
              }];

}

- (void)loadUsersWithCategory:(RecommendType *)category
                         page:(NSString *)page
                      success:(void (^)())success
                      failure:(void(^)())failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = category.id;
    page = (page == nil) ? @"1": page;
    parameters[@"page"] = page;
    self.preParams = parameters;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
                             parameters:parameters
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    // 字典->模型
                                    NSArray *uses = [RecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                    // 将 uses 数据保存到对应的 category 类别模型中
                                    [category.uses addObjectsFromArray:uses];
                                    
                                    // 设置数据总数
                                    category.total = [responseObject[@"total"] integerValue];
                                    
                                    // 请求的 paramter 与现在刚生产的 paramters 不一致, 用户在上一次请求为成功返回时开始下一个请求
                                    if (self.preParams != parameters) return ;
                                    
                                    [self.userTableView reloadData];
                                    
                                    [self checkFooterStatus:category];
                                    
                                    if (success) {
                                        success();
                                    }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    if (self.preParams != parameters) return ;

                                    if (failure) {
                                        failure();
                                    }
                                }];
}

- (void)checkFooterStatus:(RecommendType *)category {
    // 控制 footer 的显示或隐藏
    self.userTableView.mj_footer.hidden = category.uses.count == 0;
    // 数据全部加载完毕
    if (category.uses.count == category.total) {
        // 没有更多数据
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - Setter/Getter
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

@end
