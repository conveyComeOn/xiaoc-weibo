//
//  KWDetileStatus.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/12.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWDetileStatus.h"
#import "HMStatusDetailFrame.h"
#import "HMStatusDetailView.h"
#import "KWDetileSTatusToolBar.h"
#import "KWtopToolBar.h"
#import "HMStatusTool.h"
#import "KWCommentParam.h"
#import "KWComment.h"
#import "KWCommentResult.h"
#import "HMStatus.h"
#import "AFNetworking.h"
#import "KWResponseParam.h"
#import "KWResponseReault.h"
#import "HMHttpTool.h"
@interface KWDetileStatus ()<UITableViewDelegate,UITableViewDataSource,KWtopToolBarDeledate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)KWtopToolBar *top;
@property(nonatomic,strong)NSMutableArray *comments ;
@property(nonatomic,strong)NSMutableArray *response ;
@property(nonatomic,strong)UIButton *seletedBtn;

@end

@implementation KWDetileStatus

-(NSMutableArray *)response{
    if (_response==nil) {
        self.response=[NSMutableArray array];
    }
    return _response;
}
- (NSMutableArray *)comments
{
    if (_comments == nil) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}


-(KWtopToolBar *)top{
    if (_top==nil) {
        self.top=[KWtopToolBar toobar];
        self.top.delegate=self;
              self.top.status=self.status;
    }
    return _top;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.title=@"微博详情";
         [self setupTableview];
   
    [self setuptoolbar];
    [self setheader];
    
    [self composeTool:self.top didClickedButton:KWtopToolBarbuttonTypeComment];
}


-(void)setupTableview{
    UITableView *tableview=[[UITableView alloc]init];
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;

    tableview.backgroundColor=HMColor(211, 211, 211);
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.width = self.view.width;
   tableview.height = self.view.height - 44;
    self.tableview=tableview;
    [self.view addSubview:tableview];
    
  
    
}
-(void)setheader{
    HMStatusDetailView *detile=[[HMStatusDetailView alloc]init];
    HMStatusDetailFrame *frame=[[HMStatusDetailFrame alloc]init];
    
    frame.status=self.status;
    
    detile.detailFrame=frame;
    

    detile.height=CGRectGetMaxY(frame.frame);
    
    self.tableview.tableHeaderView=detile;
}

-(void)setuptoolbar{
    
    KWDetileSTatusToolBar *toolbar=[[KWDetileSTatusToolBar alloc]init];
    toolbar.width=HMScreenW;
    toolbar.height=44;
    toolbar.x=0;
    toolbar.y=self.view.size.height-toolbar.height;
    
    [self.view addSubview:toolbar];
    
    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.top.seletedbuttontype==KWtopToolBarbuttonTypeComment) {
         return self.comments.count;
    }else{
        NSLog(@"%lu",self.response.count);
        return self.response.count;
        
    }
   
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:id];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id];
           }
  
    if (self.top.seletedbuttontype==KWtopToolBarbuttonTypeComment) {
        KWComment *comment=self.comments[indexPath.row];
        cell.textLabel.text=comment.text;
      
    }else {
        
        HMStatus *status = self.response[indexPath.row];
        NSLog(@"%@",status.text,"-----");
        cell.textLabel.text = status.text;
       
    }
    

    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.top;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.top.height;
}
-(void)composeTool:(KWtopToolBar *)toolbar didClickedButton:(KWtopToolBarbuttonType)buttonType{
  
    switch (buttonType) {
        case KWtopToolBarbuttonTypeComment:
            
            [self loadComment];
            break;
            
        case KWtopToolBarbuttonTypeMove:
           
            [self loadMove];
            break;
            
        case KWtopToolBarbuttonTypeAttitude:
            [self loadAttitude];
            break;
    }
    
    
    
    
}



-(void)loadComment{
        KWCommentParam *param=[KWCommentParam param];
   
    param.id = self.status.idstr;
    KWComment *cmt = [self.comments firstObject];
    param.since_id = cmt.idstr;
    [HMStatusTool commentWithPara:param success:^(KWCommentResult *result) {
       self.status.comments_count=result.total_number;
        self.top.status=self.status;
    
        NSIndexSet *set=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
      
        [self.comments insertObjects:result.comments atIndexes:set];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
      
    }];
    
    
}

-(void)loadMove{
    
    
       KWResponseParam *param=[KWResponseParam param];
    
    param.id = self.status.idstr;
    HMStatus *status = [self.response firstObject];
    param.since_id = status.idstr;
  
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"id"]=self.status.idstr;
  
   
    [HMStatusTool responsetWithParam:param success:^(KWResponseReault *result) {
       
        self.status.reposts_count=result.total_number;
        self.top.status=self.status;
        
        
        NSIndexSet *index=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.response insertObjects:result.reposts atIndexes:index];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
          NSLog(@"--------");
    }];

    //@"https://api.weibo.com/2/statuses/repost_timeline.json"
    


    
}
-(void)loadAttitude{
    
    
    
}
@end
