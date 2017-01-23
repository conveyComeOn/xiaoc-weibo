//
//  KWResponseReault.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/13.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWResponseReault.h"
#import "MJExtension.h"
#import "HMStatus.h"
@implementation KWResponseReault





-(NSDictionary *)objectClassInArray{
    return @{@"reposts":[HMStatus class]};
}

@end
