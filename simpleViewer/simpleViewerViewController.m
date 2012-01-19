//
//  simpleViewerViewController.m
//  simpleViewer
//
//  Copyright (c) 2012年 Hozumi Kaneko. All rights reserved.
//  MIT License
//

#import "simpleViewerViewController.h"
#import <QuartzCore/CALayer.h> 

@implementation simpleViewerViewController


- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController{
    pageState = -1;
    pageNo--;
    return [self viewControllerAtIndex];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:
(UIViewController *)viewController{
    pageState = 1;
    pageNo++;
   return [self viewControllerAtIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if (completed == FALSE) {
        NSLog(@"canceled turnning a page!");
        pageNo = pageNo - pageState;
        
        UIViewController *aViewController = [previousViewControllers lastObject];
        [aViewController.view addSubview:pageWebView];
        UIScrollView* webScrollView = [[pageWebView subviews] lastObject];
        webScrollView.contentOffset = CGPointMake(300*pageNo, 0);
          
    }
    pageState = 0;
}

- (UIViewController *)viewControllerAtIndex
{
    UIViewController *aViewController = [[UIViewController alloc] init];
    aViewController.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView* webScrollView = [[pageWebView subviews] lastObject];
    webScrollView.contentOffset = CGPointMake(300*pageNo, 0);
    [aViewController.view addSubview:pageWebView];
    
    
    UIGraphicsBeginImageContext(pageWebView.frame.size);
    [pageWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *dammyImageView = [[UIImageView alloc] initWithFrame:pageWebView.frame];
    dammyImageView.image = image;
    
    [aViewController.view insertSubview:dammyImageView atIndex:0];

    
    
    return aViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    pageNo = 0;
    pageState = 0;
    
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"769-h.htm"];
    NSString *rawHtml = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"rawHtml: %@", rawHtml);
    
    
    rawHtml = [rawHtml stringByReplacingOccurrencesOfString:@"</head>" withString:@"<style type=\"text/css\">body{margin:0;padding:0;height: 440px;-webkit-column-width: 300px;-webkit-column-gap: 0;}</style></head>"];
    
    pageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
    pageWebView.delegate = self;
    [pageWebView loadHTMLString:rawHtml baseURL:[NSURL fileURLWithPath:[[ NSBundle mainBundle ] resourcePath]]];
    
    UIScrollView* webScrollView = [[pageWebView  subviews] lastObject];
    if([webScrollView respondsToSelector:@selector(setScrollEnabled:)]){
        [webScrollView setScrollEnabled:NO]; 
    }
    
    [self.view addSubview:pageWebView];   
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageController.delegate = self;
    NSArray *viewControllers = [NSArray arrayWithObject:[self viewControllerAtIndex]];
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];    
    pageController.dataSource = self;
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    
    CGRect pageViewRect = self.view.bounds;
    pageController.view.frame = pageViewRect;
    
}



@end
