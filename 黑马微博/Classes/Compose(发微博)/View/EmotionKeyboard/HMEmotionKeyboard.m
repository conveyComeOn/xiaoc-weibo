//
//  HMEmotionKeyboard.m
//  黑马微博
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMEmotionKeyboard.h"
#import "HMEmotionListView.h"
#import "HMEmotionToolbar.h"
#import "MJExtension.h"
#import "HMEmotion.h"

@interface HMEmotionKeyboard() <HMEmotionToolbarDelegate>
/** 表情列表 */
@property (nonatomic, weak) HMEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) HMEmotionToolbar *toollbar;

/** 默认表情 */
@property (nonatomic, strong) NSArray *defaultEmotions;
/** emoji表情 */
@property (nonatomic, strong) NSArray *emojiEmotions;
/** 浪小花表情 */
@property (nonatomic, strong) NSArray *lxhEmotions;

@property (nonatomic, strong) NSArray *xiaocong;

@end

@implementation HMEmotionKeyboard


-(NSArray *)xiaocong{
    if (_xiaocong==nil) {
        
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/xiaocong/info.plist" ofType:nil];
        self.defaultEmotions = [HMEmotion objectArrayWithFile:plist];
        [self.defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/xiaocong"];
    }
    return _xiaocong;
}


- (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultEmotions = [HMEmotion objectArrayWithFile:plist];
        [self.defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

- (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiEmotions = [HMEmotion objectArrayWithFile:plist];
        [self.emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}

- (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhEmotions = [HMEmotion objectArrayWithFile:plist];
        [self.lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        HMEmotionListView *listView = [[HMEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        HMEmotionToolbar *toollbar = [[HMEmotionToolbar alloc] init];
        toollbar.delegate = self;
        [self addSubview:toollbar];
        self.toollbar = toollbar;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
}

#pragma mark - HMEmotionToolbarDelegate
- (void)emotionToolbar:(HMEmotionToolbar *)toolbar didSelectedButton:(HMEmotionType)emotionType
{
    switch (emotionType) {
        case HMEmotionTypeDefault:// 默认
            self.listView.emotions = self.defaultEmotions;
           
            break;
            
        case HMEmotionTypeEmoji: // Emoji
            self.listView.emotions = self.emojiEmotions;
            break;
            
        case HMEmotionTypeLxh: // 浪小花
            self.listView.emotions = self.lxhEmotions;
            break;
            
        case HMEmotionTypeRecent:
            self.listView.emotions=self.xiaocong;
          
            break;
    }
}
@end
