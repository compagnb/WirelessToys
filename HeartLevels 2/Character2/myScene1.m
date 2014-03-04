//
//  myScene1.m
//  Character2
//
//  Created by compagnb on 2/27/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "myScene1.h"

@implementation myScene1

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor lightGrayColor];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        myLabel.text = @"Scene 1";
        myLabel.fontSize = 18;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame)-35);
    
        
        [self addChild:myLabel];
        
        SKSpriteNode* l1Surf = [SKSpriteNode spriteNodeWithImageNamed:@"L1"];
        [self addChild:l1Surf];
        
        [l1Surf setPosition:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];

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
}

@end
