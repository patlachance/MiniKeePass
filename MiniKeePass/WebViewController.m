
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
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backPressed)];
        UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(forwardPressed)];
        if ([self.navigationItem respondsToSelector:@selector(setRightBarButtonItems:)]) {
            // 5.0+
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:forwardButton, backButton, nil];
        } // TODO add these buttons to the bar in 4.0
        [backButton release];
        [forwardButton release];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(500, 0, 44, 44);
        [self.navigationController.navigationBar addSubview:activityIndicator];        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];        
    }
    return self;
}

- (void)keyboardWillShow:(id)sender {
    
}

- (void)backPressed {
    [webView goBack];
}

- (void)forwardPressed {
    [webView goForward];
}

- (void)loadUrl:(NSURL *)url {
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Passwords", nil);
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
//    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
//    self.masterPopoverController = nil;
}

@end
