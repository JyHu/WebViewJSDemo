//
//  TestViewController.m
//  WebkitTransporter
//
//  Created by 胡金友 on 2018/9/5.
//  Copyright © 2018年 胡金友. All rights reserved.
//

#import "TestViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

@interface TestViewController ()<WKScriptMessageHandler, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSScrollView *scrollView;

@end

@implementation TestViewController

- (void)loadView {
    self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 720, 400)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(NSEdgeInsetsMake(20, 20, 20, 20));
    }];
    
    NSURL *hurl = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    NSString *str = [[NSString alloc] initWithContentsOfURL:hurl encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:str baseURL:hurl];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        [userController addScriptMessageHandler:self name:@"oc_method"];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userController;
        
        configuration.preferences.javaScriptEnabled = YES;
        
        _webView = [[WKWebView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100) configuration:configuration];
    }
    return _webView;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@", message);
}


@end
