//
//  HMStatus.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMStatus.h"
#import "MJExtension.h"
#import "HMPhoto.h"
#import "NSDate+MJ.h"
#import "KWreguStereault.h"
#import "RegexKitLite.h"
#import "HMEmotion.h"
#import "KWAttachment.h"
#import "HMEmotionTool.h"


@implementation HMStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [HMPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
  
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
         
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

- (void)setSource:(NSString *)source
{

    
    
    _source=source;
   
    NSRange rang;
    rang.location=[source rangeOfString:@">"].location+1;
    rang.length=[source rangeOfString:@"</a"].location-rang.location;

    if (rang.length>100) {
        _source=@"来自未审核的应用";
    }else{
   
        NSString *string=[source substringWithRange:rang];
          _source=[NSString stringWithFormat:@"来自%@",string];
   
    }
}

/**
 *  根据字符串计算出所有的匹配结果（已经排好序）
 *
 *  @param text 字符串内容
 */
- (NSArray *)regexResultsWithText:(NSString *)text
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        KWreguStereault *rr = [[KWreguStereault alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = YES;
        [regexResults addObject:rr];
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        KWreguStereault *rr = [[KWreguStereault alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = NO;
        [regexResults addObject:rr];
    }];
    
    // 排序
    [regexResults sortUsingComparator:^NSComparisonResult(KWreguStereault *rr1, KWreguStereault *rr2) {
        int loc1 = (int)rr1.range.location;
        int loc2 = (int)rr2.range.location;
        return [@(loc1) compare:@(loc2)];
    }];
    return regexResults;
}
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self createAttributedText];
}

- (void)setUser:(HMUser *)user
{
    _user = user;
    
    [self createAttributedText];
}

- (void)setRetweeted_status:(HMStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    self.retweeted = NO;
    retweeted_status.retweeted = YES;
}

- (void)setRetweeted:(BOOL)retweeted
{
    _retweeted = retweeted;
    
    [self createAttributedText];
}

- (void)createAttributedText
{
    if (self.text == nil || self.user == nil) return;
    
    if (self.retweeted) {
       
            } else {
        self.attributedText = [self attributedStringWithText:self.text];
    }
}

- (NSAttributedString *)attributedStringWithText:(NSString *)text
{
    // 1.匹配字符串
   
    NSArray *regexResults = [self regexResultsWithText:text];
   
    // 2.根据匹配结果，拼接对应的图片表情和普通文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(KWreguStereault *result, NSUInteger idx, BOOL *stop) {
        HMEmotion *emotion = nil;
        if (result.isEmotion) { // 表情
            emotion = [HMEmotionTool emotionWithDesc:result.string];
        }
        
        if (emotion) { // 如果有表情
            // 创建附件对象
           KWAttachment *attach = [[KWAttachment alloc] init];
            
            // 传递表情
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, HMStatusOrginalTextFont.lineHeight, HMStatusOrginalTextFont.lineHeight);
            
            // 将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedString appendAttributedString:attachString];
        } else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value: HMColor(88, 161, 253) range:*capturedRanges];
                [substr addAttribute:@"HMLinkText" value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value: HMColor(88, 161, 253) range:*capturedRanges];
                [substr addAttribute:@"HMLinkText" value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value: HMColor(88, 161, 253) range:*capturedRanges];
                [substr addAttribute:@"HMLinkText" value:*capturedStrings range:*capturedRanges];
            }];
            
            [attributedString appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}






@end
