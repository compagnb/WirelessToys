//
//  ViewController.m
//  sharkRC_iOS
//
//  Created by compagnb on 4/26/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end



@implementation ViewController

NSTimer *rssiTimer;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Red Bear Code Setting Up The BLE Object
    _ble = [[BLE alloc] init];
    [_ble controlSetup];
    _ble.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//--------------------------------------------------------------------------
//
#pragma mark - BLE delegate
//
//--------------------------------------------------------------------------

// Connect button calls this function
- (IBAction)btnConnect:(id)sender {
    
    // If there is an active BLE shield and it is connected continue...
    if (_ble.activePeripheral)
        if(_ble.activePeripheral.state == CBPeripheralStateConnected)
        {
            [[_ble CM] cancelPeripheralConnection:[_ble activePeripheral]];
            return;
        }
    // If there arent any, search for them
    if (_ble.peripherals)
        _ble.peripherals = nil;
    
    [_ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    // spin the think wheel
    [_spinner startAnimating];
}

// Where we connect to a specific UUID
-(void) connectionTimer:(NSTimer *)timer{
    
    if (_ble.peripherals.count >0)
        //as it searches for devices
        for (int i=0; i<_ble.peripherals.count; i++) {
            //put BLE UUID here
            NSString* myBlueShieldUUID = @"499B3151-EDCF-0482-D047-6921B647F065";
            //declares p
            CBPeripheral *p = [_ble.peripherals objectAtIndex:i];
            //converts UUID to a string
            NSMutableString * pUUIDString = [[NSMutableString alloc] initWithFormat:@"%@",CFUUIDCreateString(NULL, p.UUID) ];
            //Compares UUIDS found with myBlueShieldUUID
            //if it matches...
            if([myBlueShieldUUID isEqualToString:pUUIDString]){
                //Console it matches
                NSLog(@"\n\n++++++   Found your Perfered Device UUID of: %@\n\n", myBlueShieldUUID);
                //and connect
                [_ble connectPeripheral:[_ble.peripherals objectAtIndex:i]];
            }
            //if it doesnt match
            if (![myBlueShieldUUID isEqualToString:pUUIDString]){
                //Console the UUID that doesnt match
                //Also for debugging
                NSLog(@"Found a Bluetooth Device, But doesn't match your UUID \n\n");
            }
            
        }else{
            //Stop the spinner from animating
            [_spinner stopAnimating];
        }
}

// When its connected
-(void) bleDidConnect{
    //stop the think wheel from spinning
    [_spinner stopAnimating];
    //read the RSSI every 1 Second
    rssiTimer = [NSTimer scheduledTimerWithTimeInterval:(float)1.0 target:self selector:@selector (readRSSITimer:) userInfo:nil repeats:YES];
}

// When RSSI is changes
-(void) bleDidUpdateRSSI:(NSNumber *) rssi{
    //defining the RSSI Value
    static int localRSSI;
    localRSSI = [rssi intValue];
    
    globalRSSI = (localRSSI * -1)*1.3;
    
    //sets the RSSI label to the RSSI string value
    _lblRSSI.Text = rssi.stringValue;
}

//reads the RSSI
-(void) readRSSITimer:(NSTimer *)timer{
    [_ble readRSSI];
}

// When its disconnected
- (void)bleDidDisconnect{
    //stop think spinner
    [_spinner stopAnimating];
    //set the RSSI label txt to say not connected
    [_lblRSSI setText:@"Not Connected"];
    //stop searching
    [rssiTimer invalidate];
}

// When data is incoming
-(void) bleDidReceiveData:(unsigned char *)data length:(int)length{
    //prints how much data is incoming
    NSLog(@"Length: %d", length);
    //Parse the data, all commands are 3-bytes
    for (int i =0; i<length; i+=3){
        //print incoming data
        NSLog(@"0x%02X, 0x%02X, 0x%02X", data[i], data[i+1], data[i+2]);
        //if data  equals decimal 10
        //if (data[i] == 0x0A) {
            //
        //}
        // if data equals 0x0B is 00001011 in binary which is 11 in decimal
        if(data[i] == 0x0B){
            //converts to a 16-bit number
            UInt16 Value;
            Value = data[i=2] | data[i+1] << 8;
        }
    }
}

@end
