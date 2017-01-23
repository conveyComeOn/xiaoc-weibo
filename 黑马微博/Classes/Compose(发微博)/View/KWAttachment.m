//
//  KWAttachment.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/9.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWAttachment.h"
#import "HMEmotion.h"

@implementation KWAttachment





-(void)setEmotion:(HMEmotion *)emotion{
    _emotion=emotion;
    self.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
}

@end
