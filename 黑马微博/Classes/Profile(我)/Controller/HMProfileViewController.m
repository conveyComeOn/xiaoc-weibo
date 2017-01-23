//
//  HMProfileViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//





#import "HMProfileViewController.h"
#import "HMSearchBar.h"
#import "KWCommentGroup.h"
#import "KWCommentCell.h"
#import "KWCommenArross.h"
#import "KWCommentSwitch.h"
#import "KWCommentLable.h"
#import "KWSettingController.h"


@interface HMProfileViewController ()
@property(nonatomic,strong)NSMutableArray *group;
@end

@implementation HMProfileViewController

-(id)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

-(NSMutableArray *)group{
    if (_group==nil) {
        _group=[NSMutableArray array];
        
    }
    return _group;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];

    
    
    
//    self.view.backgroundColor=HMColor(211, 211, 211);
//    self.tableView.sectionHeaderHeight=10;
//    self.tableView.sectionFooterHeight=0;
//    self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
//    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
//    
    
   
    [self setUpgroupItem];
}






- (void)setting
{
    KWSettingController *setting=[[KWSettingController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
    
    
    
}








-(void)setUpgroupItem{
    [self setUpgroupItem1];
    [self setUpgroupItem2];
    
}


-(void)setUpgroupItem1{
    KWCommentGroup *group=[[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    
    
    KWCommenArross *hot=[KWCommenArross itemWithtitle:@"新的好友" icon:@"new_friend"];
    hot.subtitle=@"5";
    

    
    
    
    group.item=@[hot];
    
    
    
    
}
-(void)setUpgroupItem2{
    
    // 1.创建组
    KWCommentGroup *group = [[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    // 2.设置组的所有行数据
    KWCommenItem *gameCenter = [KWCommenItem itemWithtitle:@"我的相册" icon:@"album"];
    gameCenter.subtitle=@"(100)";
    
    
    KWCommenItem * collect = [ KWCommenItem itemWithtitle:@"我的收藏" icon:@"collect"  ];
    
    collect.subtitle = @"(10)";
    collect.bedage = @"1";
    
    KWCommenArross *like = [KWCommenArross
                            itemWithtitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
    like.bedage = @"10";
    
    
    group.item = @[gameCenter,collect , like ];
    
    
    
}



@end
