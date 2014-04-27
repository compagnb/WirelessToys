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
@property CBUUID* myUUIB;


///  Interface Elements
//  Text Labels
@property (weak, nonatomic) IBOutlet UILabel *lblRSSI;
@property (weak, nonatomic) IBOutlet UILabel *lblLogArea;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

//   Switches Actions
- (IBAction)bntConnect:(id)sender;
- (IBAction)swRSSItoServo:(id)sender;
- (IBAction)swYTouchesServo1:(id)sender;
- (IBAction)swThrowDemo:(id)sender;
- (IBAction)swXTouchesServo:(id)sender;

//   Switch Properties
@property (weak, nonatomic) IBOutlet UISwitch *swRSSIProperty;
@property (weak, nonatomic) IBOutlet UISwitch *swYTouchPropery;
@property (weak, nonatomic) IBOutlet UISwitch *swXTouchPropery;
@property (weak, nonatomic) IBOutlet UISwitch *swArmThrowDemo;




@end
