//
//  simpleViewerViewController.h
//  simpleViewer
//
//  Copyright (c) 2012年 Hozumi Kaneko. All rights reserved.
//  MIT License
//

#import <UIKit/UIKit.h>

@interface simpleViewerViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIWebViewDelegate>
{
    UIWebView *pageWebView;
    int pageNo, pageState;
}
- (UIViewController *)viewControllerAtIndex;

@end
