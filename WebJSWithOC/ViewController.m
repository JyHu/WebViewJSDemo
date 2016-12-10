//
//  ViewController.m
//  WebJSWithOC
//
//  Created by 胡金友 on 2016/12/9.
//  Copyright © 2016年 胡金友. All rights reserved.
//

#import "ViewController.h"
#import "AUUFuncTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSArray *tests;

@end

NSString *const mTitleKey = @"mTitleKey";
NSString *const sTitleKey = @"sTitleKey";
NSString *const dVCKey = @"dVCKey";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tests = @[
                   @{
                       mTitleKey : @"Original WebView",
                       sTitleKey : @"通过webview来进行JS交互",
                       dVCKey : @"AUUOriginalUIWebViewController"
                       },
                   @{
                       mTitleKey : @"JSCore + UIWebView",
                       sTitleKey : @"使用JavascriptCore来进行交互",
                       dVCKey : @"AUUJSCUIWebViewController"
                       },
                   @{
                       mTitleKey : @"Original WebKit",
                       sTitleKey : @"使用webkit原生的方法进行JS交互",
                       dVCKey : @"AUUOriginalWKWebViewController"
                       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reUsefulIdentifier = @"reUsefulIdentifier";
    AUUFuncTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUsefulIdentifier];
    
    if (!cell)
    {
        cell = [[AUUFuncTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reUsefulIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = self.tests[indexPath.row];
    
    cell.title = dict[mTitleKey];
    cell.subtitle = dict[sTitleKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class cls = NSClassFromString(self.tests[indexPath.row][dVCKey]);
    
    [self.navigationController pushViewController:[[cls alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
