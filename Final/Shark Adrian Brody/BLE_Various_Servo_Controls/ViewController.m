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
            [_lblLogArea setText:@"Trying To Connect"];
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
        
        for(int i = 0; i < _ble.peripherals.count; i++)
            
        {
            
            //////////////////////////////////////////////////////////
            
            //  PUT YOUR BLE SHEILD UUID HERE, Check DeBug Log Below For Available UUID's
            
            // example:  @"A1834B4A-CEF2-AD8B-A13F-20616683B36E";
            
            //////////////////////////////////////////////////////////
            
            
            NSString* myBlueSheildUUID = @"499B3151-EDCF-0482-D047-6921B647F065";
            
            CBPeripheral *p = [_ble.peripherals objectAtIndex:i];
            
            NSMutableString * pUUIDString = [[NSMutableString alloc] initWithFormat:@"%@",CFUUIDCreateString(NULL, p.UUID) ];
            
            
            
            if ([myBlueSheildUUID isEqualToString:pUUIDString]) {
                
                NSLog(@"\n\n++++++   Found your Perfered Device UUID of: %@\n\n", myBlueSheildUUID);
                
                [_ble connectPeripheral:[_ble.peripherals objectAtIndex:i]];
                
            }
            
            if (![myBlueSheildUUID isEqualToString:pUUIDString]) {
                
                NSLog(@"Found a Bluetooth Device, But doesn't match your UUID \n\n");
                
                
                
            }    }
    
    else
        
    {
        
        
      [_spinner stopAnimating];
        
    }
    
}


///   Called on Connect
-(void) bleDidConnect
{
    [_lblLogArea setText:@"ble Did Connect"];
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
    
    // Move Servo to RSSI Value
    if (_swRSSIProperty.on) {
        
        [self sendValueToServo:[NSNumber numberWithInt:globalRSSI]];
        [_lblLogArea setText:@"Did Update RSSI"];

        NSLog(@"DidUpdateRSSI");
    }
    
}

-(void) readRSSITimer:(NSTimer *)timer
{
    [_ble readRSSI];
}

// When disconnected, this will be called
- (void)bleDidDisconnect
{
    [_lblLogArea setText:@"ble Did Disconnect"];
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
            [_lblLogArea setText:[NSString stringWithFormat:@"%d", Value]];
        }        
    }
}



////////////////////////////////////////
///  Switches
////////////////////////////////////////

- (IBAction)swRSSItoServo:(id)sender {
    if (_swRSSIProperty.on) {
        NSLog(@"swRSSItoServo on");
  //      [_lblLogArea setText:@"Did Update RSSI"];
    
    }
    if (!_swRSSIProperty.on) {
        NSLog(@"off");
    }
}

- (IBAction)swXTouchesServo:(id)sender {
    if (_swXTouchPropery.on) {
        NSLog(@"on");
    }
    if (!_swXTouchPropery.on) {
        NSLog(@"off");
    }
}

- (IBAction)swYTouchesServo1:(id)sender {
    if (_swYTouchPropery.on) {
        NSLog(@"on");
    }
    if (!_swYTouchPropery.on) {
        NSLog(@"off");
    }
}

- (IBAction)swThrowDemo:(id)sender {
    if (_swArmThrowDemo.on) {
        [_lblLogArea setText:[NSString stringWithFormat:@"Throw!"]];
        [self sendValueToServo:[NSNumber numberWithInt:70]];
        [self sendValueToServo1:[NSNumber numberWithInt:150]];


    }
    if (!_swArmThrowDemo.on) {
        [_lblLogArea setText:[NSString stringWithFormat:@"Load Arm!"]];
        [self sendValueToServo:[NSNumber numberWithInt:155]];
        [self sendValueToServo1:[NSNumber numberWithInt:70]];
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
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
   
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    globalX = location.x / 2;  // scales 0-320 to roughly 0-180
    globalY = location.y / 3.3;  //scales 0-600 to roughly 0-180
    
    if (_swXTouchPropery.on) {
        
        [_lblLogArea setText:[NSString stringWithFormat:@"x touch: %f",globalX]];
        [self sendValueToServo:[NSNumber numberWithInt:globalX]];

        
    }
    
    if (_swYTouchPropery.on) {
          [_lblLogArea setText:[NSString stringWithFormat:@"y touch: %f",globalY]];
        [self sendValueToServo1:[NSNumber numberWithInt:globalY]];

    }
    
    
}


@end
