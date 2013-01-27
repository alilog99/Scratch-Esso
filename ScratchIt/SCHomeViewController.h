//
//  SCHomeViewController.h
//  ScratchIt
//
//  Created by Asad Rehman  on 9/21/12.
//  Copyright (c) 2012 Jinn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCHomeViewController : UIViewController<UITextFieldDelegate>{
    UITextField *codeValue;
}
@property (retain,nonatomic) IBOutlet UITextField *codeValue;

- (IBAction)codeValue:(id)sender;
@end
