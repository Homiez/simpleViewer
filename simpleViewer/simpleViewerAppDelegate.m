//
//  simpleViewerAppDelegate.m
//  simpleViewer
//
//  Copyright (c) 2012年 Hozumi Kaneko. All rights reserved.
//  MIT License
//

#import "simpleViewerAppDelegate.h"
#import "simpleViewerViewController.h"

@implementation simpleViewerAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[simpleViewerViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
