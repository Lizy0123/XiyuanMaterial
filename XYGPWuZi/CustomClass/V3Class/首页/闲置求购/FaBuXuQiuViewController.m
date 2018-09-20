//
//  FaBuXuQiuViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "FaBuXuQiuViewController.h"
#import "AddressManageerViewController.h"

#define cellHeight 44
@interface FaBuXuQiuViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UIScrollView *backGroundScrollView;
@property (nonatomic,strong)UIButton *bottomButton;

@end

@implementation FaBuXuQiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布需求";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    _backGroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    _backGroundScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _backGroundScrollView.bounces = NO;
    _backGroundScrollView.alwaysBounceVertical = YES;
    _backGroundScrollView.alwaysBounceHorizontal = NO;
    _backGroundScrollView.pagingEnabled = NO;
    _backGroundScrollView.showsVerticalScrollIndicator = YES;
    _backGroundScrollView.showsHorizontalScrollIndicator = NO;
    _backGroundScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _backGroundScrollView.scrollsToTop = YES;
    [self.view addSubview:_backGroundScrollView];
    
    [_backGroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self configBottomBtn];
    [self configUI];
}
#pragma 页面布局
-(void)configUI{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, S_W-40, 20)];
    label1.text = @"需求信息";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor grayColor];
    [_backGroundScrollView addSubview:label1];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, S_W, cellHeight *2)];
    view1.backgroundColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:view1];
    
    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 20)];
    label11.text = @"需求标题";
    label11.font = [UIFont systemFontOfSize:13];
    label11.textColor = [UIColor blackColor];
    [view1 addSubview:label11];
    
    _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 12, S_W-100-20, 20)];
    _textField1.placeholder = @"请输入求购标题";
    _textField1.font = [UIFont systemFontOfSize:13];
    _textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField1.borderStyle = UITextBorderStyleNone;
    _textField1.textColor = [UIColor blackColor];
    [view1 addSubview:_textField1];
    
    _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 12+cellHeight, S_W-100-20, 20)];
    _textField2.placeholder = @"请输入求购关键词";
    _textField2.font = [UIFont systemFontOfSize:13];
    _textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField2.borderStyle = UITextBorderStyleNone;
    _textField2.textColor = [UIColor blackColor];
    [view1 addSubview:_textField2];
    
    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+cellHeight, 80, 20)];
    label12.text = @"关键词";
    label12.font = [UIFont systemFontOfSize:13];
    label12.textColor = [UIColor blackColor];
    [view1 addSubview:label12];
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, cellHeight, S_W, 0.3)];
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view1 addSubview:line1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 138, S_W-40, 20)];
    label2.text = @"求购人信息";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor grayColor];
    [_backGroundScrollView addSubview:label2];
    
    /***************************************************************************/
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 168, S_W, cellHeight*3)];
    view2.backgroundColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:view2];
    
    UILabel *label21 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 20)];
    label21.text = @"联系地址";
    label21.font = [UIFont systemFontOfSize:13];
    label21.textColor = [UIColor blackColor];
    [view2 addSubview:label21];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(100, 12, S_W-100-10, 20);
    //button3.backgroundColor = [UIColor cyanColor];
    [button3 addTarget:self action:@selector(choseProductAddress) forControlEvents:UIControlEventTouchUpInside];
    button3.userInteractionEnabled = YES;
    [view2 addSubview:button3];
    
    self.productAddressField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, S_W-100-10-15, 20)];
    self.productAddressField.userInteractionEnabled = NO;
    _productAddressField.placeholder = @"选择地区";
    _productAddressField.delegate = self;
    _productAddressField.font = [UIFont systemFontOfSize:13];
    _productAddressField.textAlignment = NSTextAlignmentRight;
    _productAddressField.textColor = [UIColor blackColor];
    [button3 addSubview:_productAddressField];
    
    UIImageView *rightImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(S_W-100-10-15, 0, 12, 20)];
    rightImage3.image = [UIImage imageNamed:@"ico_zhixiang"];
    [button3 addSubview:rightImage3];
    
    
    
    
    UILabel *label22 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+cellHeight, 80, 20)];
    label22.text = @"联系电话";
    label22.font = [UIFont systemFontOfSize:13];
    label22.textColor = [UIColor blackColor];
    [view2 addSubview:label22];
    
    _textField3 = [[UITextField alloc]initWithFrame:CGRectMake(100, 12+cellHeight, S_W-100-20, 20)];
    _textField3.placeholder = @"请输入联系电话";
    _textField3.font = [UIFont systemFontOfSize:13];
    _textField3.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField3.borderStyle = UITextBorderStyleNone;
    _textField3.keyboardType = UIKeyboardTypeNumberPad;
    _textField3.textColor = [UIColor blackColor];
    [view2 addSubview:_textField3];
    
    UILabel *label23 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+cellHeight*2, 80, 20)];
    label23.text = @"电子邮箱";
    label23.font = [UIFont systemFontOfSize:13];
    label23.textColor = [UIColor blackColor];
    [view2 addSubview:label23];
    
    _textField4 = [[UITextField alloc]initWithFrame:CGRectMake(100, 12+cellHeight+cellHeight, S_W-100-20, 20)];
    _textField4.placeholder = @"请输入电子邮箱";
    _textField4.font = [UIFont systemFontOfSize:13];
    _textField4.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField4.borderStyle = UITextBorderStyleNone;
    _textField4.textColor = [UIColor blackColor];
    _textField4.keyboardType = UIKeyboardTypeTwitter;
    [view2 addSubview:_textField4];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, cellHeight+cellHeight*i, S_W, 0.3)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view2 addSubview:view];
    }
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 40*2+cellHeight*5+20, S_W, 160)];
    view3.backgroundColor = [UIColor whiteColor];
    [_backGroundScrollView addSubview:view3];
    
    UILabel *label31 = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 20)];
    label31.text = @"需求详情";
    label31.font = [UIFont systemFontOfSize:13];
    label31.textColor = [UIColor blackColor];
    [view3 addSubview:label31];
    
    
    _textView1 = [[MyTextView alloc]initWithFrame:CGRectMake(100, 12, S_W-100-20, 160-15)];
    _textView1.placeHolder = @"非必填项,可选填";
    _textView1.delegate = self;
    _textView1.font = [UIFont systemFontOfSize:13];
    _textView1.textColor = [UIColor blackColor];
    [view3 addSubview:_textView1];
    
    _backGroundScrollView.contentSize = CGSizeMake(S_W, 40*2+cellHeight*5+20+160+10+kViewAtBottomHeight);
    
    //添加键盘监听事件
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
        
        _backGroundScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,40*2+cellHeight*5+20+160+10+kViewAtBottomHeight+offset);
        
        
    }
}
#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    
    _backGroundScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,40*2+cellHeight*5+20+160+10+kViewAtBottomHeight);
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    NSLog(@"%s",__FUNCTION__);
    if (textView == _textView1) {
        
        _textView1.hidePlaceHolder = YES;
    }
    
}
#pragma 底部按钮
-(void)configBottomBtn{
    self.bottomButton = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"提交" andFrame:CGRectMake(1, 1, 1, 44) target:self action:@selector(next)];
    [self.view addSubview:_bottomButton];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.size.mas_equalTo(CGSizeMake(S_W-32, 44));
        make.bottom.equalTo(self.view).offset(44-kTabBarHeight);
    }];
    
    //右上角按钮
    UIBarButtonItem *rightLoginBtn = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = rightLoginBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
}
#pragma mark - 选择产品地区
-(void)choseProductAddress{
    NSLog(@"选择地区");
    AddressManageerViewController *address = [[AddressManageerViewController alloc]init];
    __weak typeof(self)weakSelf =self;
    address.blockAddress = ^(NSDictionary *newAddress){
        NSLog(@"--地址和编码------%@",newAddress);
        
        if (newAddress.count == 4) {
            weakSelf.productAddressField.text = [NSString stringWithFormat:@"%@,%@",newAddress[@"province"],newAddress[@"city"]];
        }
        else if (newAddress.count == 6){
            weakSelf.productAddressField.text = [NSString stringWithFormat:@"%@,%@,%@",newAddress[@"province"],newAddress[@"city"],newAddress[@"area"]];
            weakSelf.piProvince = newAddress[@"firstAddress"];
            weakSelf.piCity = newAddress[@"secondAddress"];
            weakSelf.piCounty = newAddress[@"thirdAddress"];
        }
    };
    
    [self.view endEditing:YES];
    [self.navigationController pushViewController:address animated:YES];
}

