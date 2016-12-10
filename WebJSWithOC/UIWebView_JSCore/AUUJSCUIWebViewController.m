//
//  AUUJSCUIWebViewController.m
//  WebJSWithOC
//
//  Created by 胡金友 on 2016/12/10.
//  Copyright © 2016年 胡金友. All rights reserved.
//

#import "AUUJSCUIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface AUUJSCUIWebViewController ()<UIWebViewDelegate>

@property (retain, nonatomic) UIWebView *webView;

@property (retain, nonatomic) JSContext *context;

@end

@implementation AUUJSCUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self addWebView:self.webView];
    [self loadRequestWithFileName:@"ui_web_jsc" forWebView:self.webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.navigationItem.title = @"Loading ...";
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.title = @"加载完成";
    
    __weak AUUJSCUIWebViewController *weakSelf = self;
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context[@"js_transfer_to_oc"] = ^(NSString *jsv){
        NSMutableString *res = [[NSMutableString alloc] init];
        [res appendFormat:@"直接读取的参数：\n%@", jsv];
        
        [res appendString:@"\n\n使用argument读取传参:\n"];
        NSArray *args = [JSContext currentArguments];
        for (NSString *v in args) {
            [res appendFormat:@"%@\n", v];
        }
        
        [weakSelf appendValue:res];
    };
}

- (void)sendValueToJS
{
    
#if 0
    JSValue *my_jsc = self.context[@"oc_transferValue_to_js"];
    JSValue *rev = [my_jsc callWithArguments:@[self.textfield.text]];
#else
    JSValue *rev = [self.context evaluateScript:[NSString stringWithFormat:@"oc_transferValue_to_js('%@')", self.textfield.text]];
#endif
    
    if (rev) {
        [self appendValue:[NSString stringWithFormat:@"OC调用JS后的返回值：%@", [rev toString]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
