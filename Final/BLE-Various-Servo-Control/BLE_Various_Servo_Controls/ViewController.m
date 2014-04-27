//
//  ViewController.m
//  BLE_Various_Servo_Controls
//
//  Created by GrownYoda on 4/17/14.
//  Copyright (c) 2014 YuryGitman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSTimer *rssiTimer;



- (void)viewDidLoad
{
    [super viewDidLoad];

    // RedBear Code, to start ble object.
    _ble = [[BLE alloc] init];
    [_ble controlSetup];
    _ble.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



////////////////////////////////////////
#pragma mark - BLE delegate
////////////////////////////////////////

// Connect button will call to this
- (IBAction)bntConnect:(id)sender
{
    if (_ble.activePeripheral)
        if(_ble.activePeripheral.state == CBPeripheralStateConnected)
        {
            [[_ble CM] cancelPeripheralConnection:[_ble activePeripheral]];
            return;
        }
    
    if (_ble.peripherals)
        _ble.peripherals = nil;
    
    [_ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [_spinner startAnimating];
}

-(void) connectionTimer:(NSTimer *)timer
{
    
    if (_ble.peripherals.count > 0)
    {
        [_ble connectPeripheral:[_ble.peripherals objectAtIndex:0]];
    }
    else
    {
        [_spinner stopAnimating];
    }
}

///   Called on Connect
-(void) bleDidConnect
{
    [_spinner stopAnimating];
    
    // Schedule to read RSSI every 1 sec.
    rssiTimer = [NSTimer scheduledTimerWithTimeInterval:(float)1.0 target:self selector:@selector(readRSSITimer:) userInfo:nil repeats:YES];
}

// When RSSI is changed, this will be called
-(void) bleDidUpdateRSSI:(NSNumber *) rssi
{
    static int localRSSI;
    localRSSI = [rssi intValue];
    
    globalRSSI = (localRSSI * -1)*1.3;
    
    _lblRSSI.text = rssi.stringValue;
    
}

-(void) readRSSITimer:(NSTimer *)timer
{
    [_ble readRSSI];
}

// When disconnected, this will be called
- (void)bleDidDisconnect
{
    [_spinner stopAnimating];
    [_lblRSSI setText:@"Not Connected"];
    
    [rssiTimer invalidate];
}

// When data is comming, this will be called
-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
    NSLog(@"Length: %d", length);
    
    // parse data, all commands are in 3-byte
    for (int i = 0; i < length; i+=3)
    {
        NSLog(@"0x%02X, 0x%02X, 0x%02X", data[i], data[i+1], data[i+2]);
        
        if (data[i] == 0x0A)
        {
     //       if (data[i+1] == 0x01)
    //            swDigitalIn.on = true;
     //       else
      //          swDigitalIn.on = false;
        }
        else if (data[i] == 0x0B)
        {
            UInt16 Value;
            Value = data[i+2] | data[i+1] << 8;
        }        
    }
}



////////////////////////////////////////
//  Send Servo Value as RSSI Value
// Control Servo Position by RSSI Siganl, or X, Y coords.
////////////////////////////////////////
// just Servo (0)
-(void)sendValueToServo:(NSNumber*) localValue
{
//    [_lblLogArea setText:@"sendValueToServo called"];
    UInt8 buf[3] = {0x03, 0x00, 0x00};
    
 //   [_lblLogArea setText:[NSString stringWithFormat:@"localValue: %@", localValue]];
    
    
    buf[1] = [localValue floatValue];
    buf[2] = (int)[localValue floatValue] >> 8;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [_ble write:data];
}

///  Servo1
-(void)sendValueToServo1:(NSNumber*) localValue
{
    NSLog(@"sendalueToServo");
    UInt8 buf[3] = {0x02, 0x00, 0x00};
    
    buf[1] = [localValue floatValue];
    buf[2] = (int)[localValue floatValue] >> 8;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [_ble write:data];
}


////////////////////////////////////////
///  Listen for Touches
////////////////////////////////////////



@end
