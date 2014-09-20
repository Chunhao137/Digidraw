//
//  SettingsViewController.m
//  DigiColorPad
//
//  Created by Chun Hao Wang on 11/10/13.
//  Copyright (c) 2013 Charles Wang. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize brush;
@synthesize opacity;
@synthesize delegate;
@synthesize red;
@synthesize green;
@synthesize blue;


    


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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeSettings:(id)sender {
    
    
    
    [self.delegate closeSettings:self];
}
- (IBAction)SliderChanged:(id)sender {
    
    UISlider*changedSlider=(UISlider*)sender;
    if(changedSlider==self.brushControl){
        
        self.brush = 70*self.brushControl.value;
        self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
        
        
    }else if(changedSlider ==self.opacityControl) {
        self.opacity = self.opacityControl.value;
        self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
    }else if(changedSlider==self.redControl){
        self.red=self.redControl.value/255.0;
        self.redLabel.text=[NSString stringWithFormat:@"Red: %d",(int)self.redControl.value];
    }else if (changedSlider==self.greenControl){
        self.green=self.greenControl.value/255.0;
        self.greenLabel.text=[NSString stringWithFormat:@"Green: %d",(int)self.greenControl.value];
        
    }else if (changedSlider==self.blueControl){
        self.blue=self.blueControl.value/255.0;
        self.blueLabel.text=[NSString stringWithFormat:@"Blue:%d", (int)self.blueControl.value];
    }
    
        UIGraphicsBeginImageContext(self.brushPreview.frame.size);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        
        UIGraphicsBeginImageContext(self.opacityPreview.frame.size);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(),20.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, self.opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.opacityPreview.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
}

-(void)viewWillAppear:(BOOL)animated{
    int redIntValue=self.red*255.0;
    self.redControl.value=redIntValue;
    [self SliderChanged:self.redControl];
    
    int greenIntValue=self.green*255.0;
    self.greenControl.value=greenIntValue;
    [self SliderChanged:self.greenControl];
    
    int blueIntValue=self.blue*255.0;
    self.blueControl.value=blueIntValue;
    [self SliderChanged:self.blueControl];
    
    self.brushControl.value=self.brush;
    [self SliderChanged:self.brushControl];
    
    self.opacityControl.value=self.opacity;
    [self SliderChanged:self.opacityControl];
    
}
@end
