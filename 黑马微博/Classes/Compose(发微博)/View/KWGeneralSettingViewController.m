//
//  KWGeneralSettingViewController.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/11.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWGeneralSettingViewController.h"
#import "KWCommentGroup.h"
#import "KWCommenArross.h"

#import "KWCommentSwitch.h"

@interface KWGeneralSettingViewController ()

@end

@implementation KWGeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpgeneral];
}


-(void)setUpgeneral{
    [self setUpgeneral0];
    [self setUpgeneral1];
    [self setUpgeneral2];
    [self setUpgeneral3];
    [self setUpgeneral4];
    [self setUpgeneral5];
}


-(void)setUpgeneral0{
    KWCommentGroup *group=[[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    KWCommenArross *picture=[KWCommenArross itemWithtitle:@"阅读模式" icon:nil];
    
    KWCommenArross *wordfond=[KWCommenArross itemWithtitle:@"字号设置" icon:nil];
    
    KWCommentSwitch *except=[KWCommentSwitch itemWithtitle:@"显示备注信息" icon:nil];
    
    group.item=@[picture,wordfond,except];
    
    
}
-(void)setUpgeneral1{
    KWCommentGroup *group=[[KWCommentGroup alloc]init];
    [self.group addObject:group];
    KWCommentSwitch *except=[KWCommentSwitch itemWithtitle:@"开启快速拖动" icon:nil];
    group.footer=@"浏览列表时可使用拖动条快速拖动";
    group.item=@[except];


}
-(void)setUpgeneral2{
    KWCommentGroup *group=[[KWCommentGroup alloc]init];
    [self.group addObject:group];
    KWCommentSwitch *except=[KWCommentSwitch itemWithtitle:@"横竖屏自动切换" icon:nil];
    
    group.item=@[except];
}
-(void)setUpgeneral3{
    KWCommentGroup *group=[[KWCommentGroup alloc]init];
    [self.group addObject:group];
    KWCommenArross *except=[KWCommenArross itemWithtitle:@"图片质量切换" icon:nil];
    
    group.item=@[except];
}
-(void)setUpgeneral4{
    KWCommentGroup *group=[[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    KWCommenArross *picture=[KWCommenArross itemWithtitle:@"声音与震动" icon:nil];
    
    KWCommenArross *wordfond=[KWCommenArross itemWithtitle:@"多语言环境" icon:nil];
    
   
    
    group.item=@[picture,wordfond];

}
-(void)setUpgeneral5{
    
}


@end
