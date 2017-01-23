//
//  KWCommmentView.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/11.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWCommmentView.h"
#import "HMSearchBar.h"
#import "KWCommentGroup.h"
#import "KWCommentCell.h"
#import "KWCommenArross.h"
#import "KWCommentSwitch.h"
#import "KWCommentLable.h"


@interface KWCommmentView ()
@property(nonatomic,strong)NSMutableArray *group;
@end

@implementation KWCommmentView

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
    self.tableView.sectionFooterHeight=10;
    self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    
    
    
  
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
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    KWCommentGroup *group=self.group[section];
    return group.footer;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    KWCommentGroup *group=self.group[section];
    return group.header;

}


@end

