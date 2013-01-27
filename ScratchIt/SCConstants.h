//
//  SCConstants.h
//  ScratchIt
//
//  Created by Asad Rehman  on 9/21/12.
//  Copyright (c) 2012 Jinn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APPLICATION_TITLE @"Scratch To Win"
#define INVALID_CODE @"Please enter a valid code to proceed."
#define OK_BUTTON @"OK"
#define WIN_GAME @"You have won the game."
#define LOST_GAME @"You have lost the game. Please try again later."
#define CLAIM_PRIZE @"We have received your information. We will contact you shortly"
#define kFlakeOne @"sb1.png"
#define kFlakeTwo @"sb2.png"
typedef enum UITouchDirection{
    UI_TOUCH_NO,
    UI_TOUCH_UP,
    UI_TOUCH_DOWN,
    UI_TOUCH_LEFT,
    UI_TOUCH_RIGHT
}Direction;