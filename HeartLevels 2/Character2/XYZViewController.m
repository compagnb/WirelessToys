//
//  XYZViewController.m
//  HeartBeatCharacter
//
//  Created by compagnb on 2/27/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "XYZViewController.h"
#import "XYZMyScene.h"
#import "myScene1.h"
#import "myScene2.h"
#import "myScene3.h"
#import "myScene4.h"

@implementation XYZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self scene1Load];
    
    
}

-(void) scene1Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [myScene1 sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void) scene2Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [myScene2 sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void) scene3Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [myScene3 sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void) scene4Load{
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [myScene4 sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)myStepperPressed:(id)sender {
    //NSLog(@"the Stepper Was Pressed");
    NSLog(@"myStepperValue: %f", _myStepperValue.value);
    
    if (_myStepperValue.value == 1){
        NSLog(@"myStepper Value == 1");
        [_myProgressView setProgress:0.1];
        [self scene1Load];
    }
    if (_myStepperValue.value == 2){
        NSLog(@"myStepper Value == 2");
        [_myProgressView setProgress:0.3];
        [self scene2Load];
    }
    if (_myStepperValue.value == 3){
        NSLog(@"myStepper Value == 3");
        [_myProgressView setProgress:0.6];
        [self scene3Load];
    }
    if (_myStepperValue.value == 4){
        NSLog(@"myStepper Value == 4");
        [_myProgressView setProgress:0.9];
        [self scene4Load];
    }
    
}
@end
