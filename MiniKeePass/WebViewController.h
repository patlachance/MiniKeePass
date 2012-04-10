//
//  UIWebViewControllerViewController.h
//  MiniKeePass
//
//  Created by John Flanagan on 3/8/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SSToolkit-Framework/SSToolkit.h>
#import "MKPViewController.h"

@interface WebViewController : MKPViewController <UISplitViewControllerDelegate, UITextFieldDelegate, SSWebViewDelegate> {
    SSWebView *webView;
    SSAddressBarTextField *addressBarTextField;
    UIPopoverController *popoverController;
    UIActivityIndicatorView *activityIndicator;
}

- (void)loadUrl:(NSURL *)url;

@property (nonatomic, retain) UIViewController *masterViewController;

@end
