//
//  lvl5Scene.m
//  HeartCharacterV2
//
//  Created by compagnb on 3/8/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "lvl5Scene.h"

@implementation lvl5Scene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blueColor];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        myLabel.text = @"Stroke Alert!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
    }
    return self;
}


@end
