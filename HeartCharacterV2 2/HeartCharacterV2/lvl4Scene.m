//
//  lvl4Scene.m
//  HeartCharacterV2
//
//  Created by compagnb on 3/8/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "lvl4Scene.h"

@implementation lvl4Scene

{
    //defining array
    SKSpriteNode *_lvl4Surfer;
    NSArray *_lvl4SurfFrames;
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //background color blue
        self.backgroundColor = [SKColor blueColor];
        
        // set up paddling array to hold the frames
        NSMutableArray *surfFrames = [NSMutableArray array];
        
        //load and set up texture atlas
        SKTextureAtlas *lvl4AnimatedAtlas = [SKTextureAtlas atlasNamed:@"lvl4Images"];
        
        //gather the list of names from the atlas folder
        int numbImages = lvl4AnimatedAtlas.textureNames.count;
        for (int i=1; i<= numbImages; i++){
            NSString *textureName = [NSString stringWithFormat: @"lvl4Surfer%d", i];
            SKTexture *temp = [lvl4AnimatedAtlas textureNamed:textureName];
            [surfFrames addObject:temp];
        }
        _lvl4SurfFrames = surfFrames;
        
        //create the surfer and set it to the middle of the screen
        SKTexture *temp= _lvl4SurfFrames [0];
        _lvl4Surfer = [SKSpriteNode spriteNodeWithTexture:temp];
        _lvl4Surfer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild: _lvl4Surfer];
        
        //start sufing
        [self surfingSurfer];
        
    }
    
    return self;
}

//creating a new animation method
-(void)surfingSurfer
{
    [_lvl4Surfer runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_lvl4SurfFrames timePerFrame:0.5f resize:NO restore:YES]] withKey:@"SurfInPlaceSurfer"];
    return;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
