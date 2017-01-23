//
//  HMPopEmotionView.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/6.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmotionView;

@interface HMPopEmotionView : UIView
+(instancetype)popView;




-(void)showEmotion:(HMEmotionView *)fromEmtion;


-(void)dismiss;

@end
