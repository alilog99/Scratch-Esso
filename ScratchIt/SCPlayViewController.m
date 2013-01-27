//
//  SCPlayViewController.m
//  ScratchIt
//
//  Created by Jinn on 1/6/13.
//  Copyright (c) 2013 Jinn. All rights reserved.
//

#import "SCPlayViewController.h"
#import "SCGameFinishViewController.h"
@interface SCPlayViewController ()

@end

@implementation SCPlayViewController
@synthesize maskView;
@synthesize timer;
@synthesize firstTouchLocation;
@synthesize isMoving;
@synthesize continueButton;
@synthesize isEnd;
- (void)dealloc{
    [maskView release];
    maskView = nil;
    timer = nil;
    [continueButton release];
    [super dealloc];
    
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addCover];
    isMoving = FALSE;
    isEnd = FALSE;
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.5
                                             target: self
                                           selector: @selector(checkCollision:)
                                           userInfo: nil
                                            repeats: YES];
}


- (void)addCover{
    //152 , 93 , 293 , 153
    //1136
    CGRect completeRect = CGRectZero;
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if (scale == 2.0f) {
            if (pixelHeight == 960.0f){
                completeRect = CGRectMake(152, 93, 293, 153);
            }
            
         //       resolution = UIDeviceResolution_iPhoneRetina35;
            else if (pixelHeight == 1136.0f){
            completeRect = CGRectMake(180, 93, 350, 153);
            }
           //     resolution = UIDeviceResolution_iPhoneRetina4;
            
        } else if (scale == 1.0f && pixelHeight == 480.0f){
            completeRect = CGRectMake(152, 93, 293, 153);
        }
         //   resolution = UIDeviceResolution_iPhoneStandard;
        
    }
    UIImage * blurImage = [UIImage imageNamed:@"slayer.png"];
    //completeRect = CGRectMake(152, 93, 293, 153);
    maskView = [[ImageMaskView alloc] initWithFrame:completeRect image:blurImage];
	self.maskView.imageMaskFilledDelegate = self;
    self.maskView.tag = 1;
    [self.view addSubview:self.maskView];
  	maskView.imageMaskFilledDelegate = self;
    maskView.tag = 1;
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)imageMaskView:(ImageMaskView *)maskView cleatPercentWasChanged:(float)clearPercent {
	NSLog(@"percent: %.2f", clearPercent);
   // if(clearPercent >= 75.0){
     //   [self winGame];
   // }
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if (scale == 2.0f) {
            if (pixelHeight == 960.0f){
                NSLog(@"Retina");

                if(clearPercent >= 90.0){
                    [self winGame];
                }
            }
            
            //       resolution = UIDeviceResolution_iPhoneRetina35;
            else if (pixelHeight == 1136.0f){
                NSLog(@"IPHONE5");

                if(clearPercent >= 90.0){
                    [self winGame];
                }
            }
            //     resolution = UIDeviceResolution_iPhoneRetina4;
            
        } else if (scale == 1.0f && pixelHeight == 480.0f){
           
            NSLog(@"Retina-npn");
            if(clearPercent >= 90.0){
                [self winGame];
            }
        }
        //   resolution = UIDeviceResolution_iPhoneStandard;
        
    }

    
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        // Retina
                
        
    } else {
        
        
        // Not Retina
    }
    
    
   }

- (void)imageMaskViewScratchPosition:(CGPoint)point{
    
    if(isEnd){
        return;
    }
 //   NSLog(@"current point is x = %0.0f and y = %0.0f",point.x,point.y);
    if((point.x < 0) || point.y < 0){
        return;
    }
    if(!isMoving){
        if([self.maskView getMaskedValueforGCPoint:point] == 1){
        //    NSLog(@"point is filled");
        }else{
            [self generateFlakes:point andDirection:UI_TOUCH_DOWN];

          //  NSLog(@"point was not filled");
        }
    
    }
}


#pragma mark
#pragma flakes

- (void)generateFlakes:(CGPoint)currentPos andDirection:(Direction)direction{
    //    //152 , 93 , 293 , 153
    // 186 145
    // 75 and 59
    // 75 and 152
    firstTouchLocation = currentPos;
    CGSize size = CGSizeMake(293, 153);
    // CGPoint temp = fromUItoQuartz(currentPos, size);
  //  NSLog(@"current pos is x = %0.0f and y = %0.0f",currentPos.x,currentPos.y);
    CGPoint temp = CGPointMake(currentPos.x+152,  size.height - currentPos.y);
 //     CGPoint temp = CGPointMake(currentPos.x+152,  currentPos.y + 153);
  //  NSLog(@"temp is x = %0.0f and y =  %0.0f",temp.x, temp.y);
    for (int i=0; i<6; i++) {
        NSString *imgName = @"";
        if(i == 0){
            imgName = kFlakeOne;
        }else if(i== 1){
            imgName = kFlakeTwo;
        }
        UIImageView *flakeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
         CGPoint cen = CGPointMake(temp.x, temp.y + 92);
        flakeImg.center =cen;
        flakeImg.tag = 100;
        [self.view addSubview:flakeImg];
        [flakeImg release];
        [UIView beginAnimations:nil context:flakeImg];
        [UIView setAnimationDuration:0.5];
        // code to get current position of image on view
        CGFloat x = 0.0;
        CGFloat y = 0.0;
        x = (CGFloat) (arc4random() %  50);
        y = (CGFloat) (arc4random() %  100);
        if(direction == UI_TOUCH_DOWN){
            flakeImg.center = CGPointMake(cen.x, cen.y+y);
         //   NSLog(@"TOUCH DOWN");
        }
    //    NSLog(@"the x is %0.f and y is %0.f",currentPos.x,currentPos.y);
        
    //    NSLog(@"flake x is %0.f and y is %0.f",flakeImg.center.x,flakeImg.center.y);
        //   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
    }
    
    
    
}


