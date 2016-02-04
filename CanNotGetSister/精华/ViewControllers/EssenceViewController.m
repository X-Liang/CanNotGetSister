//
//  EssenceViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/26.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "EssenceViewController.h"
#import "RecommendTagsViewController.h"
#import "AllContentViewController.h"
#import "VideoViewController.h"
#import "VoiceViewController.h"
#import "PictureViewController.h"
#import "WordViewController.h"

static CGFloat NavHeight = 64.f;
static NSUInteger Tag = 678;

@interface EssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *tags;
/// 标签栏底部红色的指示器
@property (nonatomic, weak) UIView *bottomIndectorView;
@property (nonatomic, weak) UIButton *preSelectedTag;
@property (nonatomic, weak) UIView *tagsView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    [self configureNav];
    
    // 添加子 ViewController
    [self configureAllChildViewController];
    
    // 显示内容的 ScrollView
    [self createScrollContentView];
    
    // 设置顶部标签栏
    [self configureTagsView];
    
    self.view.backgroundColor = GlobalColor;
}

- (void)configureNav {
    // 设置导航栏的内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon"
                                                            highlightImageName:@"MainTagSubIconClick"
                                                                        target:self
                                                                        action:@selector(leftBarButtonClicked:)];
}

- (void)configureTagsView {
    // 创建标签栏
    UIView *tagsView = [[UIView alloc] init];
//    tagsView.backgroundColor = XLColor(255, 255, 255, 0.5);
//    tagsView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.5];
    tagsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    tagsView.frame = CGRectMake(0, NavHeight, self.view.width, TagsViewHeight);
    [self.view addSubview:tagsView];
    self.tagsView = tagsView;
    
    // 底部指示器
    UIView *bottomIndicatorView = [[UIView alloc] init];
    bottomIndicatorView.backgroundColor = [UIColor redColor];
    bottomIndicatorView.height = 2;
    bottomIndicatorView.y = tagsView.height - bottomIndicatorView.height;
    self.bottomIndectorView = bottomIndicatorView;
    [tagsView addSubview:bottomIndicatorView];
    
    // 添加标签
//    NSArray *tagTitles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = self.view.width / 5.f; CGFloat height = CGRectGetHeight(tagsView.frame);
    for (NSInteger index = 0; index < self.childViewControllers.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(index * width, 0, width, height);
        [button setTitle:[self.childViewControllers[index] title] forState:UIControlStateNormal];
        [button setTitle:[self.childViewControllers[index] title] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        button.tag = Tag + index;
        [button addTarget:self action:@selector(tagEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.tags addObject:button];
        [tagsView addSubview:button];
        
        // 默认选择第一个按钮
        if (index == 0) {
            button.enabled = NO;
            self.preSelectedTag = button;

            // 让按钮内部的 label 根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.bottomIndectorView.width = button.titleLabel.width;
            self.bottomIndectorView.centerX = button.centerX;
        }
    }
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)createScrollContentView {
    // 禁止自动调整 contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view addSubview:contentView];
    self.contentScrollView = contentView;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
}

- (void)configureAllChildViewController {
    AllContentViewController *allContentVC = [[AllContentViewController alloc] init];
    allContentVC.title = @"全部";
    [self addChildVC:allContentVC];
    
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildVC:videoVC];
    
    VoiceViewController *voiceVC = [[VoiceViewController alloc] init];
    voiceVC.title = @"声音";
    [self addChildVC:voiceVC];
    
    PictureViewController *pictureVC = [[PictureViewController alloc] init];
    pictureVC.title = @"图片";
    [self addChildVC:pictureVC];
    
    WordViewController *wordVC = [[WordViewController alloc] init];
    wordVC.title = @"段子";
    [self addChildVC:wordVC];
}

- (void)tagEvent:(UIButton *)tagBtn {
    [self changeTage:tagBtn];
    NSUInteger index = tagBtn.tag - Tag;
    CGFloat contentOffsetX = self.contentScrollView.width * index;
    [self.contentScrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
    
}

- (void)leftBarButtonClicked:(UIButton *)leftButton {
    RecommendTagsViewController *tagsViewController = [[RecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagsViewController animated:YES];
}

#pragma mark - Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self changeChildViewController:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self changeChildViewController:scrollView];
}

#pragma mark - PrivateMethod
/// 添加自控制器
- (void)addChildVC:(UIViewController *)childController {
    [self addChildViewController:childController];
    [childController didMoveToParentViewController:self];
}

/// 改变子控制器
- (void)changeChildViewController:(UIScrollView *)scrollView {
    // 添加子控制器 View
    // 当前索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    // 取出子控制器
    UIViewController *childViewController = self.childViewControllers[index];
    childViewController.view.x = index * scrollView.width;
    childViewController.view.y = 0;
    childViewController.view.height = scrollView.height;
    [scrollView addSubview:childViewController.view];
    
    // 改变标签选择
    UIButton *btn = self.tags[index];
    [self changeTage:btn];
}
/// 改变选中的标签
- (void)changeTage:(UIButton *)btn {
    btn.enabled = NO;
    self.preSelectedTag.enabled = YES;
    self.preSelectedTag = btn;
    [UIView animateWithDuration:0.3
                          delay:0.f
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.bottomIndectorView.width = btn.titleLabel.width;
                         self.bottomIndectorView.centerX = btn.centerX;
                     }completion:nil];

}

- (NSMutableArray *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

@end
