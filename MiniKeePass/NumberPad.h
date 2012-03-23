//
//  NumberPad.h
//  MiniKeePass
//
//  Created by John Flanagan on 3/13/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberButton.h"

@protocol NumberPadDelegate;

@interface NumberPad : UIView {
    id<NumberPadDelegate> delegate;    
}

@property (nonatomic, retain) id<NumberPadDelegate> delegate;

@end

@protocol NumberPadDelegate <NSObject>
- (void)numberPad:(NumberPad *)numberPad buttonPressed:(NumberButton *)button;
@end
