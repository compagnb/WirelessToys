//
//  ViewController.h
//  sharkRC_iOS
//
//  Created by compagnb on 4/26/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLE.h"

@interface ViewController : UIViewController <BLEDelegate>{

//Variables for later
    float globalRSSI;
    float globalX;
    float globalY;
}

//Labels
@property (weak, nonatomic) IBOutlet UILabel *lblCoordinates;
@property (weak, nonatomic) IBOutlet UILabel *lblRSSI;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *btnConnect;

//Actions
- (IBAction)btnConnect:(id)sender;

//BLE
@property (strong, nonatomic) BLE *ble;
@property CBUUID* myUUIB;



@end
