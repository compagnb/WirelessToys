//
//  lvl3Scene.m
//  HeartCharacterV2
//
//  Created by compagnb on 3/8/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "lvl3Scene.h"

@implementation lvl3Scene

{
    //defining array
    SKSpriteNode *_lvl3Surfer;
    NSArray *_lvl3PopFrames;
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //background color blue
        self.backgroundColor = [SKColor blueColor];
        
        // set up paddling array to hold the frames
        NSMutableArray *popFrames = [NSMutableArray array];
        
        //load and set up texture atlas
        SKTextureAtlas *lvl3AnimatedAtlas = [SKTextureAtlas atlasNamed:@"lvl3Images"];
        
        //gather the list of names from the atlas folder
        int numbImages = lvl3AnimatedAtlas.textureNames.count;
        for (int i=1; i<= numbImages; i++){
            NSString *textureName = [NSString stringWithFormat: @"lvl3Surfer%d", i];
            SKTexture *temp = [lvl3AnimatedAtlas textureNamed:textureName];
            [popFrames addObject:temp];
        }
        _lvl3PopFrames = popFrames;
        
        //create the surfer and set it to the middle of the screen
        SKTexture *temp= _lvl3PopFrames [0];
        _lvl3Surfer = [SKSpriteNode spriteNodeWithTexture:temp];
        _lvl3Surfer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild: _lvl3Surfer];
        
        //start popping
        [self popSurfer];
        
    }
    
    return self;
}

//creating a new animation method
-(void)popSurfer
{
    [_lvl3Surfer runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_lvl3PopFrames timePerFrame:0.5f resize:NO restore:YES]] withKey:@"Pop InPlaceSurfer"];
    return;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


@end
