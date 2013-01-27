//
//  SCGamePlayViewController.m
//  ScratchIt
//
//  Created by Asad Rehman  on 9/18/12.
//  Copyright (c) 2012 Jinn. All rights reserved.
//
//0 , 0 , 290 , 235
//
#import "SCGamePlayViewController.h"
#import "SCConstants.h"
#import "SCGameFinishViewController.h"
#import "PointTransforms.h"

@interface SCGamePlayViewController ()

@end

static int launchCount = 0;
@implementation SCGamePlayViewController
//first row
@synthesize imageView00 = _imageView00;
@synthesize imageView01 = _imageView01;
@synthesize imageView02 = _imageView02;
@synthesize imageView03 = _imageView03;
//second
@synthesize imageView10 = _imageView10;
@synthesize imageView11 = _imageView11;
@synthesize imageView12 = _imageView12;
@synthesize imageView13 = _imageView13;
//third
@synthesize imageView20 = _imageView20;
@synthesize imageView21 = _imageView21;
@synthesize imageView22 = _imageView22;
@synthesize imageView23 = _imageView23;


@synthesize maskView00 = _maskView00;
@synthesize maskView01 = _maskView01;
@synthesize maskView02 = _maskView02;
@synthesize maskView03 = _maskView03;


@synthesize maskView10 = _maskView10;
@synthesize maskView11 = _maskView11;
@synthesize maskView12 = _maskView12;
@synthesize maskView13 = _maskView13;

@synthesize maskView20 = _maskView20;
@synthesize maskView21 = _maskView21;
@synthesize maskView22 = _maskView22;
@synthesize maskView23 = _maskView23;

@synthesize uniqueTapCount;
@synthesize lastTapTag;
@synthesize matchTag;
@synthesize firstTap;
@synthesize matchId;
@synthesize isUnique;
@synthesize randomTags;
@synthesize randomNumber;
@synthesize continuebutton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Scratch To Win";
    uniqueTapCount = 0;
    lastTapTag = -1;
    matchTag = 0;
    firstTap = 0;
    isUnique = FALSE;
    randomNumber = 0;
    isDisplay = FALSE;
    self.view.backgroundColor = [UIColor blueColor];
    self.matchId = [NSMutableArray arrayWithCapacity:1];
    self.randomTags = [NSMutableArray arrayWithCapacity:1];
    [self appLaunch];
    [self createFirstRow];
    [self createSecondRow];
    [self createThirdRow];
    [self createRandomTags];
    [self addCover];
    [self addCountinueButton];
    launchCount++;

}

- (void)appLaunch{
    
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    NSInteger appLaunch = [userdef integerForKey:@"LaunchCount"];
    appLaunch = appLaunch + 1;
    [userdef setInteger:appLaunch forKey:@"LaunchCount"];
}


- (int)appCount{
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    NSInteger appLaunch = [userdef integerForKey:@"LaunchCount"];
    
    return appLaunch;
}

