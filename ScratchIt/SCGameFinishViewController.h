//
//  SCGameFinishViewController.h
//  ScratchIt
//
//  Created by Asad Rehman  on 9/21/12.
//  Copyright (c) 2012 Jinn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCGameFinishViewController : UIViewController<UITextFieldDelegate>{
    UITextField *fullName;
    UITextField *contactNumber;
    UITextField *address;
}
@property (retain,nonatomic) IBOutlet UITextField *fullName;
@property (retain,nonatomic) IBOutlet UITextField *contactNumber;
@property (retain,nonatomic) IBOutlet UITextField *address;

- (IBAction)submit:(id)sender;

@end
