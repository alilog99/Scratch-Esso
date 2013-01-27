//
//  SCGamePlayViewController.h
//  ScratchIt
//
//  Created by Asad Rehman  on 9/18/12.
//  Copyright (c) 2012 Jinn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageMaskView.h"
#import "SCConstants.h"
@interface SCGamePlayViewController : UIViewController<ImageMaskFilledDelegate>{
    
    //First Row
    UIImageView *_imageView00;
    UIImageView *_imageView01;
    UIImageView *_imageView02;
    UIImageView *_imageView03;

    
    //Second Row
    UIImageView *_imageView10;
    UIImageView *_imageView11;
    UIImageView *_imageView12;
    UIImageView *_imageView13;
    
    //Third Row
    UIImageView *_imageView20;
    UIImageView *_imageView21;
    UIImageView *_imageView22;
    UIImageView *_imageView23;
    
    
    //Image Mask Views
    ImageMaskView *_maskView00;
  
    ImageMaskView *_maskView01;
    ImageMaskView *_maskView02;
    ImageMaskView *_maskView03;
    
    //row2
    ImageMaskView *_maskView10;
    ImageMaskView *_maskView11;
    ImageMaskView *_maskView12;
    ImageMaskView *_maskView13;

    //row 3
    ImageMaskView *_maskView20;
    ImageMaskView *_maskView21;
    ImageMaskView *_maskView22;
    ImageMaskView *_maskView23;
    
    //Prize Calculations
    int uniqueTapCount;
    int lastTapTag;
    int matchTag;
    int firstTap;
    BOOL isUnique;
    NSMutableArray *matchId;
    NSMutableArray *randomTags;
    int randomNumber;
    UIButton *continueButton;
    BOOL isDisplay;
    
    CGPoint firstTouchLocation;
    NSTimer *timer;

    
}
//First Row
@property(retain,nonatomic) UIImageView *imageView00;
@property(retain,nonatomic) UIImageView *imageView01;
@property(retain,nonatomic) UIImageView *imageView02;
@property(retain,nonatomic) UIImageView *imageView03;

//Second Row
@property(retain,nonatomic) UIImageView *imageView10;
@property(retain,nonatomic) UIImageView *imageView11;
@property(retain,nonatomic) UIImageView *imageView12;
@property(retain,nonatomic) UIImageView *imageView13;

//Third Row
@property(retain,nonatomic) UIImageView *imageView20;
@property(retain,nonatomic) UIImageView *imageView21;
@property(retain,nonatomic) UIImageView *imageView22;
@property(retain,nonatomic) UIImageView *imageView23;

//mask views


@property (retain,nonatomic) ImageMaskView *maskView00;
@property (retain,nonatomic) ImageMaskView *maskView01;
@property (retain,nonatomic) ImageMaskView *maskView02;
@property (retain,nonatomic) ImageMaskView *maskView03;

//row 2
@property (retain,nonatomic) ImageMaskView *maskView10;
@property (retain,nonatomic) ImageMaskView *maskView11;
@property (retain,nonatomic) ImageMaskView *maskView12;
@property (retain,nonatomic) ImageMaskView *maskView13;


//row 3

@property (retain,nonatomic) ImageMaskView *maskView20;
@property (retain,nonatomic) ImageMaskView *maskView21;
@property (retain,nonatomic) ImageMaskView *maskView22;
@property (retain,nonatomic) ImageMaskView *maskView23;



@property int uniqueTapCount;
@property int lastTapTag;
@property int matchTag;
@property int firstTap;
@property BOOL isUnique;
@property int randomNumber;
@property (retain,nonatomic) NSMutableArray *matchId;
@property (retain,nonatomic) NSMutableArray *randomTags;
@property (retain,nonatomic) UIButton *continuebutton;
@property BOOL isDisplay;
- (void)createFirstRow;
- (void)createSecondRow;
- (void)createThirdRow;
- (void)disableGame;

@end
