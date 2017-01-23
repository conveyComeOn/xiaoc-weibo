//
//  KWreguStereault.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/10.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWreguStereault : NSObject
/**
 *  匹配到的字符串
 */
@property (nonatomic, copy) NSString *string;
/**
 *  匹配到的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  这个结果是否为表情
 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;
@end
