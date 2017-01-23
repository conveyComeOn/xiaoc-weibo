//
//  KWCommenItem.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/10.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWCommenItem.h"

@implementation KWCommenItem




+(instancetype)itemWithtitle:(NSString *)title icon:(NSString *)icon{
   return [self itemWithtitle:title subtitle:nil icon:icon];
}







+(instancetype)itemWithtitle:(NSString *)title subtitle:(NSString *)subtitle icon:(NSString *)icon{

    KWCommenItem *item=[[self alloc]init];
    item.title=title;
    item.subtitle=subtitle;
    item.icon=icon;
    return item;
}
@end
