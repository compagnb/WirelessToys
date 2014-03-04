//
//  XYZViewController.h
//  HeartBeatCharacter
//

//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>


@interface XYZViewController : UIViewController

//Stepper Button
@property (weak, nonatomic) IBOutlet UIStepper *myStepperValue;
- (IBAction)myStepperPressed:(id)sender;

//Progress Bar

@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;


@end
