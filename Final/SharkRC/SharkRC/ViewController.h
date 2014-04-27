//
//  ViewController.h
//  SharkRC
//
//  Created by compagnb on 4/26/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

//
//  ViewController.h
//  BlueRC
//
//  Created by user on 7/20/13.
//  Copyright (c) 2013 Scott Cheezem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JSAnalogStick.h"
#import "BLE.h"
@interface ViewController : UIViewController<JSAnalogStickDelegate,BLEDelegate>

    //joystick information
    @property (weak, nonatomic) IBOutlet UILabel *analogTextLabel;
    @property (weak, nonatomic) IBOutlet JSAnalogStick *analogStick;

    //BTE connect info
    @property (weak, nonatomic) IBOutlet UILabel *lblRSSI;;
    @property (weak, nonatomic) IBOutlet UIButton *btnConnect;
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indConnecting;

@property (nonatomic, strong) BLE *ble;

@end
