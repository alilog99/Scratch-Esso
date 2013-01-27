//
//  SCHomeViewController.m
//  ScratchIt
//
//  Created by Asad Rehman  on 9/21/12.
//  Copyright (c) 2012 Jinn. All rights reserved.
//

#import "SCHomeViewController.h"
#import "SCGamePlayViewController.h"
#import "SCConstants.h"
#import "SCPlayViewController.h"
@interface SCHomeViewController ()

@end

@implementation SCHomeViewController
@synthesize codeValue;
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
    self.title = APPLICATION_TITLE;
    [self.navigationController setNavigationBarHidden:YES];
    [codeValue setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)codeValue:(id)sender{
    [codeValue resignFirstResponder];
    if([[codeValue text] isEqualToString:@"1234"]){
        NSLog(@"Code MAtch");
        
        SCPlayViewController *gamePlay = [[SCPlayViewController alloc] initWithNibName:@"SCPlayViewController" bundle:nil];
        [self.navigationController pushViewController:gamePlay animated:YES];
        [gamePlay release];
    }else{
        NSLog(@"Invalid Code. Please verify");
        UIAlertView *codeError = [[UIAlertView alloc] initWithTitle:APPLICATION_TITLE message:INVALID_CODE delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitles:nil, nil];
        [codeError show];
        [codeError release];
    }
    [codeValue setText:@""];
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
- (void)dealloc{
    [codeValue release];
    [super dealloc];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
