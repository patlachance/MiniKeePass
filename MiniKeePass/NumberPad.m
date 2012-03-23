//
//  NumberPad.m
//  MiniKeePass
//
//  Created by John Flanagan on 3/13/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import "NumberPad.h"
#import "PinTextField.h"
#import <QuartzCore/QuartzCore.h>

#define X_ORIGIN 20.0f
#define Y_ORIGIN 150.0f
#define X_OFFSET 96.0f
#define Y_OFFSET 56.0f

@implementation NumberPad

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, 320.0f, 410.0f);
    self = [super initWithFrame:newFrame];
    if (self) {
        
        [self setBackgroundColor:[UIColor blackColor]];
        [self.layer setCornerRadius:20.0f];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.layer setBorderWidth:1.5f];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOpacity:0.8];
        [self.layer setShadowRadius:3.0];
        [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
        CGRect toolbarFrame = CGRectMake(0, 0, 320, 83);
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
        [toolbar setBarStyle:UIBarStyleBlack];
        toolbar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        toolbar.layer.borderWidth = 1.0;
        
        UILabel *toolbarText = [[UILabel alloc] initWithFrame:toolbarFrame];
        toolbarText.text = @"Enter PIN";
        toolbarText.textColor = [UIColor whiteColor];
        toolbarText.textAlignment = UITextAlignmentCenter;
        toolbarText.backgroundColor = [UIColor clearColor];
        toolbarText.font = [UIFont systemFontOfSize:30.0];
        [toolbar addSubview:toolbarText];
        [toolbarText release];
        
        PinTextField *pinTextField1 = [[PinTextField alloc] initWithFrame:CGRectMake(23, 100, 61, 52)];
        [self addSubview:pinTextField1];
        [pinTextField1 release];
        
        PinTextField *pinTextField2 = [[PinTextField alloc] initWithFrame:CGRectMake(94, 100, 61, 52)];
        [self addSubview:pinTextField2];
        [pinTextField2 release];
        
        PinTextField *pinTextField3 = [[PinTextField alloc] initWithFrame:CGRectMake(165, 100, 61, 52)];
        [self addSubview:pinTextField3];
        [pinTextField3 release];
        
        PinTextField *pinTextField4 = [[PinTextField alloc] initWithFrame:CGRectMake(236, 100, 61, 52)];
        [self addSubview:pinTextField4];
        [pinTextField4 release];
        
        [self addSubview:toolbar];
        [toolbar release];
        
        CGFloat x = X_ORIGIN;
        CGFloat y = Y_ORIGIN + 22;
        
        NumberButton *button1 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button1.primaryLabel.text = @"1";
        button1.subLabel.text = @"";
        x += X_OFFSET;
        
        NumberButton *button2 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button2.primaryLabel.text = @"2";
        button2.subLabel.text = @"ABC";
        x += X_OFFSET;
        
        NumberButton *button3 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button3.primaryLabel.text = @"3";
        button3.subLabel.text = @"DEF";
        x = X_ORIGIN;
        y += Y_OFFSET;
        
        NumberButton *button4 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button4 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button4.primaryLabel.text = @"4";
        button4.subLabel.text = @"GHI";
        x += X_OFFSET;
        
        NumberButton *button5 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button5 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button5.primaryLabel.text = @"5";
        button5.subLabel.text = @"JKL";
        x += X_OFFSET;
        
        NumberButton *button6 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button6 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button6.primaryLabel.text = @"6";
        button6.subLabel.text = @"MNO";
        x = X_ORIGIN;
        y += Y_OFFSET;
        
        NumberButton *button7 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button7 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button7.primaryLabel.text = @"7";
        button7.subLabel.text = @"PQRS";
        x += X_OFFSET;
        
        NumberButton *button8 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button8 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button8.primaryLabel.text = @"8";
        button8.subLabel.text = @"TUV";
        x += X_OFFSET;
        
        NumberButton *button9 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button9 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button9.primaryLabel.text = @"9";
        button9.subLabel.text = @"WXYZ";
        x = X_ORIGIN;
        y += Y_OFFSET;
        
        NumberButton *button10 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button10 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        x += X_OFFSET;
        
        NumberButton *button11 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button11 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        x += X_OFFSET;
        
        NumberButton *button12 = [[NumberButton alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
        [button12 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button1];
        [self addSubview:button2];
        [self addSubview:button3];
        [self addSubview:button4];
        [self addSubview:button5];
        [self addSubview:button6];
        [self addSubview:button7];
        [self addSubview:button8];
        [self addSubview:button9];
        [self addSubview:button10];
        [self addSubview:button11];
        [self addSubview:button12];
        [button1 release];
        [button2 release];
        [button3 release];
        [button4 release];
        [button5 release];
        [button6 release];
        [button7 release];
        [button8 release];
        [button9 release];
        [button10 release];
        [button11 release];
        [button12 release];
    }
    return self;
}

- (void)buttonPressed:(NumberButton *)button {
    if ([delegate respondsToSelector:@selector(numberPad:buttonPressed:)]) {
        [delegate numberPad:self buttonPressed:button];
    }
}

@end
