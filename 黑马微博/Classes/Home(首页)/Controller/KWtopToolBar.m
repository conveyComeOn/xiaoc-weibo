//
//  KWtopToolBar.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/12.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWtopToolBar.h"


@interface KWtopToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *moveBtn;
@property (weak, nonatomic) IBOutlet UIButton *attitudebtn;

@property (weak, nonatomic) IBOutlet UIButton *commenBtn;
- (IBAction)buton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@property(nonatomic,strong)UIButton *seletedbtn;
@end


@implementation KWtopToolBar



+(instancetype)toobar{
    return [[[NSBundle mainBundle]loadNibNamed:@"KWtopToolBar" owner:nil options:nil]lastObject];
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self buton:self.commenBtn];
    self.commenBtn.tag=KWtopToolBarbuttonTypeComment;
    self.moveBtn.tag=KWtopToolBarbuttonTypeMove;
}


- (IBAction)buton:(UIButton *)sender {
    self.seletedbuttontype=sender.tag;
    self.seletedbtn.selected=NO;
    
    sender.selected=YES;
    
    self.seletedbtn=sender;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.arrow.centerX=sender.centerX;
    });
    
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]) {
        [self.delegate composeTool:self didClickedButton:(KWtopToolBarbuttonType)sender.tag];
    }
    
    
}

-(void)setStatus:(HMStatus *)status{
    [self setupBtnTitle:self.commenBtn count:status.comments_count defaultTitle:@"评论"];
    [self setupBtnTitle:self.moveBtn count:status.reposts_count defaultTitle:@"转发"];
    [self setupBtnTitle:self.attitudebtn count:status.attitudes_count defaultTitle:@"赞"];
    
}



/**
 *  设置按钮的文字
 *
 *  @param button       需要设置文字的按钮
 *  @param count        按钮显示的数字
 *  @param defaultTitle 数字为0时显示的默认文字
 */
- (void)setupBtnTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万 %@", count / 10000.0, defaultTitle];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%d %@", count, defaultTitle];
    } else {
        defaultTitle = [NSString stringWithFormat:@"0 %@", defaultTitle];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
#warning 最好同时设置多种状态下的文字
    [button setTitle:defaultTitle forState:UIControlStateSelected];
}
@end
