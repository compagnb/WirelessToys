//
//  ViewController.h
//  HeartCharacterV2
//

//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "BLE.h"

@interface ViewController : UIViewController
    <BLEDelegate>  //Make ViewController the BLE Delegate

//Declare stepper button
@property (weak, nonatomic) IBOutlet UIStepper *myStepperValue;

//Declare the stepper action - changing value
- (IBAction)myStepperPressed:(UIStepper *)sender;

//Declare progress bar
@property (weak, nonatomic) IBOutlet UIProgressView *lvlProgressbar;

////////////////////////////////////////
//            readBearLab  BLE
////////////////////////////////////////

// BLE Class Instance
@property (strong, nonatomic) BLE *readBearBLEinstance;

////////////////////////////////////////
//            BLE Interface Elements
////////////////////////////////////////

//Connect and disconnect button and action
@property (weak, nonatomic) IBOutlet UIButton *buttonBLEConnectDisconnect;
- (IBAction)BLEConnectDisconnectButtonPressed:(id)sender;

//activity circle
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorBLE;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewBLEsignal;

//BLE status message
@property (weak, nonatomic) IBOutlet UILabel *labelBLEMessageAndUUID;

//BLE Name
@property (weak, nonatomic) IBOutlet UILabel *labelBLEName;

////////////////////////////////////////
//            Arduino Interface
////////////////////////////////////////

//LED test button
@property (weak, nonatomic) IBOutlet UISwitch *testLEDProperty;
- (IBAction)swTestLed:(id)sender;

//Analog Pin Switch
@property (weak, nonatomic) IBOutlet UISwitch *ewAnalogPinProperty;
- (IBAction)swAnalogPinMonitor:(id)sender;


@end
