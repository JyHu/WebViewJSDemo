//
//  AUUOriginalWKWebViewController.m
//  WebJSWithOC
//
//  Created by 胡金友 on 2016/12/10.
//  Copyright © 2016年 胡金友. All rights reserved.
//

#import "AUUOriginalWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface AUUOriginalWKWebViewController ()<WKScriptMessageHandler>

@property (retain, nonatomic) WKWebView *webview;

@end

@implementation AUUOriginalWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    [userController addScriptMessageHandler:self name:@"oc_method"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userController;
    
    self.webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    [self addWebView:self.webview];
    [self loadRequestWithFileName:@"wk_web_original" forWebView:self.webview];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    SEL selc = NSSelectorFromString([message.name stringByAppendingString:@":"]);
    if ([self respondsToSelector:selc]) {
        [self performSelector:selc withObject:message.body];
    }
    else
    {
        NSLog(@"方法没实现");
    }
}

- (void)oc_method:(NSString *)arg
{
    [self appendValue:[NSString stringWithFormat:@"从JS中传递过来的数据:\n%@", arg]];
}

- (void)sendValueToJS
{
    __weak AUUOriginalWKWebViewController *weakSelf = self;
    [self.webview evaluateJavaScript:[NSString stringWithFormat:@"oc_transferValue_to_js('%@')", self.textfield.text] completionHandler:^(id _Nullable value, NSError * _Nullable error) {
        if (!error) {
            [weakSelf appendValue:[NSString stringWithFormat:@"OC调用JS后回传的数据：\n%@", value]];
        }
    }];
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