#pragma mark - 

-(void) checkCollision: (NSTimer *) theTimer{

    NSArray *viewArray = [self.view subviews];
    
    //BOOL iscollision = NO;
    for (int j=0; j<[viewArray count]; j++) {
        for (int i=0; i<[viewArray count];i++ ) {
            if (j!=i) {
                UIView *view1= (UIView*)[viewArray objectAtIndex:i];
                UIView *view2 = (UIView*)[viewArray objectAtIndex:j];
                if((view1.tag == 100) && (view2.tag == 100)){
                if (CGRectIntersectsRect(view1.frame,view2.frame)) {
                   // NSLog(@"collision");
                    if(view1 != nil && view2 != nil){
                    CGPoint currentPos = view2.center;
            //        [UIView beginAnimations:nil context:view2];
            //        [UIView setAnimationDuration:0.5];
                    // code to get current position of image on view
                    CGFloat x = (CGFloat) (arc4random() %  5);
                    CGFloat y = (CGFloat) (arc4random() %  5);

                    view2.center = CGPointMake(currentPos.x-x, currentPos.y-y);
                 //   [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
                  //  [UIView setAnimationDelegate:self];
              //      [UIView commitAnimations];
                    [view1 removeFromSuperview];
                    [view2 removeFromSuperview];
                    }
                    break;

                }
                }

            }
        }
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  //  return;
  //    NSLog(@"touches moved");
    BOOL isleft= FALSE;
    BOOL isRight= FALSE;
    BOOL isUp= FALSE;
    BOOL isDown= FALSE;
    Direction touchDirection = UI_TOUCH_NO;;
    UITouch *touch = [[event touchesForView:self.view] anyObject];
    CGPoint curLocatoin = [touch locationInView:self.view];
	CGPoint	previousLocation = [touch previousLocationInView:self.view];
    if (curLocatoin.x>previousLocation.x) {
        isRight=YES;
        touchDirection = UI_TOUCH_RIGHT;
    //    NSLog(@"touch moved in right direction");
    }
    if (curLocatoin.x<previousLocation.x) {
        
      //  NSLog(@"touch moved in left direction");
        isleft= YES;
        touchDirection = UI_TOUCH_LEFT;
    }
    if (curLocatoin.y>previousLocation.y) {
       // NSLog(@"touch moved in down direction");
        isDown=YES;
        touchDirection = UI_TOUCH_DOWN;
    }
    if (curLocatoin.y<previousLocation.y) {
        isUp= YES;
       // NSLog(@"touch movied in up direction");
        touchDirection = UI_TOUCH_UP;
    }
    
    
   // [self generateFlakes:curLocatoin andDirection:touchDirection];
    
    
    for (UIView *view in [self.view subviews])
    {
        if(view.tag != 100){
            isMoving = FALSE;
            return;
        }
        else{
            isMoving = TRUE;
        }
        if (isRight) {
            if (view.center.x < curLocatoin.x && view.center.x>firstTouchLocation.x && (view.center.y > curLocatoin.y-20)  &&  (view.center.y < curLocatoin.y+ 20)  ) {
                view.center= CGPointMake(view.center.x -(previousLocation.x-curLocatoin.x), view.center.y);
            }
            
        }
        if (isleft) {
            
            if (view.center.x > curLocatoin.x && view.center.x <firstTouchLocation.x && (view.center.y > curLocatoin.y-20)  &&  (view.center.y < curLocatoin.y+ 20)   ) {
                view.center= CGPointMake(view.center.x -(previousLocation.x-curLocatoin.x), view.center.y);
            }
        }
        if (isUp) {
            if (view.center.y> curLocatoin.y && view.center.y <firstTouchLocation.y && (view.center.x > curLocatoin.x-20)  &&  (view.center.x < curLocatoin.x+ 20) ) {
                view.center= CGPointMake(view.center.x, view.center.y -(previousLocation.y-curLocatoin.y));
            }
        }
        if (isDown) {
            if (view.center.y< curLocatoin.y && view.center.y >firstTouchLocation.y && (view.center.x > curLocatoin.x-20)  &&  (view.center.x < curLocatoin.x+ 20)) {
                view.center= CGPointMake(view.center.x, view.center.y -(previousLocation.y-curLocatoin.y));
            }
        }
        
        
    }
    
    
}



- (void)winGame{
    //[self disableGame];
    isEnd = YES;
    [self.maskView setUserInteractionEnabled:NO];
    [self.timer invalidate];
    [continueButton setEnabled:YES];
    UIAlertView *codeError = [[UIAlertView alloc] initWithTitle:APPLICATION_TITLE message:WIN_GAME delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitles:nil, nil];
        [codeError show];
        [codeError release];
    
    
}


- (IBAction)loadEnd:(id)sender{
    SCGameFinishViewController *gameFinish = [[SCGameFinishViewController alloc] initWithNibName:@"SCGameFinishViewController" bundle:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:gameFinish animated:YES];
    [gameFinish release];
}

-(NSUInteger)supportedInterfaceOrientations{
    NSLog(@"supported orientations");
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

- (BOOL)shouldAutorotate {
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)){
        return YES;
    }
    return FALSE;
}

@end
