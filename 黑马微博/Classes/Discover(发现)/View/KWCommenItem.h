//
//  KWCommenItem.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/10.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWCommenItem : NSObject



@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *bedage;
@property(nonatomic,copy)void(^option)();

/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;



+(instancetype)itemWithtitle:(NSString *)title subtitle:(NSString *)subtitle icon:(NSString *)icon;
+(instancetype)itemWithtitle:(NSString *)title icon:(NSString *)icon;
@end
