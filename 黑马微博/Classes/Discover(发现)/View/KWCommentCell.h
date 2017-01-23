//
//  KWCommentCell.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/10.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KWCommenItem.h"
@interface KWCommentCell : UITableViewCell



@property(nonatomic,strong)KWCommenItem *item;
+(instancetype)cellWithTableview:(UITableView *)tableView;

-(void)setImageWithIndex:(NSIndexPath *)indexpath rowInsection:(NSInteger)num;
@end
