//
//  HMMessageViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMMessageViewController.h"


@interface HMMessageViewController ()

@end

@implementation HMMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
}

/**
 *  写私信
 */
- (void)composeMsg
{
    HMLog(@"composeMsg");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"消息测试数据----%d", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        UIViewController *newVc = [[UIViewController alloc] init];
    
        UIImageView *imageview=[[UIImageView alloc]init];
imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random_uniform(11)]];
//    imageview.image=[UIImage imageNamed:@"xiaocong1.jpg"];
        imageview.frame=newVc.view.bounds;
        [newVc.view addSubview:imageview];
        newVc.title = @"别看人家";
        [self.navigationController pushViewController:newVc animated:YES];
   
}
@end
