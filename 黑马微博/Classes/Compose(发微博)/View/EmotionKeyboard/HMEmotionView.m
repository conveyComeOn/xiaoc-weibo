//
//  HMEmotionView.m
//  黑马微博
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMEmotionView.h"
#import "HMEmotion.h"
#import "HMPopEmotionView.h"

@implementation HMEmotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        
        
    }
    return self;
}

- (void)setEmotion:(HMEmotion *)emotion
{
    _emotion = emotion;
   
    
    if (emotion.code) { // emoji表情
        // emotion.code == 0x1f603 --> \u54367
        // emoji的大小取决于字体大小
        [UIView setAnimationsEnabled:NO];
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:YES];
        });
    } else { // 图片表情
        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        
        
        UIImage *image=[UIImage imageNamed:icon];
        image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self setImage:image forState:UIControlStateNormal];
 
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
