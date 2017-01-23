//
//  HMComposeViewController.m
//  黑马微博
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMComposeViewController.h"
#import "KWEmtiontextView.h"
#import "HMComposeToolbar.h"
#import "HMComposePhotosView.h"
#import "HMAccountTool.h"
#import "HMAccount.h"
#import "MBProgressHUD+MJ.h"
#import "HMStatusTool.h"
#import "HMEmotionKeyboard.h"
#import "AFNetworking.h"
#import "HMEmotion.h"
#import "KWAttachment.h"

@interface HMComposeViewController () <HMComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) KWEmtiontextView *textView;
@property (nonatomic, weak) HMComposeToolbar *toolbar;
@property (nonatomic, weak) HMComposePhotosView *photosView;
@property (nonatomic, strong) HMEmotionKeyboard *kerboard;
/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;
@end

@implementation HMComposeViewController

#pragma mark - 初始化方法
- (HMEmotionKeyboard *)kerboard
{
    if (!_kerboard) {
        self.kerboard = [HMEmotionKeyboard keyboard];
        self.kerboard.width = HMScreenW;
        self.kerboard.height = 216;
    }
    return _kerboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setupNavBar];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加显示图片的相册控件
    [self setupPhotosView];
    self.changingKeyboard=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emtiondidSeleted:) name:@"HMEmotionDidSelectedNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emtiondidDelected) name:@"HMEmotionDidDeletedNotification" object:nil];
    
}
-(void)emtiondidDelected{
    [self.textView deleteBackward];
}

-(void)emtiondidSeleted:(NSNotification *)note{
    HMEmotion *emotion = note.userInfo[@"HMSelectedEmotion"];
  //  NSLog(@"%@ %@", emotion.chs, emotion.emoji);

//    NSMutableAttributedString *attributesstring=[[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
//    
//    if (emotion.emoji) {
//        
//        NSAttributedString *sub=[[NSAttributedString alloc]initWithString:emotion.emoji];
//        [attributesstring appendAttributedString:sub];
//        
//        
//        
//    }else{
//        NSTextAttachment *attach=[[NSTextAttachment alloc]init];
//        attach.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png]];
//       //  设置图片尺寸和字体大小一致
//        CGFloat attachW=self.textView.font.lineHeight;
//        CGFloat attachH=attachW;
//        attach.bounds=CGRectMake(0, -3, attachW, attachH);
//        NSAttributedString *sub=[NSAttributedString attributedStringWithAttachment:attach];
//        [attributesstring appendAttributedString:sub];
//        
//        
//        
//    }
//        [attributesstring addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, attributesstring.length)];
//    
//        // text文字的大小由font属性决定
//        // attributedText文字的大小由- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法决定
//    self.textView.attributedText=attributesstring;
    
    
    
    
    if (emotion.emoji) {
        [self.textView insertText:emotion.emoji];
    }else{
       NSMutableAttributedString *attrited=[[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
        KWAttachment *text=[[KWAttachment alloc]init];
        text.emotion=emotion;
        text.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png]];
        CGFloat attachW=self.textView.font.lineHeight;
        CGFloat attachH=attachW;
        text.bounds=CGRectMake(0, -3, attachW, attachH);
        NSAttributedString *sub=[NSAttributedString attributedStringWithAttachment:text];
        int index=(int)self.textView.selectedRange.location;
        [attrited insertAttributedString:sub atIndex:index];
        [attrited addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, attrited.length)];
        self.textView.attributedText=attrited;
        
        self.textView.selectedRange=NSMakeRange(index+1, 0);
        
        
        
    }
    
    
    
    
    
    
    
    
    [self textViewDidChange:self.textView];

}



// 添加显示图片的相册控件
- (void)setupPhotosView
{
    HMComposePhotosView *photosView = [[HMComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

// 添加工具条
- (void)setupToolbar
{
    // 1.创建
    HMComposeToolbar *toolbar = [[HMComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.delegate = self;
    toolbar.height = 44;
    self.toolbar = toolbar;
    
    // 2.显示
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}

// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
   KWEmtiontextView *textView = [[KWEmtiontextView alloc] init];
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"小葱说事...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
   [self.textView becomeFirstResponder];
}

// 设置导航条内容
- (void)setupNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(quxiao)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - 私有方法
/**
 *  取消
 */
- (void)quxiao
{
   // [self popViewControllerAnimated:YES];
   // [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
   
}

/**
 *  发送
 */
- (void)send
{
    // 1.发表微博
    if (self.photosView.images.count) {
        [self sendStatusWithImage];
    } else {
        [self sendStatusWithoutImage];
    }
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发表有图片的微博
 */
- (void)sendStatusWithImage
{

    AFHTTPRequestOperationManager *request=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"access_token"]=[HMAccountTool account].access_token;
    dict[@"status"]=self.textView.text;
    [request POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i=0; i<self.photosView.subviews.count; i++) {
            UIImageView *imageview=self.photosView.subviews[i];
            UIImage *image=imageview.image;
            NSData *data=UIImageJPEGRepresentation(image, 1.0);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        }
        
        
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"小葱说你发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"小葱装死，不在服务区"];
    }];
    
    
    
    
    
    
}


// 图文混排 ： 图片和文字混合在一起排列

/**
 *  发表没有图片的微博
 */
- (void)sendStatusWithoutImage
{
    // 1.封装请求参数
    HMSendStatusParam *param = [HMSendStatusParam param];
   // param.status = self.textView.text;
    param.status=[self realstring];
    // 2.发微博
    [HMStatusTool sendStatusWithParam:param success:^(HMSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"小葱说你发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"小葱装死，不在服务区"];
    }];
}
-(NSString *)realstring{
    NSMutableString *string=[NSMutableString string];
    [self.textView.attributedText enumerateAttributesInRange:NSMakeRange(0, self.textView.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL * _Nonnull stop) {
        KWAttachment *sub=attrs[@"NSAttachment"];
        if (sub) {
           [string appendString:sub.emotion.chs];
        
            
        }else{
            NSString *substring=[self.textView.attributedText attributedSubstringFromRange:range].string;
            [string appendString:substring];
            
        }
        
    }];
    
    
    return string;
}
#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.isChangingKeyboard) {
        self.changingKeyboard = NO;
        return;
    }
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(HMComposeToolbar *)toolbar didClickedButton:(HMComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case HMComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case HMComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case HMComposeToolbarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开表情
 */
- (void)openEmotion
{
    // 正在切换键盘
    self.changingKeyboard = YES;
    
    if (self.textView.inputView) { // 当前显示的是自定义键盘，切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情图片
        self.toolbar.showEmotionButton = YES;
    } else { // 当前显示的是系统自带的键盘，切换为自定义键盘
        // 如果临时更换了文本框的键盘，一定要重新打开键盘
        self.textView.inputView = self.kerboard;
        
        // 不显示表情图片
        self.toolbar.showEmotionButton = NO;
    }
    
    // 关闭键盘
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textView becomeFirstResponder];
    });
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加图片到相册中
    [self.photosView addImage:image];
}
@end
