//
//  ViewController.h
//  HeartCharacterV2
//

//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface ViewController : UIViewController

//Declare stepper button
@property (weak, nonatomic) IBOutlet UIStepper *myStepperValue;

//Declare the stepper action - changing value
- (IBAction)myStepperPressed:(UIStepper *)sender;

//Declare progress bar
@property (weak, nonatomic) IBOutlet UIProgressView *lvlProgressbar;

@end
