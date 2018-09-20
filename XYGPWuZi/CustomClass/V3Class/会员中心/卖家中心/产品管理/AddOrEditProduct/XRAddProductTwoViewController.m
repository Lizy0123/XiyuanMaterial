//
//  XRAddProductTwoViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRAddProductTwoViewController.h"
#import "MyProductViewController.h"
#define kCellHeght 44
@interface XRAddProductTwoViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIScrollView *backGroundScrollView;
@property (nonatomic,strong)UIButton *bottomButton;
@property (nonatomic,strong)MBProgressHUD *hud;

@end

@implementation XRAddProductTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加产品";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=NO;
    

    _backGroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    _backGroundScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _backGroundScrollView.bounces = YES;
    _backGroundScrollView.alwaysBounceVertical = YES;
    _backGroundScrollView.alwaysBounceHorizontal = NO;
    _backGroundScrollView.pagingEnabled = NO;
    _backGroundScrollView.showsVerticalScrollIndicator = YES;
    _backGroundScrollView.showsHorizontalScrollIndicator = NO;
    _backGroundScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _backGroundScrollView.scrollsToTop = YES;

    [self.view addSubview:_backGroundScrollView];
    [_backGroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
      
    }];
    [self bottomBtn];
    [self setupUI];
}
#pragma 页面布局
-(void)setupUI{
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, S_W-20*2, 20)];
    label1.text = @"产品属性完善";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor grayColor];
    [_backGroundScrollView addSubview:label1];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, S_W, kCellHeght*2)];
    view1.backgroundColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:view1];
    
    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 120, 20)];
    label11.text = @"仓库";
    label11.font = [UIFont systemFontOfSize:13];
    label11.textColor = [UIColor blackColor];
    [view1 addSubview:label11];
    
    _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(160, 12, S_W-160-20, 20)];
    _textField1.placeholder = @"非必填项,可选填";
    _textField1.font = [UIFont systemFontOfSize:13];
    _textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField1.borderStyle = UITextBorderStyleNone;
    _textField1.textColor = [UIColor blackColor];
    [view1 addSubview:_textField1];
    
    _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(160, 12+kCellHeght, S_W-160-20, 20)];
    _textField2.placeholder = @"非必填项,可选填";
    _textField2.font = [UIFont systemFontOfSize:13];
    _textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField2.borderStyle = UITextBorderStyleNone;
    _textField2.textColor = [UIColor blackColor];
    [view1 addSubview:_textField2];
    
    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+kCellHeght, 110, 20)];
    label12.text = @"废旧资材计价方式";
    label12.font = [UIFont systemFontOfSize:13];
    label12.textColor = [UIColor blackColor];
    [view1 addSubview:label12];
  
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, kCellHeght, S_W, 0.3)];
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view1 addSubview:line1];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 40+kCellHeght*2+10, S_W-40, 20)];
    label2.text = @"产品编号输入";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor grayColor];
    [_backGroundScrollView addSubview:label2];
    
    /***************************************************************************/
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 168, S_W, kCellHeght*4)];
    view2.backgroundColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:view2];
    
    UILabel *label21 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 70, 20)];
    label21.text = @"仓储号";
    label21.font = [UIFont systemFontOfSize:13];
    label21.textColor = [UIColor blackColor];
    [view2 addSubview:label21];
    
    _textField3 = [[UITextField alloc]initWithFrame:CGRectMake(120, 12, S_W-120-20, 20)];
    _textField3.placeholder = @"非必填项,可选填";
    _textField3.font = [UIFont systemFontOfSize:13];
    _textField3.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField3.borderStyle = UITextBorderStyleNone;
    _textField3.textColor = [UIColor blackColor];
    [view2 addSubview:_textField3];
    
    UILabel *label22 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+kCellHeght, 70, 20)];
    label22.text = @"资源号";
    label22.font = [UIFont systemFontOfSize:13];
    label22.textColor = [UIColor blackColor];
    [view2 addSubview:label22];
    
    _textField4 = [[UITextField alloc]initWithFrame:CGRectMake(120, 12+kCellHeght, S_W-120-20, 20)];
    _textField4.placeholder = @"非必填项,可选填";
    _textField4.font = [UIFont systemFontOfSize:13];
    _textField4.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField4.borderStyle = UITextBorderStyleNone;
    _textField4.textColor = [UIColor blackColor];
    [view2 addSubview:_textField4];
    
    UILabel *label23 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+kCellHeght*2, 70, 20)];
    label23.text = @"内部管理号";
    label23.font = [UIFont systemFontOfSize:13];
    label23.textColor = [UIColor blackColor];
    [view2 addSubview:label23];
    
    _textField5 = [[UITextField alloc]initWithFrame:CGRectMake(120, 12+kCellHeght*2, S_W-120-20, 20)];
    _textField5.placeholder = @"非必填项,可选填";
    _textField5.font = [UIFont systemFontOfSize:13];
    _textField5.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField5.borderStyle = UITextBorderStyleNone;
    _textField5.textColor = [UIColor blackColor];
    [view2 addSubview:_textField5];
    
    UILabel *label24 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+kCellHeght*3, 70, 20)];
    label24.text = @"捆包号";
    label24.font = [UIFont systemFontOfSize:13];
    label24.textColor = [UIColor blackColor];
    [view2 addSubview:label24];
    
    _textField6 = [[UITextField alloc]initWithFrame:CGRectMake(120, 12+kCellHeght*3, S_W-120-20, 20)];
    _textField6.placeholder = @"非必填项,可选填";
    _textField6.font = [UIFont systemFontOfSize:13];
    _textField6.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField6.borderStyle = UITextBorderStyleNone;
    _textField6.textColor = [UIColor blackColor];
    [view2 addSubview:_textField6];
    
    
    for (int i = 0; i < 3; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kCellHeght+kCellHeght*i, S_W, 0.5)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view2 addSubview:view];
    }
    
    
    
     /***************************************************************************/
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 354, S_W, 100)];
    view3.backgroundColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:view3];
    
    UILabel *label31 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 70, 20)];
    label31.text = @"资源描述";
    label31.font = [UIFont systemFontOfSize:13];
    label31.textColor = [UIColor blackColor];
    [view3 addSubview:label31];

    
    _textView1 = [[MyTextView alloc]initWithFrame:CGRectMake(120, 12, S_W-120-20, 100-15)];
    _textView1.placeHolder = @"非必填项,可选填";
    _textView1.delegate = self;
    _textView1.font = [UIFont systemFontOfSize:13];
    _textView1.textColor = [UIColor blackColor];
    [view3 addSubview:_textView1];

    
    
     /***************************************************************************/
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 464, S_W, 80)];
    view4.backgroundColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:view4];
    
    UILabel *label41 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 70, 20)];
    label41.text = @"产品备注";
    label41.font = [UIFont systemFontOfSize:13];
    label41.textColor = [UIColor blackColor];
    [view4 addSubview:label41];
    
    _textView2 = [[MyTextView alloc]initWithFrame:CGRectMake(120, 12, S_W-120-20, 80-15)];
    _textView2.placeHolder = @"非必填项,可选填";
    _textView2.delegate = self;
    _textView2.font = [UIFont systemFontOfSize:13];
    _textView2.textColor = [UIColor blackColor];
    [view4 addSubview:_textView2];
    
    
    
    UILabel *buttomLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 566.5, 15, 15)];
    buttomLabel1.layer.cornerRadius = 12;
    buttomLabel1.clipsToBounds = YES;
    buttomLabel1.text = @"!";
    buttomLabel1.textAlignment = NSTextAlignmentCenter;
    buttomLabel1.backgroundColor = [UIColor blueColor];
    buttomLabel1.font = [UIFont boldSystemFontOfSize:14];
    buttomLabel1.textColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:buttomLabel1];
    
    UILabel *buttomLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 564, 200, 20)];
    buttomLabel.text = @"以上内容为非必填,可跳过";
    buttomLabel.font = [UIFont systemFontOfSize:13];
    buttomLabel.textColor = [UIColor blueColor];
    [_backGroundScrollView addSubview:buttomLabel];
    
    _backGroundScrollView.contentSize = CGSizeMake(S_W, 584+kViewAtBottomHeight);
    
    //添加键盘监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //添加手势点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    [self.backGroundScrollView addGestureRecognizer:tap];
    
    
}
#pragma mark 单击手势操作
-(void)tapAction{
    
    [self.view endEditing:YES];
    
}
#pragma mark ---- 根据键盘高度将当前视图向上滚动同样高度
///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    //double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"-----%f",offset);
    
    
    
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        
        _backGroundScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,offset+584+kViewAtBottomHeight);
        
        
    }
}
#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    
    _backGroundScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,584+kViewAtBottomHeight);
    
}

