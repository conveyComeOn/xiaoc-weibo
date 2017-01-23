//
//  KWComment.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/13.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMStatus,HMUser;
@interface KWComment : NSObject
// {"name" : "jack", "age":10}
/** 	string 	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 	string 	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/** 	string 	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/** 	string 	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 	object 	评论作者的用户信息字段 详细*/
@property (nonatomic, strong) HMUser *user;

/** 	object	评论的微博信息字段 详细*/
@property (nonatomic, strong) HMStatus *status;
@end
