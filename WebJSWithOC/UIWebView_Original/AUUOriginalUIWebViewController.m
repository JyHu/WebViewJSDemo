//
//  AUUOriginalUIWebViewController.m
//  WebJSWithOC
//
//  Created by 胡金友 on 2016/12/9.
//  Copyright © 2016年 胡金友. All rights reserved.
//

#import "AUUOriginalUIWebViewController.h"

@interface AUUOriginalUIWebViewController ()<UIWebViewDelegate>

@property (retain, nonatomic) UIWebView *webView;

@end

@implementation AUUOriginalUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self addWebView:self.webView];
    [self loadRequestWithFileName:@"ui_web_original" forWebView:self.webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlstr = request.URL.absoluteString;
    NSRange cmd_range = [urlstr rangeOfString:@"ios_cmd://"];
    if (cmd_range.location != NSNotFound) {
        [self appendValue:[@"从JS中传递过来的值：\n" stringByAppendingString:[urlstr substringFromIndex:cmd_range.location + cmd_range.length]]];
    }
    
    return YES;
}

- (void)sendValueToJS
{
    NSString *jsstr = [NSString stringWithFormat:@"oc_transferValue_to_js('%@')", self.textfield.text];
    NSString *rev = [self.webView stringByEvaluatingJavaScriptFromString:jsstr];
    [self appendValue:[NSString stringWithFormat:@"OC调用JS后的返回值：%@", rev]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
