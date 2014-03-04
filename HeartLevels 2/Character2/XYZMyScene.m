//
//  XYZMyScene.m
//  HeartBeatCharacter
//
//  Created by compagnb on 2/27/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "XYZMyScene.h"

@implementation XYZMyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor lightGrayColor];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        myLabel.text = @"Heartbeat State 1";
        myLabel.fontSize = 18;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame)-35);
        
        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
