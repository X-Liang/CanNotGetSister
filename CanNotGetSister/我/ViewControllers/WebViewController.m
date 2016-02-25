//
//  WebViewController.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/2/12.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackBt;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardBt;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.goBackBt.enabled = webView.canGoBack;
    self.goForwardBt.enabled = webView.canGoForward;
}


@end