- (void)addCountinueButton{
    //continuebutton = [[UIButton alloc] initWithFrame:CGRectMake(380, 200, 80, 22)];
    continuebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [continuebutton setFrame:CGRectMake(380, 200, 80, 22)];
    [continuebutton setTitle:@"Contiune" forState:UIControlStateNormal];
    [continuebutton setEnabled:FALSE];
    [continuebutton addTarget:self action:@selector(loadEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:continuebutton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// add random tags
- (void)createRandomTags{
    

    self.maskView00.matchTag = 0;
    self.maskView01.matchTag = 0;
    self.maskView02.matchTag = 0;
    self.maskView03.matchTag = 0;


    self.maskView10.matchTag = 0;
    self.maskView11.matchTag = 0;
    self.maskView12.matchTag = 0;
    self.maskView13.matchTag = 0;
    
    
    self.maskView20.matchTag = 0;
    self.maskView21.matchTag = 0;
    self.maskView22.matchTag = 0;
    self.maskView23.matchTag = 0;
    
    
    randomNumber = 0;
    if([self appCount] % 3 == 0){
        randomNumber = 3;
    }else{
        randomNumber = 2;
    }

    UIImage *prizeImage = [UIImage imageNamed:@"car.jpeg"];
    for(int i = 0 ; i < randomNumber ; i++){
        int check = 0;
        while(check == 0){
        int tagValue = [self getRandWithMin:1 andMax:12];
        if(![self checkRandom:tagValue]){
            [randomTags addObject:[NSNumber numberWithInt:tagValue]];
            NSString *stringInt = [NSString stringWithFormat:@"%d9",tagValue];
            ImageMaskView *tagView = (ImageMaskView*)[self.view viewWithTag:tagValue];
            UIImageView *imageView = (UIImageView*)[self.view viewWithTag:[stringInt intValue]];
            tagView.matchTag = 90;
            [imageView setImage:prizeImage];
            stringInt = @"";
            check = 1;
         //   NSLog(@"the tempView is %d",tagView.matchTag);

        }else{
            check = 0;
           // NSLog(@"Old value found in check");
        }
          // NSLog(@"tag value is %d",tagValue);
        }
     
    }

}


-(int)getRandWithMin:(int)min andMax:(int)max
{
    int range = (max - min);
    int rand = (arc4random() % (range + 1)) + min;
    return rand;
}

- (void)addCover{
    UIImage * blurImage = [UIImage imageNamed:@"front@2x.png"];
    CGRect completeRect = CGRectMake(72, 20, 290, 235);
    self.maskView00 = [[ImageMaskView alloc] initWithFrame:completeRect image:blurImage];
	self.maskView00.imageMaskFilledDelegate = self;
    self.maskView00.tag = 1;
    [self.view addSubview:self.maskView00];
}

- (void)createFirstRow{
    UIImage * blurImage = [UIImage imageNamed:@"blur_4.png"];
    UIImage * codeImage = [UIImage imageNamed:@"close.jpeg"];
    CGRect completeRect = CGRectMake(72, 20, 310, 235
                                     );
    
    CGRect maskViewRect =CGRectMake(72, 20, 64, 64);
    self.imageView00 = [[UIImageView alloc] initWithFrame:maskViewRect];
    [self.imageView00 setImage:codeImage];
    self.maskView00 = [[ImageMaskView alloc] initWithFrame:completeRect image:blurImage];
	self.maskView00.imageMaskFilledDelegate = self;
    self.maskView00.tag = 1;
    self.imageView00.tag = 19;
    [self.view addSubview:self.imageView00];
  //  [self.view addSubview:self.maskView00];
    
    CGRect maskViewRect01 = CGRectMake(142, 20, 64, 64);
    self.imageView01 = [[UIImageView alloc] initWithFrame:maskViewRect01];
    [self.imageView01 setImage:codeImage];
    self.maskView01 = [[ImageMaskView alloc] initWithFrame:maskViewRect01 image:blurImage];
	self.maskView01.imageMaskFilledDelegate = self;
    self.maskView01.tag = 2;
    self.imageView01.tag = 29;
    [self.view addSubview:self.imageView01];
    //[self.view addSubview:self.maskView01];
    
    CGRect maskViewRect02 = CGRectMake(210, 20, 64, 64);;
    self.imageView02 = [[UIImageView alloc] initWithFrame:maskViewRect02];
    [self.imageView02 setImage:codeImage];
    self.maskView02 = [[ImageMaskView alloc] initWithFrame:maskViewRect02 image:blurImage];
	self.maskView02.imageMaskFilledDelegate = self;
    self.maskView02.tag = 3;
    self.imageView02.tag = 39;
    [self.view addSubview:self.imageView02];
    //[self.view addSubview:self.maskView02];
    
    
    CGRect maskViewRect03 = CGRectMake(280, 20, 64, 64);
    self.imageView03 = [[UIImageView alloc] initWithFrame:maskViewRect03];
    [self.imageView03 setImage:codeImage];
    self.maskView03 = [[ImageMaskView alloc] initWithFrame:maskViewRect03 image:blurImage];
	self.maskView03.imageMaskFilledDelegate = self;
    self.maskView03.tag = 4;
    self.imageView03.tag = 49;
    [self.view addSubview:self.imageView03];
   // [self.view addSubview:self.maskView03];
    
}


- (void)createSecondRow{
    UIImage * blurImage = [UIImage imageNamed:@"blur_4.png"];
    UIImage * codeImage = [UIImage imageNamed:@"close.jpeg"];
    
    CGRect maskViewRect =CGRectMake(72, 103, 64, 64);
    self.imageView10 = [[UIImageView alloc] initWithFrame:maskViewRect];
    [self.imageView10 setImage:codeImage];
    self.maskView10 = [[ImageMaskView alloc] initWithFrame:maskViewRect image:blurImage];
	self.maskView10.imageMaskFilledDelegate = self;
    self.maskView10.tag = 5;
    self.imageView10.tag = 59;
    [self.view addSubview:self.imageView10];
   // [self.view addSubview:self.maskView10];
    
    CGRect maskViewRect11 = CGRectMake(142, 103, 64, 64);
    self.imageView11 = [[UIImageView alloc] initWithFrame:maskViewRect11];
    [self.imageView11 setImage:codeImage];
    self.maskView11 = [[ImageMaskView alloc] initWithFrame:maskViewRect11 image:blurImage];
	self.maskView11.imageMaskFilledDelegate = self;
    self.maskView11.tag = 6;
    self.imageView11.tag = 69;
    [self.view addSubview:self.imageView11];
   // [self.view addSubview:self.maskView11];
    
    CGRect maskViewRect12 = CGRectMake(210, 103, 64, 64);;
    self.imageView12 = [[UIImageView alloc] initWithFrame:maskViewRect12];
    [self.imageView12 setImage:codeImage];
    self.maskView12 = [[ImageMaskView alloc] initWithFrame:maskViewRect12 image:blurImage];
	self.maskView12.imageMaskFilledDelegate = self;
    self.maskView12.tag = 7;
    self.imageView12.tag = 79;
    [self.view addSubview:self.imageView12];
  //  [self.view addSubview:self.maskView12];
    
    
    CGRect maskViewRect13 = CGRectMake(280, 103, 64, 64);
    self.imageView13 = [[UIImageView alloc] initWithFrame:maskViewRect13];
    [self.imageView13 setImage:codeImage];
    self.maskView13 = [[ImageMaskView alloc] initWithFrame:maskViewRect13 image:blurImage] ;
	self.maskView13.imageMaskFilledDelegate = self;
    self.maskView13.tag = 8;
    self.imageView13.tag = 89;
    [self.view addSubview:self.imageView13];
  //  [self.view addSubview:self.maskView13];
}


- (void)createThirdRow{
    UIImage * blurImage = [UIImage imageNamed:@"blur_4.png"];
    UIImage * codeImage = [UIImage imageNamed:@"close.jpeg"];
    
    CGRect maskViewRect =CGRectMake(72, 189, 64, 64);
    self.imageView20 = [[UIImageView alloc] initWithFrame:maskViewRect];
    [self.imageView20 setImage:codeImage];
    self.maskView20 = [[ImageMaskView alloc] initWithFrame:maskViewRect image:blurImage] ;
	self.maskView20.imageMaskFilledDelegate = self;
    self.maskView20.tag = 9;
    self.imageView20.tag = 99;
    [self.view addSubview:self.imageView20];
  //  [self.view addSubview:self.maskView20];
    
    CGRect maskViewRect21 = CGRectMake(142, 184, 64, 64);
    self.imageView21 = [[UIImageView alloc] initWithFrame:maskViewRect21];
    [self.imageView21 setImage:codeImage];
    self.maskView21 = [[ImageMaskView alloc] initWithFrame:maskViewRect21 image:blurImage];
	self.maskView21.imageMaskFilledDelegate = self;
    self.maskView21.tag = 10;
    self.imageView21.tag = 109;
    [self.view addSubview:self.imageView21];
  //  [self.view addSubview:self.maskView21];
    
    CGRect maskViewRect22 = CGRectMake(210, 184, 64, 64);;
    self.imageView22 = [[UIImageView alloc] initWithFrame:maskViewRect22];
    [self.imageView22 setImage:codeImage];
    self.maskView22 = [[ImageMaskView alloc] initWithFrame:maskViewRect22 image:blurImage];
	self.maskView22.imageMaskFilledDelegate = self;
    self.maskView22.tag = 11;
    self.imageView22.tag = 119;
    [self.view addSubview:self.imageView22];
  //  [self.view addSubview:self.maskView22];
    
    
    CGRect maskViewRect23 = CGRectMake(280, 184, 64, 64);
    self.imageView23 = [[UIImageView alloc] initWithFrame:maskViewRect23];
    [self.imageView23 setImage:codeImage];
    self.maskView23 = [[ImageMaskView alloc] initWithFrame:maskViewRect23 image:blurImage] ;
	self.maskView23.imageMaskFilledDelegate = self;
    self.maskView23.tag = 12;
    self.imageView23.tag = 129;
    [self.view addSubview:self.imageView23];
  //  [self.view addSubview:self.maskView23];

}

#pragma mark - ImageMaskFilledDelegate

- (void)imageMaskView:(ImageMaskView *)maskView cleatPercentWasChanged:(float)clearPercent {
	//NSLog(@"percent: %.2f", clearPercent);
    
    if(clearPercent >= 53.0){
       
        if(randomNumber == 3){
   //         [self winGame];
        }else{
 //           [self gameOver];
        }
    }
    
    /*
    int tapTag = maskView.tag;
    if(lastTapTag == -1){
        lastTapTag = tapTag;
        firstTap = 1;
        uniqueTapCount++;
        isUnique = TRUE;
         NSLog(@"Unique tapcount is %d",uniqueTapCount   );
    }else if(lastTapTag != tapTag){
        lastTapTag = tapTag;
        uniqueTapCount++;
        firstTap = 2;
        isUnique = TRUE;
        NSLog(@"Unique tapcount is %d",uniqueTapCount   );
    }else if(lastTapTag == tapTag){
        isUnique = FALSE;
    }
    
    if(uniqueTapCount > 3){
        [self gameOver];
    }
    if(clearPercent >= 90.0 && maskView.matchTag == 90){
        NSLog(@"One unlocked");
        if(![self checkMatchId:maskView.tag]){
            matchTag = matchTag + 1;
            [self.matchId addObject:[NSNumber numberWithInt:maskView.tag]];
            NSLog(@"match ID added %d",maskView.tag);
        }else{
            NSLog(@"Match ID failed %d",maskView.tag);
        }
    
    }
    if(matchTag == 3){
        NSLog(@"3 images matched u r winnder");
        [self winGame];
    }*/
}

- (void)imageMaskViewScratchPosition:(CGPoint)point{
    
    [self generateFlakes:point andDirection:UI_TOUCH_DOWN];

}

- (void)winGame{
    //[self disableGame];
    
    [continuebutton setEnabled:YES];
    if(!isDisplay){
    UIAlertView *codeError = [[UIAlertView alloc] initWithTitle:APPLICATION_TITLE message:WIN_GAME delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitles:nil, nil];
    [codeError show];
    [codeError release];
        isDisplay= YES;
    }
    
    
}

- (void)loadEnd{
    SCGameFinishViewController *gameFinish = [[SCGameFinishViewController alloc] initWithNibName:@"SCGameFinishViewController" bundle:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:gameFinish animated:YES];
    [gameFinish release];
}

- (void)gameOver{
   // [self disableGame];
    UIAlertView *codeError = [[UIAlertView alloc] initWithTitle:APPLICATION_TITLE message:LOST_GAME delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitles:nil, nil];
    [codeError show];
    [codeError release];
        [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)checkMatchId:(int)matchTagValue{
    
    for(int i = 0 ; i < [matchId count]; i++)
    {
        int value = [[matchId objectAtIndex:i] intValue];
        if(value == matchTagValue){
           
            return TRUE;
        }
    }
    
    return FALSE;
}

- (BOOL)checkRandom:(int)randomTagValue{
    
    for(int i = 0 ; i < [randomTags count]; i++)
    {
        int value = [[randomTags objectAtIndex:i] intValue];
        if(value == randomTagValue){
            
            return TRUE;
        }
    }
    
    return FALSE;
}


- (void)dealloc{
    //first row
    [self.imageView00 release];
    [self.imageView01 release];
    [self.imageView02 release];
    [self.imageView03 release];
    
    //second row
    [self.imageView10 release];
    [self.imageView11 release];
    [self.imageView12 release];
    [self.imageView13 release];
    
    //third row
    [self.imageView20 release];
    [self.imageView21 release];
    [self.imageView22 release];
    [self.imageView23 release];
    
    [self.maskView00 release];
    [self.maskView01 release];
    [self.maskView02 release];
    [self.maskView03 release];
    
    [self.maskView10 release];
    [self.maskView11 release];
    [self.maskView12 release];
    [self.maskView13 release];
    
    [self.maskView20 release];
    [self.maskView21 release];
    [self.maskView22 release];
    [self.maskView23 release];
    
    [matchId release];
    [randomTags release];
    [super dealloc];
}

- (void)disableGame{

    [self.maskView00 setUserInteractionEnabled:NO];
    [self.maskView01 setUserInteractionEnabled:NO];
    [self.maskView02 setUserInteractionEnabled:NO];
    [self.maskView03 setUserInteractionEnabled:NO];
    
    //second row
    [self.maskView10 setUserInteractionEnabled:NO];
    [self.maskView11 setUserInteractionEnabled:NO];
    [self.maskView12 setUserInteractionEnabled:NO];
    [self.maskView13 setUserInteractionEnabled:NO];
    //third row
    [self.maskView20 setUserInteractionEnabled:NO];
    [self.maskView21 setUserInteractionEnabled:NO];
    [self.maskView22 setUserInteractionEnabled:NO];
    [self.maskView23 setUserInteractionEnabled:NO];
}


- (void)enableGame{

    [self.maskView00 setUserInteractionEnabled:YES];
    [self.maskView01 setUserInteractionEnabled:YES];
    [self.maskView02 setUserInteractionEnabled:YES];
    [self.maskView03 setUserInteractionEnabled:YES];
    
    //second row
    [self.maskView10 setUserInteractionEnabled:YES];
    [self.maskView11 setUserInteractionEnabled:YES];
    [self.maskView12 setUserInteractionEnabled:YES];
    [self.maskView13 setUserInteractionEnabled:YES];
    //third row
    [self.maskView20 setUserInteractionEnabled:YES];
    [self.maskView21 setUserInteractionEnabled:YES];
    [self.maskView22 setUserInteractionEnabled:YES];
    [self.maskView23 setUserInteractionEnabled:YES];


}


#pragma mark
#pragma flakes

- (void)generateFlakes:(CGPoint)currentPos andDirection:(Direction)direction{
    //0 , 0 , 290 , 235
    //72, 20, 290 , 235
    //
    firstTouchLocation = currentPos;
    CGSize size = CGSizeMake(290, 235);
   // CGPoint temp = fromUItoQuartz(currentPos, size);
    CGPoint temp = CGPointMake(currentPos.x+72,  size.height - currentPos.y);

    for (int i=0; i<1; i++) {
        NSString *imgName = @"";
        if(i == 0){
            imgName = @"sb1.png";
        }else if(i== 1){
            imgName = @"sb2.png";
        }
        UIImageView *flakeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
       // CGPoint cen = CGPointMake(currentPos.x, currentPos.y);
        flakeImg.center =temp;
        [self.view addSubview:flakeImg];
        [flakeImg release];
        [UIView beginAnimations:nil context:flakeImg];
        [UIView setAnimationDuration:0.5];
        // code to get current position of image on view
        CGFloat x = 0.0;
        CGFloat y = 0.0;
        x = (CGFloat) (arc4random() %  50);
        y = (CGFloat) (arc4random() %  50);
        if(direction == UI_TOUCH_DOWN){
            flakeImg.center = CGPointMake(temp.x+3, temp.y+y);
        //    NSLog(@"TOUCH DOWN");
        }else if(direction == UI_TOUCH_UP){
            flakeImg.center = CGPointMake(currentPos.x+3, currentPos.y-y);
        }else if(direction == UI_TOUCH_RIGHT){
            flakeImg.center = CGPointMake(currentPos.x+x, currentPos.y+3);
        }else if(direction == UI_TOUCH_LEFT){
            flakeImg.center = CGPointMake(currentPos.x-x, currentPos.y+3);
            
        }
    //    NSLog(@"the x is %0.f and y is %0.f",currentPos.x,currentPos.y);
        
      //  NSLog(@"rand x is %0.f and y is %0.f",flakeImg.center.x,flakeImg.center.y);
      //   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
    }
    
    
    
}



/**
 CGFloat x = 0.0;
 CGFloat y = 0.0;
 x = (CGFloat) (arc4random() %  50);
 y = (CGFloat) (arc4random() %  50);
 if(direction == UI_TOUCH_DOWN){
 flakeImg.center = CGPointMake(currentPos.y, currentPos.x);
 NSLog(@"TOUCH DOWN");
 }else if(direction == UI_TOUCH_UP){
 flakeImg.center = CGPointMake(currentPos.x+3, currentPos.y-y);
 }else if(direction == UI_TOUCH_RIGHT){
 flakeImg.center = CGPointMake(currentPos.x+x, currentPos.y+3);
 }else if(direction == UI_TOUCH_LEFT){
 flakeImg.center = CGPointMake(currentPos.x-x, currentPos.y+3);
 
 }
 
 */

- (void)transitionDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    
    //  NSLog(@"%@",context);
    UIImageView *imgView= (UIImageView*)context;
    NSArray *viewArray = [self.view subviews];
    for (int j=0; j<[viewArray count]; j++) {
        UIImageView *view1= (UIImageView*)[viewArray objectAtIndex:j];
        if ( view1 != imgView ) {
            
            if (CGRectIntersectsRect(view1.frame,imgView.frame)) {
                CGPoint currentPos = view1.center;
                [UIView beginAnimations:nil context:view1];
                [UIView setAnimationDuration:0.5];
                view1.center = CGPointMake(currentPos.x-view1.frame.size.width, currentPos.y-view1.frame.size.height);
                [UIView setAnimationDelegate:self];
                [UIView commitAnimations];
                break;
                
                
            }
        }
    }
}


@end
