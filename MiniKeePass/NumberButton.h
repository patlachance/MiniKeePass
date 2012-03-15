//
//  NumberButton.h
//  MiniKeePass
//
//  Created by John Flanagan on 3/12/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NumberButton : UIButton {
    CAGradientLayer *gradient;
    UILabel *primaryLabel;
    UILabel *subLabel;
}

@property (nonatomic, readonly) UILabel *primaryLabel;
@property (nonatomic, readonly) UILabel *subLabel;

@end
