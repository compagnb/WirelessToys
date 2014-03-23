//
//  lvl1Scene.m
//  HeartCharacterV2
//
//  Created by compagnb on 3/8/14.
//  Copyright (c) 2014 compagnb. All rights reserved.
//

#import "lvl1Scene.h"

@implementation lvl1Scene

{
    
    //defining array
    SKSpriteNode *_lvl1Surfer;
    NSArray *_lvl1WaddingFrames;
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //background color blue
        self.backgroundColor = [SKColor blueColor];
        
        // set up paddling array to hold the frames
        NSMutableArray *waddingFrames = [NSMutableArray array];
        
        //load and set up texture atlas
        SKTextureAtlas *lvl1AnimatedAtlas = [SKTextureAtlas atlasNamed:@"lvl1Images"];
        
        //gather the list of names from the atlas folder
        int numbImages = lvl1AnimatedAtlas.textureNames.count;
        for (int i=1; i<= numbImages; i++){
            NSString *textureName = [NSString stringWithFormat: @"lvl1Surfer%d", i];
            SKTexture *temp = [lvl1AnimatedAtlas textureNamed:textureName];
            [waddingFrames addObject:temp];
        }
        _lvl1WaddingFrames = waddingFrames;
        
        //create the surfer and set it to the middle of the screen
        SKTexture *temp= _lvl1WaddingFrames [0];
        _lvl1Surfer = [SKSpriteNode spriteNodeWithTexture:temp];
        _lvl1Surfer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild: _lvl1Surfer];
        
        //start wadding
        [self waddingSurfer];
        
    }
    
    return self;
}

//creating a new animation method
-(void)waddingSurfer
{
    [_lvl1Surfer runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:_lvl1WaddingFrames timePerFrame:0.5f resize:NO restore:YES]] withKey:@"paddlingInPlaceSurfer"];
    return;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


@end
