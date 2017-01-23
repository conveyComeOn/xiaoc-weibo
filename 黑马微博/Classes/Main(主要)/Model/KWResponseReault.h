//
//  KWResponseReault.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/13.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWResponseReault : NSObject
/** 转发数组 */
@property (nonatomic, strong) NSArray *reposts;
/** 转发总数 */
@property (nonatomic, assign) int total_number;
@end
