//
//  iPhonePinViewController.m
//  MiniKeePass
//
//  Created by John Flanagan on 3/22/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import "iPhonePinViewController.h"
#import "PinTextField.h"

@implementation iPhonePinViewController

- (id)initWithText:(NSString*)text {
    self = [super initWithText:text];
    if (self) {
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(320, 240, 0, 0)];
        textField.delegate = self;
        textField.hidden = YES;
        textField.secureTextEntry = YES;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        [self.view addSubview:textField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 96)];
        [toolbar setBarStyle:UIBarStyleBlackTranslucent];
        
        PinTextField *pinTextField1 = [[PinTextField alloc] initWithFrame:CGRectMake(23, 22, 61, 52)];
        [toolbar addSubview:pinTextField1];
        
        PinTextField *pinTextField2 = [[PinTextField alloc] initWithFrame:CGRectMake(94, 22, 61, 52)];
        [toolbar addSubview:pinTextField2];
        
        PinTextField *pinTextField3 = [[PinTextField alloc] initWithFrame:CGRectMake(165, 22, 61, 52)];
        [toolbar addSubview:pinTextField3];
        
        PinTextField *pinTextField4 = [[PinTextField alloc] initWithFrame:CGRectMake(236, 22, 61, 52)];
        [toolbar addSubview:pinTextField4];
        
        pinTextFields = [[NSArray arrayWithObjects:pinTextField1, pinTextField2, pinTextField3, pinTextField4, nil] retain];
        
        [pinTextField1 release];
        [pinTextField2 release];
        [pinTextField3 release];
        [pinTextField4 release];
        
        textField.inputAccessoryView = toolbar;
        [toolbar release];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 95)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = UITextAlignmentCenter;
        
        UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 95)];
        topBar.barStyle = UIBarStyleBlackTranslucent;
        [topBar addSubview:textLabel];
        
        [self.view addSubview:topBar];
        [topBar release];
    }
    
    return self;
}

@end
