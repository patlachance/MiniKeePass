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
        
        
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(dragEnter) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(dragExit) forControlEvents:UIControlEventTouchDragExit];
    }
    return self;
}

- (void)invertGradient {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.fromValue = [NSArray arrayWithObjects:(id)[UIColor darkGrayColor].CGColor, (id)[UIColor blackColor].CGColor, nil];
    animation.toValue = [NSArray arrayWithObjects:(id)[UIColor blackColor].CGColor, (id)[UIColor darkGrayColor].CGColor, nil];
    animation.duration = 0.1;
    [gradient addAnimation:animation forKey:@"animation"];
}

- (void)touchDown {
    NSLog(@"Touch Down");
    [self invertGradient];
}

- (void)touchUpInside {
    NSLog(@"Touch Up Inside");
    [self invertGradient];
}

- (void)dragEnter {
    NSLog(@"Drag Enter");
}

- (void)dragExit {
    NSLog(@"Drag Exit");    
}

@end
