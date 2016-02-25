//
//  AddTagViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/14.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "AddTagViewController.h"
#import "DeleteBackTextField.h"
#import "TagButton.h"
#define Margin 8
@interface AddTagViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *addBtn;

@property (nonatomic, assign) CGFloat tagBtnX;
@property (nonatomic, assign) CGFloat tagBtnY;

@property (nonatomic, strong) NSMutableArray *tagsBtn;
@end

@implementation AddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpContentView];
    [self setUpTextField];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)setUpNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(done)];
}

- (void)setUpContentView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(Margin, 64 + Margin, ScreenWidth - 2 * Margin, ScreenHeight)];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setUpTextField {
    DeleteBackTextField *textField = [[DeleteBackTextField alloc] init];
    textField.placeholder = @"多个标签用逗号或换行隔开";
    textField.delegate = self;
    textField.width = ScreenWidth;
    textField.height = 30;
    __weak typeof(self) weakSelf = self;
    textField.deleteBlock = ^{
        NSLog(@"%d",self.textField.text.length);
        if (self.textField.text.length == 0) {
            [weakSelf tagBtnClicked:[weakSelf.tagsBtn lastObject]];
        }
    };
    // 监听 textField 的文字改变
    [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

#pragma mark - Action
/// 监听 textField 的文字改变
- (void)textFieldChange:(UITextField *)textField {
    if (textField.hasText) {
        // 更新 Tags 的 frame
        [self updateTextFieldFrame];
        
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(self.textField.frame) + Margin;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签: %@",self.textField.text] forState:UIControlStateNormal];
        
#pragma mark - 输入逗号成为一个标签
        // 获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger length = text.length;
        NSString *lastLetter = [text substringFromIndex:length - 1];
        if (([lastLetter isEqualToString:@","] ||
             [lastLetter isEqualToString:@"，"]) &&
            length > 1) {
            // 去除最后的逗号
            self.textField.text = [text substringToIndex:length - 1];
            [self addTag:self.addBtn];
        }
    } else {
        self.addBtn.hidden = YES;
    }
}



/// 监听添加标签按钮点击
/// 自己实现的逻辑
- (void)addBtnDidClicked:(UIButton *)addBtn {
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    [tagBtn setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    tagBtn.backgroundColor = self.addBtn.backgroundColor;
    [tagBtn sizeToFit];
    if (self.tagBtnX + tagBtn.width >= ScreenWidth - Margin) {
        self.tagBtnY += 35 + Margin;
        self.tagBtnX = 0;
    }
    
    tagBtn.frame = CGRectMake(self.tagBtnX, self.tagBtnY, tagBtn.width, tagBtn.height);
    [self.contentView addSubview:tagBtn];
    self.tagBtnX = CGRectGetMaxX(tagBtn.frame) + Margin;
    self.textField.x = self.tagBtnX;
    CGFloat width = [self.textField.placeholder boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.textField.font} context:nil].size.width;
    if (self.textField.x + width > ScreenWidth - Margin) {
        self.textField.x = 0;
        self.textField.y = self.tagBtnY + 35 + Margin;
    }
    self.addBtn.y = CGRectGetMaxY(self.textField.frame) + Margin;
    self.textField.text = nil;
    [self textFieldChange:self.textField];
}

- (void)done {
    
}

- (void)tagBtnClicked:(UIButton *)tagBtn {
    // 从父视图中移除
    [tagBtn removeFromSuperview];
    // 从数据源中移除
    [self.tagsBtn removeObject:tagBtn];
    // 重新布局
    [UIView animateWithDuration:.25
                     animations:^{
                         [self updateTagsBtnFrame];
                         [self updateTextFieldFrame];
                     }];
}

#pragma mark - PrivateMethod
- (void)addTag:(UIButton *)btn {
    TagButton *tagBtn = [TagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    [tagBtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    tagBtn.height = self.textField.height;
    [self.contentView addSubview:tagBtn];
    [self.tagsBtn addObject:tagBtn];
    // 更新标签按钮 frame
    [self updateTagsBtnFrame];
    [self updateTextFieldFrame];
    
    // 清空 textField文字
    self.textField.text = nil;
    [self textFieldChange:self.textField];
}

- (void)updateTagsBtnFrame {
    [self.tagsBtn enumerateObjectsUsingBlock:^(UIButton *tagBtn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            tagBtn.x = tagBtn.y = 0;
        } else {
            UIButton *preTagBtn = self.tagsBtn[idx - 1];
            // 计算剩余的宽度空间
            CGFloat leftWidth = CGRectGetMaxX(preTagBtn.frame) + Margin;
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagBtn.width) {
                tagBtn.y = preTagBtn.y;
                tagBtn.x = leftWidth;
            } else {    // 显示到下一行
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY(preTagBtn.frame) + Margin;
                if (tagBtn.width > self.contentView.width) {
                    tagBtn.width = self.contentView.width;
                }
            }
        }
    }];
    [self updateTextFieldFrame];
}

// TextField 的文字宽度
- (CGFloat)textFieldWidth {
    CGFloat textWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName: self.textField.font}].width;
    CGFloat placeholderWidth = [self.textField.placeholder sizeWithAttributes:@{NSFontAttributeName: self.textField.font}].width;
    return MAX(textWidth, placeholderWidth);
}

- (void)updateTextFieldFrame {
    // 更新 textFieldframe
    UIButton *lastTagBtn = [self.tagsBtn lastObject];
    CGFloat leftWidth = CGRectGetMaxX([[self.tagsBtn lastObject] frame]) + Margin;
    // 剩余宽度
    CGFloat surplusWidth = self.contentView.width - leftWidth;
    //
    CGFloat textFiledWidth = [self textFieldWidth];
    // 与最后一个 btn 在同一行
    if (surplusWidth >= textFiledWidth) {
        self.textField.y = lastTagBtn.y;
        self.textField.x = leftWidth;
    } else {    // 新起一行
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + Margin;
    }

}

#pragma mark - Delegate
/// 监听 returnKey的点击
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.hasText) {
        [self addTag:self.addBtn];
    }
    return YES;
}

#pragma mark - Setter/Getter
- (UIButton *)addBtn {
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = self.contentView.width;
        btn.height = 35;
        btn.backgroundColor = XLColor(74, 139, 209, 1.f);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [btn addTarget:self action:@selector(addBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(addTag:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        // 设置btn 中 Label 的左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, Margin, 0, Margin);
        btn.y = CGRectGetMaxY(self.textField.frame) + Margin;
        [self.contentView addSubview:btn];
        _addBtn = btn;
    }
    return _addBtn;
}

- (NSMutableArray *)tagsBtn {
    if (!_tagsBtn) {
        _tagsBtn = [NSMutableArray array];
    }
    return _tagsBtn;
}
@end
