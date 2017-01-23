//
//  KWCommentResult.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/13.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWCommentResult.h"
#import "MJExtension.h"
#import "KWComment.h"
@implementation KWCommentResult

-(NSDictionary *)objectClassInArray{
    return @{@"comments":[KWComment class]};
}

@end
