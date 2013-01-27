//
//  SCGameFinishViewController.m
//  ScratchIt
//
//  Created by Asad Rehman  on 9/21/12.
//  Copyright (c) 2012 Jinn. All rights reserved.
//

#import "SCGameFinishViewController.h"
#import "SCConstants.h"
@interface SCGameFinishViewController ()

@end

@implementation SCGameFinishViewController
@synthesize fullName ;
@synthesize contactNumber;
@synthesize address;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender{
    [fullName resignFirstResponder];
    [contactNumber resignFirstResponder];
    [address resignFirstResponder];
    [fullName setDelegate:self];
    [contactNumber setDelegate:self];
    [address setDelegate:self];
    
    UIAlertView *codeError = [[UIAlertView alloc] initWithTitle:APPLICATION_TITLE message:CLAIM_PRIZE delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitles:nil, nil];
    [codeError show];
    [codeError release];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [fullName resignFirstResponder];
    [contactNumber resignFirstResponder];
    [address resignFirstResponder];
    return YES;
}
- (void)dealloc{
    [fullName release];
    [contactNumber release];
    [address release];
    [super dealloc];
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
