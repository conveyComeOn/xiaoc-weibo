
//
//  HMDiscoverViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMDiscoverViewController.h"
#import "HMSearchBar.h"
#import "KWCommentGroup.h"
#import "KWCommentCell.h"
#import "KWCommenArross.h"
#import "KWCommentSwitch.h"
#import "KWCommentLable.h"

@interface HMDiscoverViewController ()
@property(nonatomic,strong)NSMutableArray *group;
@end

@implementation HMDiscoverViewController

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
    self.view.backgroundColor=HMColor(211, 211, 211);
    self.tableView.sectionHeaderHeight=10;
    self.tableView.sectionFooterHeight=0;
    self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    
    
    HMSearchBar *searchBar = [HMSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    [self setUpgroupItem];
}

-(void)setUpgroupItem{
    [self setUpgroupItem1];
    [self setUpgroupItem2];
    [self setUpgroupItem3];
}


-(void)setUpgroupItem1{
    KWCommentGroup *group=[[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    
    
        KWCommenArross *hot=[KWCommenArross itemWithtitle:@"热门微博" icon:@"hot_status"];
    hot.subtitle=@"笑话，娱乐，神最右都搬到这啦";
  
    
    
    KWCommenArross *findPeople = [KWCommenArross itemWithtitle:@"找人" subtitle:@"名人、有意思的人尽在这里" icon:@"find_people"];
   
    
    
    group.item=@[hot,findPeople];
    
    
    
    
}
-(void)setUpgroupItem2{
    
    // 1.创建组
   KWCommentGroup *group = [[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    // 2.设置组的所有行数据
    KWCommenItem *gameCenter = [KWCommenItem itemWithtitle:@"游戏中心" icon:@"game_center"];
  gameCenter.bedage=@"123";
    
    
    KWCommenItem *near = [ KWCommenItem itemWithtitle:@"周边" icon:@"near"  ];
    
                       
 KWCommentSwitch *app = [ KWCommentSwitch itemWithtitle:@"应用" icon:@"app"];
                      
    
    group.item = @[gameCenter, near, app];
    
    
    
}
-(void)setUpgroupItem3{
    // 1.创建组
    KWCommentGroup *group = [[KWCommentGroup alloc]init];
    [self.group addObject:group];
    
    // 2.设置组的所有行数据
   KWCommentLable *video = [KWCommentLable itemWithtitle:@"视频" icon:@"video" ];
    UILabel *right=[[UILabel alloc]init];
    right.text=@"hahaha";
    video.rightLable=right;
                         
     KWCommenItem *music = [ KWCommenItem itemWithtitle:@"音乐" icon:@"music"   ];
                         
    KWCommenItem *movie = [ KWCommenItem itemWithtitle:@"电影" icon:@"movie"   ];
                          
     KWCommentSwitch *cast = [ KWCommentSwitch itemWithtitle:@"播客" icon:@"cast"   ];
    
   KWCommenItem *more = [ KWCommenItem itemWithtitle:@"更多" icon:@"more"   ];
    
    
    group.item = @[video, music, movie, cast, more];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return self.group.count;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    KWCommentGroup *group=self.group[section];
    return group.item.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KWCommentCell *cell=[KWCommentCell cellWithTableview:tableView];
    KWCommentGroup *group=self.group[indexPath.section];
     cell.item=group.item[indexPath.row];
    [cell setImageWithIndex:indexPath rowInsection:group.item.count];
  
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    KWCommentGroup *group=self.group[indexPath.section];
    KWCommenItem *item=group.item[indexPath.row];
    if (item.destVcClass) {
        UIViewController *destv=[[item.destVcClass alloc]init];
        destv.title=item.title;
        [self.navigationController pushViewController:destv animated:YES];
        
    }
    if (item.option) {
        item.option();
    }
    
}

@end
