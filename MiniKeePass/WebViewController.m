
//
//  UIWebViewControllerViewController.m
//  MiniKeePass
//
//  Created by John Flanagan on 3/8/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebViewController

@synthesize masterViewController;

- (id)init {
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        webView = [[UIWebView alloc] init];
        webView.scalesPageToFit = YES;
        webView.delegate = self;
        self.view = webView;
        
        UIBarButtonItem *javascriptButton = [[UIBarButtonItem alloc] initWithTitle:@"javascript" style:UIBarButtonItemStyleBordered target:self action:@selector(javascript)];
        self.navigationItem.rightBarButtonItem = javascriptButton;
        [javascriptButton release];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backPressed)];
        UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(forwardPressed)];
        UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadPressed)];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        self.toolbarItems = [NSArray arrayWithObjects:backButton, spacer, reloadButton, spacer, forwardButton, nil];
        [backButton release];
        [forwardButton release];
        [reloadButton release];
        [spacer release];

        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [defaultCenter addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    if ([popoverController isPopoverVisible]) {
        [popoverController dismissPopoverAnimated:NO];
    }
}

- (void)javascript {
    NSString *str = @"Kee";
    
    // The JS File   
    NSString *filePath  = [[NSBundle mainBundle] pathForResource:@"UIWebViewSearch" ofType:@"js" inDirectory:@""];
    NSData *fileData    = [NSData dataWithContentsOfFile:filePath];
    NSString *jsString  = [[NSMutableString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    [jsString release];
        
    // The JS Function
    NSString *startSearch   = [NSString stringWithFormat:@"uiWebview_HighlightAllOccurencesOfString('%@')", str];
    [webView stringByEvaluatingJavaScriptFromString:startSearch];
    
    // Search Occurence Count
    // uiWebview_SearchResultCount - is a javascript var
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"uiWebview_SearchResultCount"];
    
    NSLog(@"result: %@", result);
}

- (void)keyboardWillShow:(id)sender {
    
}

- (void)backPressed {
    [webView goBack];
}

- (void)forwardPressed {
    [webView goForward];
}

- (void)reloadPressed {
    [webView reload];
}

- (void)loadUrl:(NSURL *)url {
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webViewDidStartLoad:(UIWebView *)currentWebView {
    self.title = currentWebView.request.URL.absoluteString;
    [self activityIndicator:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)currentWebView {
    [self activityIndicator:NO];
}

// FIXME This needs some better name; possibly two methods
- (void)activityIndicator:(BOOL)more {
    static int counter = 0;
    if (more) {
        counter++;
    } else {
        counter = counter > 0 ? counter - 1 : 0;
    }
    
    if (counter > 0) {
        [activityIndicator startAnimating];
    } else {
        [activityIndicator stopAnimating];
    }
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)newPopoverController
{
    barButtonItem.title = NSLocalizedString(@"Passwords", nil);
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    popoverController = nil;
}

- (void)splitViewController:(UISplitViewController *)splitController popoverController:(UIPopoverController *)newPopoverController willPresentViewController:(UIViewController *)aViewController {
    popoverController = newPopoverController;    
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

@end
