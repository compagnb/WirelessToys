//
//  ViewController.m
//  SharkRC
//  With the help of BlueRC from Scott Cheezem
//
//  Created by compagnb on 4/26/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "ViewController.h"

//declaration of variables
//--------------------------------------------------------------------
@interface ViewController (){
NSString *myBlueSheildUUID;
CBUUID *myUUIDA;
}

@end
//--------------------------------------------------------------------

@implementation ViewController
    
@synthesize ble;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.analogStick.delegate = self;
    
    ble = [[BLE alloc] init];
    [ble controlSetup:1];
    ble.delegate = self;
    
    [self updateAnalogLabel]; // changed label
}

//--------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//--------------------------------------------------------------------
- (void)updateAnalogLabel
{
	[self.analogTextLabel setText:[NSString stringWithFormat:@"Analogue: %.1f , %.1f", self.analogStick.xValue, self.analogStick.yValue]];
}

//--------------------------------------------------------------------
-(void)processAnalogControls{
    
    if([ble isConnected]){
        
        
        //an array of pin addresses and values
        
        //buf[]={scaledValForMotor1, dirForMotor1(HIGH|LOW),scalevValForMotor2, dirForMotor2(HIGH|LOW) NULL}
        UInt8 buf[5] = {0x00, 0x00, 0x00, 0x00, 0x00};
        //UInt8 buf[9] = {0x03, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x00};
        
        
        //UInt8 buf[5] = {0x03, 0x00, 0x05, 0x00, 0x00};
        //UInt8 buf[5] = {0x03, 0x00, 0x05, 0x00, 0x00};
        int scaledXval = abs(floorf((float)self.analogStick.xValue*255));
        
        int scaledYval = abs(floorf((float)self.analogStick.yValue*255));
        
        buf[0] = scaledYval;
        buf[2] = scaledXval;
        
        if(self.analogStick.xValue >= 0 && self.analogStick.yValue >= 0){
            //forward and to the right
            
            NSLog(@"forward and to the right");
            buf[1] = 1;
            buf[3] = 0;
            
            
            
        }else if(self.analogStick.xValue <= 0 && self.analogStick.yValue >= 0){
            //forward and to the left
            NSLog(@"forward and to the left");
            buf[1] = 1;
            buf[3] = 0;
            
            
        }else if(self.analogStick.xValue <= 0 && self.analogStick.yValue <= 0){
            NSLog(@"backwards and to the left");
            //backwards and to the right
            buf[1] = 0;
            buf[3] = 1;
            
            
        }else if (self.analogStick.xValue >=0 && self.analogStick.yValue <= 0){
            //backwards and to the left
            NSLog(@"backwards and to the right");
            buf[1] = 0;
            buf[3] = 0;
            
        }
        
        
        NSData *d = [[NSData alloc]initWithBytes:buf length:5];
        
        [ble write:d];
        
        
        
        /*UInt8 buf[3] =  {0x03, 0x00, 0x00};
         buf[1] = scaledYval;
         NSData *d = [[NSData alloc]initWithBytes:buf length:3];
         [ble write:d];*/
        
        //[self sendData];
    }
}

//--------------------------------------------------------------------
#pragma mark - JSAnalogueStickDelegate

- (void)analogStickDidChangeValue:(JSAnalogStick *)analogStick
{
	[self updateAnalogLabel];
    [self processAnalogControls];
    
}


//--------------------------------------------------------------------
#pragma mark - BLEDelegate

NSTimer *rssiTimer;

-(void)bleDidUpdateRSSI:(NSNumber *)rssi{
    self.lblRSSI.text = [NSString stringWithFormat:@"RSSI:%@",rssi];
}

-(void) readRSSITimer:(NSTimer *)timer
{
    [ble readRSSI];
}

