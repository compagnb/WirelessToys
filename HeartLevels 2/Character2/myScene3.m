//
//  myScene3.m
//  Character2
//
//  Created by compagnb on 2/27/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "myScene3.h"

@implementation myScene3

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor lightGrayColor];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
         myLabel.text = @"Scene 3";
        myLabel.fontSize = 18;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame)-35);
        
        [self addChild:myLabel];
        
        SKSpriteNode* l3Surf = [SKSpriteNode spriteNodeWithImageNamed:@"L3"];
        [self addChild:l3Surf];
        
        [l3Surf setPosition:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetMidY(self.frame))];

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
