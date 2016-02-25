//
//  MineFooterView.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "WebViewController.h"

#import "MineFooterView.h"

#import "Square.h"
#import "SquareButton.h"

#import <AFNetworking.h>
#import <MJExtension.h>

@implementation MineFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.height = 100;
        [self getData];
    }
    return self;
}

- (void)getData {
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSArray *sqaures = [Square mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
                                    // 创建方块
                                    [self createSqures:sqaures];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                                }];

}

- (void)createSqures:(NSArray *)squares {
    // 一行最多显示4个
    NSUInteger maxInCols = 4;
    CGFloat btnWidth = ScreenWidth / maxInCols;
    CGFloat btnHeight = btnWidth;
    [squares enumerateObjectsUsingBlock:^(Square *square, NSUInteger idx, BOOL * _Nonnull stop) {
        // 列号
        NSUInteger col = idx % maxInCols;
        // 行号
        NSUInteger row = idx / maxInCols;
        SquareButton *btn = [SquareButton buttonWithType:UIButtonTypeCustom];
        btn.squre = square;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(col * btnWidth, row * btnWidth, btnWidth, btnHeight);
                [self addSubview:btn];
    }];
    
    // 计算 footer 高度
    // 总页数 = (总个数 + 每页最大数 - 1) / 每页最大数
    NSUInteger rows = (squares.count + maxInCols - 1) / maxInCols;
    self.height = rows * btnHeight;
    // 重绘
    [self setNeedsDisplay];
}

- (void)btnClicked:(SquareButton *)btn {
    if (![btn.squre.url hasPrefix:@"http"]) {
        return;
    }
    WebViewController *webViewController = [[WebViewController alloc] init];
    webViewController.url = [NSURL URLWithString:btn.squre.url];
    webViewController.title = btn.squre.name;
    
    // 取出当前的导航控制器
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    [nav pushViewController:webViewController animated:YES];
}

- (void)drawRect:(CGRect)rect {
    // 设置该 View的背景图片
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

@end
