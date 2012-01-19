//
//  simpleViewerAppDelegate.h
//  simpleViewer
//  Copyright (c) 2012年 Hozumi Kaneko. All rights reserved.
//  MIT License
//

#import <UIKit/UIKit.h>

@class simpleViewerViewController;

@interface simpleViewerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) simpleViewerViewController *viewController;

@end