-(void)next{
    //token：登录令牌 | riId：（此参数修改需要，添加不需要）| riTitle：需求标题 | riKeyword：关键词 | riTel：联系电话 | riEmail：电子邮箱 | riContent：内容详情 | riProvinceId：省编码 | riCityId：市编码 | riCountyId：县编码 | riAddress：详细地址
    __weak typeof(self)weakSelf = self;
    if (_textField1.text.length == 0 || _textField2.text.length == 0 || _textField3.text.length==0||_textField4.text.length==0 ||_productAddressField.text.length == 0) {
        NSLog(@"请补全信息");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请补全信息";
        
        [hud hide:YES afterDelay:0.7];
        
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:kStringToken forKey:@"token"];
        [dict setObject:_textField1.text forKey:@"riTitle"];
        [dict setObject:_textField2.text forKey:@"riKeyword"];
        [dict setObject:_textField3.text forKey:@"riTel"];
        [dict setObject:_textField4.text forKey:@"riEmail"];
        if (_textView1.text) {
            [dict setObject:_textView1.text forKey:@"riContent"];
        }
        [dict setObject:self.piProvince forKey:@"riProvinceId"];
        [dict setObject:self.piCity forKey:@"riCityId"];
        [dict setObject:self.piCounty forKey:@"riCountyId"];
        [dict setObject:_productAddressField.text forKey:@"riAddress"];
        NSLog(@"----dict--%@",dict);
        
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FabuXuqiu] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"----responseObject---%@",responseObject);
            int codestr = [responseObject[@"code"]intValue];
            if (codestr == 200) {
                hud.labelText = @"发布成功";
                [hud hide:YES afterDelay:0.5];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [hud hide:YES];
            
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
