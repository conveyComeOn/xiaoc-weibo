//
//  KWEmtiontextView.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/8.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWEmtiontextView.h"
#import "HMEmotion.h"
#import "KWAttachment.h"

@implementation KWEmtiontextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/







-(void)appEmotionView:(HMEmotion *)emotion{
    NSMutableAttributedString *attributesstring=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (emotion.emoji) {
        
        NSAttributedString *sub=[[NSAttributedString alloc]initWithString:emotion.emoji];
        [attributesstring appendAttributedString:sub];
        
        

    }else{
        KWAttachment *attach=[[KWAttachment alloc]init];
        attach.emotion=emotion;
        attach.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png]];
        
        NSAttributedString *sub=[NSAttributedString attributedStringWithAttachment:attach];
        [attributesstring appendAttributedString:sub];
        
        
        
    }
    self.attributedText=attributesstring;
    
    
}




-(NSString *)realstring{
    NSMutableString *string=[NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL * _Nonnull stop) {
       KWAttachment *sub=attrs[@"NSAttachment"];
        if (sub) {
            [string appendString:sub.emotion.chs];
            
        }else{
           NSString *substring=[self.attributedText attributedSubstringFromRange:range].string;
        [string appendString:substring];
            
        }
        
    }];
    
    
    return string;
}






@end
