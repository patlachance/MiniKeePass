//
//  UIWebViewControllerViewController.h
//  MiniKeePass
//
//  Created by John Flanagan on 3/8/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UISplitViewControllerDelegate> {
    UIWebView *webView;
}

- (void)loadUrl:(NSURL *)url;

@end
