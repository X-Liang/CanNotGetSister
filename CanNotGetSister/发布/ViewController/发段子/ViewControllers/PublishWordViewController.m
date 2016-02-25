//
//  PublishWordViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "PublishWordViewController.h"

#import "PlaceholderTextView.h"
#import "AddTagToolBar.h"

@interface PublishWordViewController ()<UITextViewDelegate>
@property (nonatomic, weak) PlaceholderTextView *textView;
@property (nonatomic, weak) AddTagToolBar *addTagToolBar;
@end

@implementation PublishWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNav];
    [self setUpTextView];
    [self setUpKeyboardToolBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

/// 配置导航栏
- (void)configureNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismiss:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(postWords:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // 设置appearance 后, 只有当 ViewDidAppear 后才会使用 appearance 设置的样式
    [self.navigationController.navigationBar layoutIfNeeded];   // 强制刷新

}

/// 设置 TextView
- (void)setUpTextView {
    PlaceholderTextView *textView = [[PlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}

/// 设置标签的工具栏
- (void)setUpKeyboardToolBar {
    AddTagToolBar *addTagToolBar = [AddTagToolBar toolBar];
    addTagToolBar.frame = CGRectMake(0, ScreenHeight - addTagToolBar.height, ScreenWidth, addTagToolBar.height);
    [self.view addSubview:addTagToolBar];
    self.addTagToolBar = addTagToolBar;
}

#pragma mark - Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - Action
- (void)dismiss:(UIBarButtonItem *)barButtonItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)postWords:(UIBarButtonItem *)barButtonItem {
    
}

#pragma mark - Notification 
- (void)keyboardChangeFrame:(NSNotification *)notify {
    CGRect keyboardEndFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.addTagToolBar.transform = CGAffineTransformMakeTranslation(0, keyboardEndFrame.origin.y - ScreenHeight);
    }];
}

@end