-(void)bleDidConnect{
    NSLog(@"->Connected");
    
    [self.indConnecting stopAnimating];
    
    [self.btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
    [self.btnConnect removeTarget:self action:@selector(scanForPeripherals:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnConnect addTarget:self action:@selector(disconnectFromPeripheral) forControlEvents:UIControlEventTouchUpInside];
    //self.connectButton.enabled = YES;
    [self.btnConnect setEnabled:YES];
    
    // send reset
    UInt8 buf[] = {0x04, 0x00, 0x00};
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [ble write:data];
    
    // Schedule to read RSSI every 1 sec.
    rssiTimer = [NSTimer scheduledTimerWithTimeInterval:(float)1.0 target:self selector:@selector(readRSSITimer:) userInfo:nil repeats:YES];
    
}

-(void)bleDidDisconnect{
    
    NSLog(@"->Disconnected");
    
    [self.indConnecting stopAnimating];
    
    [self.btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
    [self.btnConnect removeTarget:self action:@selector(disconnectFromPeripheral) forControlEvents:UIControlEventTouchUpInside];
    [self.btnConnect addTarget:self action:@selector(scanForPeripherals:) forControlEvents:UIControlEventTouchUpInside];
    self.lblRSSI.text = @"RSSI: ---";
    //self.connectButton.enabled = YES;
    [self.btnConnect setEnabled:YES];
    
    
    [rssiTimer invalidate];
}

-(void)bleDidReceiveData:(unsigned char *)data length:(int)length{
    
    NSData *d = [NSData dataWithBytes:data length:length];
    NSString *s = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
    
    if([s isEqualToString:@"1"]){
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
    
    
    
}

//--------------------------------------------------------------------
#pragma mark - BLE Actions
-(void)scanForPeripherals:(id)sender{
    
    if (ble.activePeripheral)
        if(ble.activePeripheral.state == CBPeripheralStateConnected)
        {
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            [self.btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
            return;
        }
    
    if (ble.peripherals)
        ble.peripherals = nil;
    
    [self.btnConnect setEnabled:false];
    [ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [self.indConnecting startAnimating];
}

-(void)disconnectFromPeripheral{
    [self.btnConnect setEnabled:NO];
    //this seems like its for disconnecting...
    if(ble.activePeripheral){
        if (ble.activePeripheral.isConnected) {
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            
        }
    }
}

-(void)connectionTimer:(NSTimer*)timer{
    //self.connectButton.enabled = YES;
    
        if (ble.peripherals.count > 0)
            for(int i = 0; i < ble.peripherals.count; i++){
                
                //////////////////////////////////////////////////////////
                //  PUT YOUR BLE SHEILD UUID HERE, Check DeBug Log Below For Available UUID's
                // example:  @"A1834B4A-CEF2-AD8B-A13F-20616683B36E";
                //////////////////////////////////////////////////////////
                
                myBlueSheildUUID = @"499B3151-EDCF-0482-D047-6921B647F065";
                myUUIDA = [CBUUID UUIDWithString:myBlueSheildUUID];
                
                CBPeripheral *p = [ble.peripherals objectAtIndex:i];
                
                NSMutableString * pUUIDString = [[NSMutableString alloc] initWithFormat:@"%@",CFUUIDCreateString(NULL, p.UUID) ];
                
                // Debug Line
                // NSLog(@"\n++++++\nLooking for your perfered Device UUID of: %@\n", myBlueSheildUUID);
                
                // Debug Line
                //NSLog(@" pUUIDString is: %@\n", pUUIDString);
                
                if ([myBlueSheildUUID isEqualToString:pUUIDString]) {
                    NSLog(@"\n\n++++++   Found your Perfered Device UUID of: %@\n\n", myBlueSheildUUID);
                    [ble connectPeripheral:[ble.peripherals objectAtIndex:i]];
                }
                
                if (![myBlueSheildUUID isEqualToString:pUUIDString]) {
                    NSLog(@"Found a Bluetooth Device, But doesn't match your UUID \n\n");
                    }
            }
        
    }


@end
