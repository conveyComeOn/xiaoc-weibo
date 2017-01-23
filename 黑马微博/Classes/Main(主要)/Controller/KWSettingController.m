//
//  KWSettingController.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/11.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWSettingController.h"
#import "KWCommentGroup.h"
#import "KWCommenArross.h"
#import "KWCommentSwitch.h"
#import "KWCommentLable.h"
#import "KWGeneralSettingViewController.h"
@interface KWSettingController ()

@end

@implementation KWSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    view.height=35;
    view.width=HMScreenW;
    UILabel *lable=[[UILabel alloc]init];

    lable.text=@"退出当前账号";
    lable.font=[UIFont systemFontOfSize:15];
    lable.textColor=[UIColor redColor];
    self.tableView.tableFooterView=view;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.height=35;
    lable.width=[lable.text sizeWithFont:lable.font].width;
    lable.centerX=view.centerX;
    lable.centerY=view.centerY;
    [view addSubview:lable];
    
    [self setupGroups];
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
   KWCommentGroup *group = [[KWCommentGroup alloc]init];
    group.footer = @"tail部";
    [self.group addObject:group];
    
    // 2.设置组的所有行数据
    KWCommenArross *newFriend = [KWCommenArross itemWithtitle:@"帐号管理" icon:nil];
    
    
    group.item = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    KWCommentGroup *group = [[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    // 2.设置组的所有行数据
    KWCommenArross *newFriend = [KWCommenArross itemWithtitle:@"主题、背景" icon:nil];
                                 
    
    group.item = @[newFriend];
}

- (void)setupGroup2
{
    // 1.创建组
    KWCommentGroup *group = [[KWCommentGroup alloc]init];
      group.header = @"头部";
    [self.group addObject:group];

    
    // 2.设置组的所有行数据
    KWCommenArross *generalSetting = [KWCommenArross itemWithtitle:@"通用设置" icon:nil];
    
    generalSetting.destVcClass = [KWGeneralSettingViewController class];
    
    group.item = @[generalSetting];
}



@end