#pragma 底部按钮
-(void)bottomBtn{
    
    self.bottomButton = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"下一步" andFrame:CGRectMake(1, 1, 1, 44) target:self action:@selector(next)];
    [self.view addSubview:_bottomButton];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(S_W-32, 44));
        make.left.equalTo(self.view).offset(16);
        make.bottom.equalTo(self.view).offset(-6-kSafeAreaBottomHeight);
        
    }];
    
    
}
-(void)setImageUrlArray:(NSMutableArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    
}
#pragma mark - 提交
-(void)next{
    
    NSLog(@"-有图片url吗---%@",self.imageUrlArray);
    NSLog(@"-有图片吗---%@",self.imageArray);
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.imageArray.count>0) {
    
        [self upLoadPictureWithImageArray:self.imageArray andIamgeUrlArray:self.imageUrlArray success:^{
          
        }];
    }else{
        [self upLoadProductWithUrls:self.imageUrlArray];
       
    }
}
//上传图片
-(void)upLoadPictureWithImageArray:(NSMutableArray *)imageArray andIamgeUrlArray:(NSMutableArray *)imageUrlArray success:(void (^)(void))finishUpLoadPictue{
    __weak typeof(self)weakSelf = self;
    //接收返回的图片url
    NSMutableArray *receivedUrlArray = [NSMutableArray array];
    for (int i = 0; i< imageArray.count; i++) {
        
        UIImage *image = (UIImage *)imageArray[i];
        NSData * imageData = UIImageJPEGRepresentation(image, 0.5);
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_UpLoadPic] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:imageData name:@"uploadPic" fileName:@"uploadPic.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"图片上传-responseObject--%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                NSString *str = responseObject[@"object"][@"saveUrl"];
                [receivedUrlArray addObject:str];
                if (receivedUrlArray.count == imageArray.count) {
    
                    NSMutableArray *addImageUrlArray = [NSMutableArray arrayWithArray:imageUrlArray];
                    [addImageUrlArray addObjectsFromArray:receivedUrlArray];
                    
                    [weakSelf upLoadProductWithUrls:addImageUrlArray];
                    NSLog(@"--图片上传完成-----addImageUrlArray---%@",addImageUrlArray);
                    finishUpLoadPictue();
                    
                }
            }
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error=%@",error);
        }];
    }
}

