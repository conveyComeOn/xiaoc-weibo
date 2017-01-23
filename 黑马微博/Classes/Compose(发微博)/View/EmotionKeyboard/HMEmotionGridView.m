//
//  HMEmotionGridView.m
//  黑马微博
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMEmotionGridView.h"
#import "HMEmotion.h"
#import "HMEmotionView.h"
#import "HMPopEmotionView.h"

@interface HMEmotionGridView()
@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray *emotionViews;
@property(nonatomic,strong)HMPopEmotionView *popview;
@end

@implementation HMEmotionGridView




-(HMPopEmotionView *)popview{
    if (_popview==nil) {
        self.popview=[HMPopEmotionView popView];
    }
    return _popview;
}
- (NSMutableArray *)emotionViews
{
    if (_emotionViews==nil) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}
-(void)deleteclick{
    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HMEmotionDidDeletedNotification" object:nil userInfo:nil];

    
}
- (void)setEmotions:(NSArray *)emotions
{
    
    
    _emotions=emotions;
    for (int i=0; i<emotions.count; i++) {
     HMEmotionView *emotionBtn=[[HMEmotionView alloc]init];
        UILongPressGestureRecognizer *recongnizer=[[UILongPressGestureRecognizer alloc]init];
        [recongnizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recongnizer];
        
        
        
        emotionBtn.emotion=emotions[i];
        
        emotionBtn.backgroundColor=HMRandomColor;
        
        
        
     
        HMEmotion *model=emotions[i];
        if (model.code) {
            [emotionBtn setTitle:model.emoji forState:UIControlStateNormal];
        }else{
            NSString *icon=[NSString stringWithFormat:@"%@/%@",model.directory,model.png];
            
            [emotionBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
            
            emotionBtn.adjustsImageWhenHighlighted=NO;
        }
        [emotionBtn addTarget:self action:@selector(emotionclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emotionBtn];
        [self.emotionViews addObject:emotionBtn];
    }
    
    
}
-(void)longPress:(UILongPressGestureRecognizer *)longtouch{
    CGPoint point=[longtouch locationInView:longtouch.view];
    HMEmotionView *emotionview=[self emotionViewWithPoint:point];
    if (longtouch.state==UIGestureRecognizerStateEnded) {
        [self.popview dismiss];
        
        // 选中表情
        [self selecteEmotion:emotionview.emotion];
    }else{
        [self.popview showEmotion:emotionview];
    }
    
}



-(void)selecteEmotion:(HMEmotion *)emotion{
    
    
    if (emotion == nil) return;
    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HMEmotionDidSelectedNotification" object:nil userInfo:@{@"HMSelectedEmotion" : emotion}];
    
    
}


-(HMEmotionView *)emotionViewWithPoint:(CGPoint)point{
  __block  HMEmotionView *foundemtion=nil;
    [self .emotionViews enumerateObjectsUsingBlock:^(HMEmotionView* emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectContainsPoint(emotion.frame, point)) {
            foundemtion=emotion;
        }
    }];
    
    
    return foundemtion;
}


-(void)emotionclick:(HMEmotionView *)emotion{
    [self.popview showEmotion:emotion];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popview dismiss];
    });
    [self selecteEmotion:emotion.emotion];
}






- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    // 1.排列所有的表情
    int count = (int)self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / HMEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / HMEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        
        HMEmotion *model=self.emotions[i];
        if ([model.directory isEqualToString:@"EmotionIcons/xiaocong"]) {
            emotionView.width=(self.width-2*leftInset)/3;
            emotionView.height=self.height-topInset;
            emotionView.y=topInset;
            emotionView.x=i*emotionView.width+leftInset;
        }else{
        
        
        emotionView.x = leftInset + (i % HMEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / HMEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
        }
    }
    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}

@end
