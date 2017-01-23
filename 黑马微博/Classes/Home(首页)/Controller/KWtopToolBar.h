//
//  KWtopToolBar.h
//  黑马微博
//
//  Created by kangweihexiaocong on 16/1/12.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMStatus.h"
typedef enum{
    KWtopToolBarbuttonTypeComment,
    KWtopToolBarbuttonTypeMove,
    KWtopToolBarbuttonTypeAttitude
}KWtopToolBarbuttonType;



@class  KWtopToolBar;
@protocol  KWtopToolBarDeledate <NSObject>

- (void)composeTool:(KWtopToolBar *)toolbar didClickedButton:(KWtopToolBarbuttonType)buttonType;

@end

@interface KWtopToolBar : UIView

@property(nonatomic,strong)HMStatus *status;


@property(nonatomic,assign)id<KWtopToolBarDeledate> delegate;
@property(nonatomic,assign)KWtopToolBarbuttonType *seletedbuttontype;
+(instancetype)toobar;
@end
