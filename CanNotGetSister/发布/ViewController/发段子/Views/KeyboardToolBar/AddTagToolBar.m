//
//  AddTagToolBar.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "AddTagToolBar.h"

#import "AddTagViewController.h"
@interface AddTagToolBar ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, weak) UIButton *addTagBtn;
@end

@implementation AddTagToolBar

+ (instancetype)toolBar {
    return [self viewFromXib];
}

- (void)awakeFromNib {
    // 添加加号按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addBtn.frame = CGRectZero;
    //    addBtn.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //    addBtn.size = [addBtn imageForState:UIControlStateNormal].size;
    addBtn.size = [addBtn currentImage].size;
    [self.topView addSubview:addBtn];
    self.addTagBtn = addBtn;
    [self.addTagBtn addTarget:self action:@selector(addTag:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.addTagBtn.x = self.addTagBtn.y = 0;
}

- (void)addTag:(UIButton *)btn {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:[[AddTagViewController alloc] init] animated:YES];
}

@end
