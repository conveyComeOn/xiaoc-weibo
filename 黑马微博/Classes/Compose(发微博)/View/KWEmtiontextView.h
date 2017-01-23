//
//  KWEmtiontextView.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/8.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMTextView.h"
@class HMEmotion;
@interface KWEmtiontextView : HMTextView

@property(nonatomic,copy)NSString *realstring;


-(void)appEmotionView:(HMEmotion *)emotion;



@end
