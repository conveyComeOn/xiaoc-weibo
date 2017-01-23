//
//  KWcommentBtn.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/11.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWcommentBtn.h"

@implementation KWcommentBtn

//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.width=self.currentBackgroundImage.size.width;
//        CGFloat currentheight=self.currentBackgroundImage.size.height;
//        CGFloat selfheight=[self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12]].height;
//        if (currentheight>selfheight) {
//            self.height=currentheight;
//        }else{
//            self.height=selfheight+10;
//        }
//
//    }
//    return self;
//}
//



-(void)setBedage:(NSString *)bedage{
    _bedage=bedage;
    [self setTitle:bedage forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont systemFontOfSize:12];
    [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    self.height=self.currentBackgroundImage.size.height;
    CGFloat currentheight=self.currentBackgroundImage.size.width;
    CGFloat selfheight=[self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:12]].width;
    if (currentheight>selfheight) {
        self.width=currentheight;
    }else{
        self.width=selfheight+10;
    }
}

@end
