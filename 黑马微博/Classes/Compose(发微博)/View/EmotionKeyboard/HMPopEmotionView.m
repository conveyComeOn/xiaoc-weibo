//
//  HMPopEmotionView.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/6.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMPopEmotionView.h"
#import "HMEmotionView.h"

@interface HMPopEmotionView()

@property (weak, nonatomic) IBOutlet HMEmotionView *clearEmtion;

@end

@implementation HMPopEmotionView
+(instancetype)popView{
    return [[[NSBundle mainBundle]loadNibNamed:@"HMPopEmotionView" owner:nil options:nil]lastObject];
}


- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
    
    
}






-(void)showEmotion:(HMEmotionView *)fromEmtion{
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
     [window addSubview:self];
    self.clearEmtion.emotion=fromEmtion.emotion;
   CGFloat centerX=fromEmtion.centerX;
   CGFloat centerY=fromEmtion.centerY-self.height*0.5;
    CGPoint center=CGPointMake(centerX, centerY);
    self.center=[window convertPoint:center fromView:fromEmtion.superview];
    
   
    
}
-(void)dismiss{
    [self removeFromSuperview];
}

@end
