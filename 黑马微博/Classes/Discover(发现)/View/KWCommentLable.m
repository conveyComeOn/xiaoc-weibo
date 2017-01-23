//
//  KWCommentLable.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/11.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWCommentLable.h"

@implementation KWCommentLable




-(void)setRightLable:(UILabel *)rightLable{
    _rightLable=rightLable;
    _rightLable.font=[UIFont systemFontOfSize:12];
    _rightLable.size=[rightLable.text sizeWithFont:_rightLable.font];
}
@end
