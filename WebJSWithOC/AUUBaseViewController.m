//
//  AUUBaseViewController.m
//  WebJSWithOC
//
//  Created by 胡金友 on 2016/12/9.
//  Copyright © 2016年 胡金友. All rights reserved.
//

#import "AUUBaseViewController.h"
#import <WebKit/WebKit.h>

@interface AUUBaseViewController ()

@property (retain, nonatomic) UIButton *button;

@property (retain, nonatomic) UILabel *label;

@property (retain, nonatomic) NSMutableString *valueFromJS;

@end

@implementation AUUBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.valueFromJS = [[NSMutableString alloc] init];
}

- (void)addWebView:(id)webview
{
    if ([webview isKindOfClass:[UIWebView class]])
    {
        ((UIWebView *)webview).translatesAutoresizingMaskIntoConstraints = NO;
    }
    else
    {
        ((WKWebView *)webview).translatesAutoresizingMaskIntoConstraints = NO;
    }
    [self.view addSubview:webview];
    
    UIView *inputContentView = [[UIView alloc] init];
    inputContentView.translatesAutoresizingMaskIntoConstraints = NO;
    inputContentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:inputContentView];
    
    self.textfield = [[UITextField alloc] init];
    self.textfield.translatesAutoresizingMaskIntoConstraints = NO;
    self.textfield.backgroundColor = [UIColor blueColor];
    self.textfield.textColor = [UIColor whiteColor];
    [inputContentView addSubview:self.textfield];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button addTarget:self action:@selector(sendValueToJS) forControlEvents:UIControlEventTouchUpInside];
    [self.button setBackgroundColor:[UIColor blueColor]];
    [self.button setTitle:@"Transfer" forState:UIControlStateNormal];
    [inputContentView addSubview:self.button];
    
    self.label = [[UILabel alloc] init];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.numberOfLines = 0;
    [inputContentView addSubview:self.label];
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(inputContentView, _textfield, _button, webview, _label);
    
    NSArray *vfls = @[
                      @"V:|-0-[webview]-0-[inputContentView(webview)]-0-|",
                      @"H:|-0-[webview]-0-|",
                      @"H:|-0-[inputContentView]-0-|",
                      @"H:|-5-[_textfield]-5-[_button(44)]-5-|",
                      @"V:|-5-[_textfield(30)]-5-[_label]",
                      @"V:|-5-[_button(30)]",
                      @"H:|-5-[_label]-5-|"
                      ];
    
    for (NSString *vfl in vfls) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:NSLayoutFormatDirectionMask metrics:nil views:dict]];
    }
}

- (void)loadRequestWithFileName:(NSString *)fname forWebView:(id)webview
{
    NSURL *hurl = [[NSBundle mainBundle] URLForResource:fname withExtension:@"html"];
    NSString *str = [[NSString alloc] initWithContentsOfURL:hurl encoding:NSUTF8StringEncoding error:nil];
    if ([webview isKindOfClass:[UIWebView class]])
    {
        [(UIWebView *)webview loadHTMLString:str baseURL:hurl];
    }
    else
    {
        [(WKWebView *)webview loadHTMLString:str baseURL:hurl];
    }
}

- (void)appendValue:(NSString *)value
{
    if (value)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.valueFromJS appendString:value];
            [self.valueFromJS appendString:@"\n"];
            self.label.text = self.valueFromJS;
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
