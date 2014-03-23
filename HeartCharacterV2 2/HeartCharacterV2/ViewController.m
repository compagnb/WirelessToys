//
//  ViewController.m
//  HeartCharacterV2 "Surf is up!!!"
//
//  Created by compagnb on 3/8/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

//link files
#import "ViewController.h"
#import "lvl0Scene.h"
#import "lvl1Scene.h"
#import "lvl2Scene.h"
#import "lvl3Scene.h"
#import "lvl4Scene.h"
#import "lvl5Scene.h"

@implementation ViewController

- (void)viewDidLoad
{
    //onload run lvl1Load function
    [super viewDidLoad];
    [self lvl0Load];
    
}

//lvl0Load Function - Displays lvl1Scene
-(void) lvl0Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [lvl0Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

//lvl1Load Function - Displays lvl1Scene
-(void) lvl1Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [lvl1Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

//lvl2Load Function - Displays lvl2Scene
-(void) lvl2Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [lvl2Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

//lvl3Load Function - Displays lvl3Scene
-(void) lvl3Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [lvl3Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

//lvl4Load Function - Displays lvl4Scene
-(void) lvl4Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [lvl4Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

//lvl5Load Function - Displays lvl4Scene
-(void) lvl5Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [lvl5Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

//Screne Rotation
- (BOOL)shouldAutorotate
{
    return YES;
}

//Support stuff
- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

//Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

//Stepper action function
- (IBAction)myStepperPressed:(UIStepper *)sender {
    //debug messages for console log
    //NSLog (@"the stepper was pressed");
    NSLog (@"myStepperValue: %f", _myStepperValue.value);
    
    //If stepper is 0
    if (_myStepperValue.value == 0){
        NSLog(@"myStepperValue: == 0");
        [_lvlProgressbar setProgress:0.0];
        [self lvl0Load];
    }
    //If stepper is 1
    if (_myStepperValue.value == 1){
        NSLog(@"myStepperValue: == 1");
        [_lvlProgressbar setProgress:0.1];
        [self lvl1Load];
         }
    //If stepper is 2
    if (_myStepperValue.value == 2){
        NSLog(@"myStepperValue: == 2");
        [_lvlProgressbar setProgress:0.3];
        [self lvl2Load];
    }
    //If stepper is 3
    if (_myStepperValue.value == 3){
        NSLog(@"myStepperValue: == 3");
        [_lvlProgressbar setProgress:0.6];
        [self lvl3Load];
    }
    //If stepper is 4
    if (_myStepperValue.value == 4){
        NSLog(@"myStepperValue: == 4");
        [_lvlProgressbar setProgress:0.9];
        [self lvl4Load];
    }
    //If stepper is greater than 4
    if (_myStepperValue.value > 4){
        NSLog(@"myStepperValue: > 4");
        [_lvlProgressbar setProgress:1.0];
        [self lvl5Load];
    }
        
        
}
- (IBAction)BLEConnectDisconnectButtonPressed:(id)sender {
}
- (IBAction)swTestLed:(id)sender {
}
- (IBAction)swAnalogPinMonitor:(id)sender {
}
@end
