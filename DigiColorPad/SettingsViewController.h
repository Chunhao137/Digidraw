//
//  SettingsViewController.h
//  DigiColorPad
//
//  Created by Chun Hao Wang on 11/10/13.
//  Copyright (c) 2013 Charles Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingsViewControllerDelegate <NSObject>
-(void)closeSettings: (id) sender;

@end



@interface SettingsViewController : UIViewController
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;



@property CGFloat brush;
@property CGFloat opacity;
@property(nonatomic, weak)id<SettingsViewControllerDelegate> delegate;
- (IBAction)closeSettings:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *brushControl;
@property (weak, nonatomic) IBOutlet UISlider *opacityControl;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;

@property (weak, nonatomic) IBOutlet UIImageView *opacityPreview;
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabel;
- (IBAction)SliderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *redControl;
@property (weak, nonatomic) IBOutlet UISlider *greenControl;
@property (weak, nonatomic) IBOutlet UISlider *blueControl;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;

@end
