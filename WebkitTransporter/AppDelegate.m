//
//  AppDelegate.m
//  WebkitTransporter
//
//  Created by 胡金友 on 2018/9/5.
//  Copyright © 2018年 胡金友. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSWindowController *windowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSWindowStyleMask mask = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable;
    NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 720, 420) styleMask:mask backing:NSBackingStoreBuffered defer:NO];
    window.minSize = NSMakeSize(720, 400);
    window.contentViewController = [[TestViewController alloc] init];
    [window center];
    self.windowController = [[NSWindowController alloc] initWithWindow:window];
    [self.windowController showWindow:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
