//
//  lvl2Scene.m
//  HeartCharacterV2
//
//  Created by compagnb on 3/8/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "lvl2Scene.h"

@implementation lvl2Scene

{
    //defining array
    SKSpriteNode *_lvl2Surfer;
    NSArray *_lvl2PaddlingFrames;
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //background color blue
        self.backgroundColor = [SKColor blueColor];
        
        // set up paddling array to hold the frames
        NSMutableArray *paddleFrames = [NSMutableArray array];
        
        //load and set up texture atlas
        SKTextureAtlas *lvl2AnimatedAtlas = [SKTextureAtlas atlasNamed:@"lvl2Images"];
        
        //gather the list of names from the atlas folder
        int numbImages = lvl2AnimatedAtlas.textureNames.count;
        for (int i=1; i<= numbImages; i++){
            NSString *textureName = [NSString stringWithFormat: @"lvl2Surfer%d", i];
            SKTexture *temp = [lvl2AnimatedAtlas textureNamed:textureName];
            [paddleFrames addObject:temp];
        }
        _lvl2PaddlingFrames = paddleFrames;
        
        //create the surfer and set it to the middle of the screen
        SKTexture *temp= _lvl2PaddlingFrames[0];
        _lvl2Surfer = [SKSpriteNode spriteNodeWithTexture:temp];
        _lvl2Surfer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild: _lvl2Surfer];
        
        //start paddling
        [self paddlingSurfer];
        
    }
    
    return self;
}

//creating a new animation method
-(void)paddlingSurfer
{
    [_lvl2Surfer runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_lvl2PaddlingFrames timePerFrame:0.5f resize:NO restore:YES]] withKey:@"paddlingInPlaceSurfer"];
    return;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

