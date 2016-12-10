//
//  AUUBaseViewController.h
//  WebJSWithOC
//
//  Created by 胡金友 on 2016/12/9.
//  Copyright © 2016年 胡金友. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUUBaseViewController : UIViewController

- (void)addWebView:(id)webview;

- (void)loadRequestWithFileName:(NSString *)fname forWebView:(id)webview;

- (void)appendValue:(NSString *)value;

@property (retain, nonatomic) UITextField *textfield;

- (void)sendValueToJS;

@end
