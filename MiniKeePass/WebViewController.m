//
//  WebViewController.m
//  MiniKeePass
//
//  Created by Jason Rush on 1/25/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate> {
    UIWebView *_webView;
    UIBarButtonItem *_backButton;
    UIBarButtonItem *_forwardButton;
    UIBarButtonItem *_reloadButton;
    UIBarButtonItem *_openInButton;
    UIBarButtonItem *_autotypeUsernameButton;
    UIBarButtonItem *_autotypePasswordButton;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    self.title = @"Web";

    _webView = [[UIWebView alloc] init];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	_webView.backgroundColor = [UIColor whiteColor];
	_webView.delegate = self;
    _webView.keyboardDisplayRequiresUserAction = NO;
	[self.view addSubview:_webView];

    _backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                target:self
                                                                action:@selector(backPressed)];
    _backButton.enabled = NO;

    _forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                   target:self
                                                                   action:@selector(forwardPressed)];
    _forwardButton.enabled = NO;

    _reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                  target:self
                                                                  action:@selector(reloadPressed)];

    _openInButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                  target:self
                                                                  action:@selector(openInPressed)];

    UIBarButtonItem *spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil] autorelease];

    self.toolbarItems = @[_backButton, spacer, _forwardButton, spacer, _reloadButton, spacer, _openInButton];


    _autotypeUsernameButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                            target:self
                                                                            action:@selector(autotypeUsernamePressed)];

    _autotypePasswordButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                            target:self
                                                                            action:@selector(autotypePasswordPressed)];

    self.navigationItem.rightBarButtonItems = @[_autotypeUsernameButton, _autotypePasswordButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSURL *url = [NSURL URLWithString:self.entry.url];

    _webView.frame = self.view.bounds;
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)dealloc {
    [_entry release];
    [_webView release];
    [_backButton release];
    [_forwardButton release];
    [_reloadButton release];
    [_openInButton release];
    [super dealloc];
}

- (void)updateButtons {
    _backButton.enabled = _webView.canGoBack;
    _forwardButton.enabled = _webView.canGoForward;
}

- (void)backPressed {
    if (_webView.canGoBack) {
        [_webView goBack];
    }
}

- (void)forwardPressed {
    if (_webView.canGoForward) {
        [_webView goForward];
    }
}

- (void)reloadPressed {
    [_webView reload];
}

- (void)openInPressed {
    [[UIApplication sharedApplication] openURL:_webView.request.URL];
}

- (void)autotypeString:(NSString *)string {
    NSInteger n = [string length];
    NSInteger i;

    for (i = 0; i < n; i++) {
        NSString *script = [NSString stringWithFormat:@"var event = document.createEvent(\"KeyboardEvent\"); event.initKeyEvent(\"keypress\", true, true, window, 1, 0, 0, 0, 0, %d, %d); body.dispatchEvent(event);", [string characterAtIndex:i], [string characterAtIndex:i]];
        NSLog(@"Generating %d", [string characterAtIndex:i]);
        [_webView stringByEvaluatingJavaScriptFromString:script];
    }
}

- (void)autotypeUsernamePressed {
    [self autotypeString:self.entry.username];
}

- (void)autotypePasswordPressed {
    [self autotypeString:self.entry.password];
}

#pragma mark - WebView delegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self updateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self updateButtons];
}

@end
