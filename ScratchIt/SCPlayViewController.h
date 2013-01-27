//
//  SCPlayViewController.h
//  ScratchIt
//
//  Created by Jinn on 1/6/13.
//  Copyright (c) 2013 Jinn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageMaskView.h"
#import "SCConstants.h"

@interface SCPlayViewController : UIViewController<ImageMaskFilledDelegate>{
    
    ImageMaskView *maskView;
    NSTimer *timer;
    CGPoint firstTouchLocation;
    BOOL isMoving;
    UIButton *continueButton;
    BOOL isEnd;
}
@property (retain,nonatomic) ImageMaskView *maskView;
@property (retain,nonatomic) NSTimer *timer;
@property    CGPoint firstTouchLocation;
@property BOOL isMoving;
@property (retain,nonatomic) IBOutlet UIButton *continueButton;
@property BOOL isEnd;

- (IBAction)loadEnd:(id)sender;
@end
