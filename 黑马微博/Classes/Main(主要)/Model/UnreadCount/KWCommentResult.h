//
//  KWCommentResult.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/13.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWCommentResult : NSObject
/** 评论数组 */
@property (nonatomic, strong) NSArray *comments;
/** 评论总数 */
@property (nonatomic, assign) int total_number;
@end
