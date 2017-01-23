//
//  KWCommentCell.m
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/10.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "KWCommentCell.h"
#import "KWCommenArross.h"
#import "KWCommentSwitch.h"
#import "KWCommentLable.h"
#import "KWcommentBtn.h"


@interface KWCommentCell()
@property(nonatomic,strong)UIImageView   *leftArross;
@property(nonatomic,strong)UISwitch *rightSwitch;
@property(nonatomic,strong)UILabel *rightLable;
@property(nonatomic,strong)KWcommentBtn *bedageview;
@end

@implementation KWCommentCell



-(KWcommentBtn *)bedageview{
    if (_bedageview==nil) {
        self.bedageview=[[KWcommentBtn alloc]init];
    }
    return _bedageview;
}
-(UILabel *)rightLable{
    if (_rightLable==nil) {
        self.rightLable=[[UILabel alloc]init];
    }
    return _rightLable;
}



-(UIImageView *)leftArross{
    if (_leftArross==nil) {
      self.leftArross=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _leftArross;
}


-(UISwitch *)rightSwitch{
    if (_rightSwitch==nil) {
        self.rightSwitch=[[UISwitch alloc]init];
    }
    return _rightSwitch;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
    
    }
    return self;
}
+(instancetype)cellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"cell";
    
    KWCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[KWCommentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.font=[UIFont systemFontOfSize:12];
        self.textLabel.font=[UIFont systemFontOfSize:14];
        self.backgroundView=[[UIImageView alloc]init];
        self.selectedBackgroundView=[[UIImageView alloc]init];

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.detailTextLabel.x=CGRectGetMaxX(self.textLabel.frame);
}



-(void)setImageWithIndex:(NSIndexPath *)indexpath rowInsection:(NSInteger)num{
    UIImageView *background=(UIImageView *)self.backgroundView;
    UIImageView *selected=(UIImageView *)self.selectedBackgroundView;
    if (num==1) {
       
            background.image = [UIImage resizedImage:@"common_card_background"];
            selected.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    }else if (indexpath.row==1){
        background.image = [UIImage resizedImage:@"common_card_top_background"];
        selected.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];

    }else if (indexpath.row==num-1){
        background.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selected.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    }else{
        background.image = [UIImage resizedImage:@"common_card_middle_background"];
        selected.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
    
    
    
    
}

-(void)setItem:(KWCommenItem *)item{
    _item=item;
    self.textLabel.text=item.title;
    self.detailTextLabel.text=item.subtitle;
    self.imageView.image=[UIImage imageNamed:item.icon];
    if (item.bedage) {
        self.bedageview.bedage=item.bedage;
        self.accessoryView=self.bedageview;
    }
    
   else if ([item isKindOfClass:[KWCommenArross class]]) {
        self.accessoryView=self.leftArross;
    }else if ([item isKindOfClass:[KWCommentSwitch class]]){
        self.accessoryView=self.rightSwitch;
    }else if ([item isKindOfClass:[KWCommentLable class]]){
        KWCommentLable *item1=(KWCommentLable *)item;
        
        self.accessoryView=item1.rightLable;
        
        
    
    }else{
        self.accessoryView=nil;
    }
    }




@end
