//
//  HMStatusRetweetedFrame.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMStatusRetweetedFrame.h"
#import "HMStatus.h"
#import "HMUser.h"
#import "HMStatusPhotosView.h"

@implementation HMStatusRetweetedFrame

- (void)setRetweetedStatus:(HMStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.昵称
    CGFloat nameX = HMStatusCellInset;
    CGFloat nameY = HMStatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:HMStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + HMStatusCellInset * 0.5;
    CGFloat maxW = HMScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:HMStatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 3.配图相册
    //
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
        CGSize photosSize = [HMStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        
    } 
    
    if (retweetedStatus.isDetile) {
        CGFloat toobary=0;
        CGFloat toobarx=130;
        
        CGFloat toobarw=[UIScreen mainScreen].bounds.size.width-toobarx;
        
        CGFloat toobarh=20;
        if (retweetedStatus.pic_urls.count) {
            toobary  =CGRectGetMaxY(self.photosFrame);
            
        }else{
            toobary=CGRectGetMaxY(self.textFrame);
        }
        self.toolbarFrame=CGRectMake(toobarx, toobary, toobarw, toobarh);
        

    }
    
    CGFloat h= 0;
    if (retweetedStatus.pic_urls.count) {
        h = CGRectGetMaxY(self.photosFrame) + HMStatusCellInset;
        if (retweetedStatus.isDetile) {
            h=CGRectGetMaxY(self.toolbarFrame);
        }
    }else{
          h = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
        
        if (retweetedStatus.isDetile) {
            h=CGRectGetMaxY(self.toolbarFrame);
        }

    }
   
    
    
    
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = HMScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
