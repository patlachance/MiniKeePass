//
//  NumberButton.m
//  MiniKeePass
//
//  Created by John Flanagan on 3/12/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import "NumberButton.h"

@implementation NumberButton

@synthesize primaryLabel;
@synthesize subLabel;

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 88, 49)];
    if (self) {
        primaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 88, 20)];
        subLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, 88, 10)];
        
        primaryLabel.text = @"";
        primaryLabel.textColor = [UIColor whiteColor];
        primaryLabel.font = [UIFont systemFontOfSize:24.0f];
        primaryLabel.textAlignment = UITextAlignmentCenter;
        primaryLabel.backgroundColor = [UIColor clearColor];
        subLabel.text = @"";
        subLabel.textColor = [UIColor lightGrayColor];
        subLabel.font = [UIFont systemFontOfSize:11.0f];
        subLabel.textAlignment = UITextAlignmentCenter;
        subLabel.backgroundColor = [UIColor clearColor];
        
        gradient = [CAGradientLayer layer];
        gradient.anchorPoint = CGPointMake(0.0f, 0.0f);
        gradient.position = CGPointMake(0.0f, 0.0f);
        gradient.bounds = self.layer.bounds;
        gradient.cornerRadius = 5.0f;
        gradient.colors = [NSArray arrayWithObjects: (id)[UIColor darkGrayColor].CGColor, (id)[UIColor blackColor].CGColor, nil];
        [self.layer addSublayer:gradient];
        
        [self addSubview:primaryLabel];
        [self addSubview:subLabel];
        
        [primaryLabel release];
        [subLabel release];
        
        self.showsTouchWhenHighlighted = YES;
    }
    return self;
}

@end
