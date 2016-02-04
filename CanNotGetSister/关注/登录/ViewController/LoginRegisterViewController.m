//
//  LoginRegisterViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/31.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "LoginRegisterViewController.h"

@interface LoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftConstraint;

@end

@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSAttributedString *)createAttributePlaceHolder:(NSString *)placeHolder {
    return [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
}
- (IBAction)register:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.loginViewLeftConstraint.constant == 0) {
        [sender setTitle:@"已有账号??" forState: UIControlStateNormal];
        self.loginViewLeftConstraint.constant -= self.view.bounds.size.width;
        [UIView animateWithDuration:.5f
                              delay:0.f
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.f
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                [self.view setNeedsLayout];
                                [self.view layoutIfNeeded];
                            } completion:^(BOOL finished) {
                                
                            }];
    } else {
        [sender setTitle:@"注册账号" forState: UIControlStateNormal];
        self.loginViewLeftConstraint.constant = 0;
        [UIView animateWithDuration:.5f
                              delay:0.f
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.f
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                [self.view setNeedsLayout];
                                [self.view layoutIfNeeded];
                            } completion:^(BOOL finished) {
                                
                            }];
    }
    
    
}
- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