//上传产品
-(void)upLoadProductWithUrls:(NSMutableArray *)imageUrlArray{
    __weak typeof(self)weakSelf = self;
    NSString *imageUrlStr = @"";
    for (int i = 0; i<imageUrlArray.count; i++) {
        imageUrlStr = [imageUrlStr stringByAppendingString:[NSString stringWithFormat:@"%@,",imageUrlArray[i]]];
    }
    NSLog(@"--准备上传产品---图片url===%@",imageUrlStr);
    NSMutableDictionary *parma = [[NSMutableDictionary alloc]init];

    //必填参数
    if (weakSelf.piId) {
        [parma setObject:weakSelf.piId forKey:@"piId"];
    }
    [parma setObject:[UserManager readUserInfo].token forKey:@"token"];
    [parma setObject:imageUrlStr forKey:@"piPics"];
    [parma setObject:weakSelf.name forKey:@"piName"];
    [parma setObject:weakSelf.shuliang forKey:@"piNumber"];
    [parma setObject:weakSelf.danwei forKey:@"piUnit"];
    [parma setObject:weakSelf.xinghao forKey:@"piCpxh"];
    [parma setObject:weakSelf.pinpai forKey:@"piCpcd"];
    [parma setObject:weakSelf.xinjiu forKey:@"piXjcd"];
    [parma setObject:weakSelf.zhuangtai forKey:@"piDqzt"];
    [parma setObject:weakSelf.workTime forKey:@"piGzxs"];
    [parma setObject:weakSelf.time forKey:@"piScDate"];
    [parma setObject:weakSelf.minPrice forKey:@"piMinPrice"];
    [parma setObject:weakSelf.address forKey:@"piAddress"];
    [parma setObject:weakSelf.piProvince forKey:@"piProvince"];
    [parma setObject:weakSelf.piCity forKey:@"piCity"];
    [parma setObject:weakSelf.piCounty forKey:@"piCounty"];
    if (weakSelf.piCateFirst) {
        [parma setObject:weakSelf.piCateFirst forKey:@"piCateFirst.proCategoryId"];
    }
    if (weakSelf.piCateSecond) {
        [parma setObject:weakSelf.piCateSecond forKey:@"piCateSecond.proCategoryId"];
    }
    if (weakSelf.piCateThird) {
        [parma setObject:weakSelf.piCateThird forKey:@"piCateThird.proCategoryId"];
    }
    if (weakSelf.piCateThird) {
        [parma setObject:weakSelf.piCateThird forKey:@"category.proCategoryId"];
    }else if (weakSelf.piCateSecond){
        [parma setObject:weakSelf.piCateSecond forKey:@"category.proCategoryId"];
    }else{
        [parma setObject:weakSelf.piCateFirst forKey:@"category.proCategoryId"];
    }
    //选填
    if (_textField1.text) {
        [parma setObject:_textField1.text forKey:@"piWarehouse"];
    }
    if (_textField2.text) {
        [parma setObject:_textField2.text forKey:@"piJjfs"];
    }
    if (_textField3.text) {
        [parma setObject:_textField3.text forKey:@"piCch"];
    }
    if (_textField4.text) {
        [parma setObject:_textField4.text forKey:@"piZyh"];
    }
    if (_textField5.text) {
        [parma setObject:_textField5.text forKey:@"piGlh"];
    }
    if (_textField6.text) {
        [parma setObject:_textField6.text forKey:@"piKbh"];
    }
    if (_textView1.text) {
        [parma setObject:_textView1.text forKey:@"piZyms"];
    }
    if (_textView2.text) {
        [parma setObject:_textView2.text forKey:@"piMark"];
    }
    NSLog(@"--parma参数:----%@",parma);
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_AddProduct] parameters:parma progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.hud hide:YES];
        NSLog(@"--添加产品成功--%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            int par = [responseObject[@"params"]intValue];
            if (par == 2) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
                hud.labelText = @"添加产品成功";
                [hud hide:YES afterDelay:0.6];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功,是否继续上传" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        MyProductViewController *vc = [MyProductViewController new];
                        vc.selectedPage = 0;
                        [self.navigationController pushViewController:vc animated:YES];
                        //[weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    }];
                    [alert addAction:action1];
                    [alert addAction:action2];
                    [weakSelf.navigationController presentViewController:alert animated:YES completion:nil];
  
                });
            }
            if (par == 0) {
                
                //0、操作失败 2、添加成功 1、修改成功 3、该产品已经生成场次，不能编辑。
                MBProgressHUD *hud0 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud0.mode = MBProgressHUDModeText;
                hud0.labelText = @"操作失败";
                [hud0 hide:YES afterDelay:0.7];
                
            }
            if (par == 1) {
                MBProgressHUD *hud0 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud0.mode = MBProgressHUDModeText;
                hud0.labelText = @"修改成功,请等待审核";
                [hud0 hide:YES afterDelay:0.7];
                NSLog(@"修改成功");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];

                });
                
            }
            if (par == 3) {
                MBProgressHUD *hud3 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud3.mode = MBProgressHUDModeText;
                hud3.labelText = @"该产品已经生成场次,不能编辑";
                [hud3 hide:YES afterDelay:0.7];
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        
    }];
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    NSLog(@"%s",__FUNCTION__);
    if (textView == _textView1) {
        
        _textView1.hidePlaceHolder = YES;
    }
    if (textView == _textView2) {
        
        _textView2.hidePlaceHolder = YES;
    }
}

@end
