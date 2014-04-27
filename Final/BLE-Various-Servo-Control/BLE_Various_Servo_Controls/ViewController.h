//
//  ViewController.h
//  BLE_Various_Servo_Controls
//
//  Created by GrownYoda on 4/17/14.
//  Copyright (c) 2014 YuryGitman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLE.h"

@interface ViewController : UIViewController <BLEDelegate>{

float globalRSSI;
    float globalX;
    float globalY;
}

/// BLE Instance
@property (strong, nonatomic) BLE *ble;


///  Interface Elements
//  Text Labels
@property (weak, nonatomic) IBOutlet UILabel *lblRSSI;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

//   Switches Actions
- (IBAction)bntConnect:(id)sender;
- (IBAction)swThrowDemo:(id)sender;

//   Switch Properties

@end
