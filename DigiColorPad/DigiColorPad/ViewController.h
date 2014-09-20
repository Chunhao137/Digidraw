//
//  ViewController.h
//  DigiColorPad
//
//  Created by Chun Hao Wang on 11/9/13.
//  Copyright (c) 2013 Charles Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "Twitter/TWTweetComposeViewController.h"


@interface ViewController : UIViewController <SettingsViewControllerDelegate,UIActionSheetDelegate> {
    
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;
- (IBAction)pencilPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)settings:(id)sender;

@end
