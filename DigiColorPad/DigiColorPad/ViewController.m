//
//  ViewController.m
//  DigiColorPad
//
//  Created by Chun Hao Wang on 11/9/13.
//  Copyright (c) 2013 Charles Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad

{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

- (IBAction)pencilPressed:(id)sender {
    
    UIButton*PressedButton=(UIButton*)sender;
    
    switch(PressedButton.tag)
    {
            case 0:
                red=0.0/255.0;
                green=0.0/255.0;
                blue=0.0/255.0;
                break;
            case 1:
                red=105.0/255.0;
                green=105.0/255.0;
                blue=105.0/255.0;
                break;
            case 2:
                red=255.0/255.0;
                green=0.0/255.0;
                blue=0.0/255.0;
                break;
            
            case 3:
                red=0.0/255.0;
                green=0.0/255.0;
                blue=255.0/255.0;
                break; 
        case 4:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
            
            
    }
    
}

- (IBAction)eraserPressed:(id)sender {
    red=255.0/255.0;
    green=255.0/255.0;
    blue=255.0/255.0;
    opacity=1.0; 
}

- (IBAction)reset:(id)sender {
    
    self.mainImage.image=nil;
}

- (IBAction)save:(id)sender {
    UIActionSheet*actionSheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Save to Camera Roll",@"Post to Twitter!", @"Post to Facebook", @"Cancel" ,nil];
    
    [actionSheet showInView:self.view];
}

- (IBAction)settings:(id)sender {
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SettingsViewController*settingVC=(SettingsViewController*)segue.destinationViewController;
    settingVC.delegate=self;
    settingVC.brush=brush;
    settingVC.opacity=opacity;
    settingVC.red=red;
    settingVC.green=green;
    settingVC.blue=blue; 
    
}

-(void)closeSettings:(id)sender{
    brush=((SettingsViewController*)sender).brush;
    opacity=((SettingsViewController*)sender).opacity;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)actionSheet:(UIActionSheet*) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        
        if (buttonIndex == 1)
        {
            Class tweeterClass = NSClassFromString(@"TWTweetComposeViewController");
            
            if(tweeterClass != nil) {   // check for Twitter integration
                
                // check Twitter accessibility and at least one account is setup
                if([TWTweetComposeViewController canSendTweet]) {
                    
                    UIGraphicsBeginImageContextWithOptions(_mainImage.bounds.size, NO,0.0);
                    [_mainImage.image drawInRect:CGRectMake(0, 0, _mainImage.frame.size.width, _mainImage.frame.size.height)];
                    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
                    // set initial text
                    [tweetViewController setInitialText:@"Check out this drawing I made from a tutorial on raywenderlich.com:"];
                    
                    // add image
                    [tweetViewController addImage:SaveImage];
                    tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult result) {
                        if(result == TWTweetComposeViewControllerResultDone) {
                            // the user finished composing a tweet
                        } else if(result == TWTweetComposeViewControllerResultCancelled) {
                            // the user cancelled composing a tweet
                        }
                        [self dismissViewControllerAnimated:YES completion:nil];
                    };
                    
                    [self presentViewController:tweetViewController animated:YES completion:nil];
                } else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure you have at least one Twitter account setup and your device is using iOS5" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                }
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You must upgrade to iOS5.0 in order to send tweets from this application" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            
        } else if(buttonIndex == 0) {
            
            UIGraphicsBeginImageContextWithOptions(_mainImage.bounds.size, NO, 0.0);
            [_mainImage.image drawInRect:CGRectMake(0, 0, _mainImage.frame.size.width, _mainImage.frame.size.height)];
            UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    
        else if (buttonIndex==2){
            UIGraphicsBeginImageContextWithOptions(_mainImage.bounds.size, NO,0.0);
            [_mainImage.image drawInRect:CGRectMake(0, 0, _mainImage.frame.size.width, _mainImage.frame.size.height)];
            UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            SLComposeViewController *mySLComposerSheet;
            
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
            {
                mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
                mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
         
                
                
                [mySLComposerSheet setInitialText:@"Test"]; //the message you want to post
                [mySLComposerSheet addImage:SaveImage]; //an image you could post
                //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
                [self presentViewController:mySLComposerSheet animated:YES completion:nil];
                
                
                    
                
               
            }
            
            [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Action Cancelled";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Post Successfull";
                        break;
                    default:
                        break;
                } //check if everythink worked properly. Give out a message on the state.
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }];
                      
            }
            
        }





- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

@end
