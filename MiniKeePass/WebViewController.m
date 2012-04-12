
//
//  UIWebViewControllerViewController.m
//  MiniKeePass
//
//  Created by John Flanagan on 3/8/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

#define ADDRESSBAR_HEIGHT 44.0f

@implementation WebViewController {
    UIToolbar *topBar;
    NSMutableArray *topBarItems;
}

@synthesize masterViewController;

- (id)init {
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        webView = [[SSWebView alloc] init];
        webView.scalesPageToFit = YES;
        webView.delegate = self;
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backPressed)];
        UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(forwardPressed)];
        UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadPressed)];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        CGSize size = self.view.frame.size;
        
        topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, ADDRESSBAR_HEIGHT)];
        topBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        addressBarTextField = [[SSAddressBarTextField alloc] initWithFrame:CGRectMake(0, 0, size.width - 30, 31.0f)];
        addressBarTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        addressBarTextField.delegate = self;
        UIBarButtonItem *addressBarItem = [[UIBarButtonItem alloc] initWithCustomView:addressBarTextField];
        addressBarItem.width = 500;

        topBarItems = [[NSMutableArray alloc] initWithObjects:addressBarItem, nil];
        topBar.items = topBarItems;
        [addressBarItem release];
        
        [self.view addSubview:topBar];
        
        UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, size.height - ADDRESSBAR_HEIGHT, size.width, ADDRESSBAR_HEIGHT)];
        bottomBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:bottomBar];

        bottomBar.items = [NSArray arrayWithObjects:backButton, spacer, reloadButton, spacer, forwardButton, nil];
        
        UIWebView *tempWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, ADDRESSBAR_HEIGHT, size.width, size.height - (2 * ADDRESSBAR_HEIGHT))];
        tempWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tempWebView.scalesPageToFit = YES;
        [self.view addSubview:tempWebView];
        
        
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [webView loadURLString:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [addressBarTextField resignFirstResponder];
    return YES;
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

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)newPopoverController
{
    barButtonItem.title = NSLocalizedString(@"Passwords", nil);
    [topBarItems insertObject:barButtonItem atIndex:0];
    topBar.items = topBarItems;
    popoverController = nil;
}

- (void)splitViewController:(UISplitViewController *)splitController popoverController:(UIPopoverController *)newPopoverController willPresentViewController:(UIViewController *)aViewController {
    popoverController = newPopoverController;    
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [topBarItems removeObject:barButtonItem];
    topBar.items = topBarItems;
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

#pragma mark - SSWebViewDelegate

- (void)webViewDidStartLoadingPage:(SSWebView *)aWebView {
	addressBarTextField.loading = YES;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	NSString *urlString = [[[webView lastRequest] mainDocumentURL] absoluteString];
	
	static NSRegularExpression *regularExpression = nil;
	if (!regularExpression) {
		regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^https?://" options:NSRegularExpressionCaseInsensitive error:nil];
	}
	
	NSString *addressBarUrlString = [regularExpression stringByReplacingMatchesInString:urlString options:0 range:NSMakeRange(0, [urlString length]) withTemplate:@""];
	addressBarTextField.text = addressBarUrlString;
}


- (void)webViewDidFinishLoadingPage:(SSWebView *)aWebView {
	addressBarTextField.loading = NO;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	if (title) {
//		_titleLabel.text = title;
	}
}


- (void)webView:(SSWebView *)aWebView didFailLoadWithError:(NSError *)error {
    addressBarTextField.loading = NO;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
