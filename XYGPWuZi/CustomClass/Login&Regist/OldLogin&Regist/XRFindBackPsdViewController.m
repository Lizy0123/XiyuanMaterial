//
//  XRFindBackPsdViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRFindBackPsdViewController.h"

@interface XRFindBackPsdViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_backScrollView;
    UITextField *_phoneNumField;
    UITextField *_yzmField;
    UITextField *_miMaField;
    UITextField *_qrMiMaField;
    
}
//获取验证码倒计时按钮
@property(nonatomic,strong)UIButton *authCodeBtn;
//密码是否可见
@property(nonatomic,assign)BOOL isOn;
//可见按钮
@property(nonatomic,strong)UIButton *eyeBoolBtn;
//确定按钮
@property(nonatomic,strong)UIButton *queDingBtn;

@end

@implementation XRFindBackPsdViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //默认不显示密码
    _isOn = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigation];
    
    [self creatUI];
}
#pragma mark -- 页面控件布局
-(void)creatUI{
    
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height)];
    _backScrollView.backgroundColor = [UIColor whiteColor];
    _backScrollView.delegate = self;
    _backScrollView.bounces = NO;
    _backScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_backScrollView];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 40)];
    //titleLabel.backgroundColor = [UIColor magentaColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"找回密码";
    titleLabel.font = [UIFont systemFontOfSize:22];
    [_backScrollView addSubview:titleLabel];
    
    //+86label
    UILabel *label86 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20, 40, 30)];
    //label86.backgroundColor = [UIColor magentaColor];
    label86.textAlignment = NSTextAlignmentCenter;
    label86.text = @"+86";
    label86.font = [UIFont systemFontOfSize:17];
    [_backScrollView addSubview:label86];
    
    //手机号field
    _phoneNumField = [[UITextField alloc]initWithFrame:CGRectMake(30+40+10, 30+40+20, self.view.bounds.size.width-30-40-30-10, 30)];
    _phoneNumField.font = [UIFont systemFontOfSize:15];
    _phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumField.placeholder = @"请输入手机号码";
    _phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    //_phoneNumField.backgroundColor = [UIColor magentaColor];
    
    [_phoneNumField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_backScrollView addSubview:_phoneNumField];
    
    //一条线
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel1.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel1];
    
    //验证码
    _yzmField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20, self.view.bounds.size.width-60-100, 30)];
    _yzmField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _yzmField.placeholder = @"请输入验证码";
    _yzmField.font = [UIFont systemFontOfSize:15];
    _yzmField.keyboardType = UIKeyboardTypeNumberPad;
    //_yzmField.backgroundColor = [UIColor magentaColor];
    
    [_backScrollView addSubview:_yzmField];
    
    
    
    _authCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _authCodeBtn.frame = CGRectMake(self.view.bounds.size.width-130, 30+40+20+30+20, 100, 30);
    [_authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _authCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _authCodeBtn.clipsToBounds = YES;
    _authCodeBtn.layer.cornerRadius = 15;
    _authCodeBtn.backgroundColor = [UIColor redColor];
    _authCodeBtn.userInteractionEnabled = NO;
    _authCodeBtn.alpha = 0.5;
    
    [_authCodeBtn addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_authCodeBtn];
    //一条线
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel2.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel2];
    
    //密码
    _miMaField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20, self.view.bounds.size.width-60-30, 30)];
    _miMaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _miMaField.font = [UIFont systemFontOfSize:15];
    _miMaField.placeholder = @"请输入密码(6-16位数组+字母)";
    _miMaField.secureTextEntry = YES;
    _miMaField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    //_yzmField.keyboardType = UIKeyboardTypeNumberPad;
    //_miMaField.backgroundColor = [UIColor magentaColor];
    
    [_backScrollView addSubview:_miMaField];
    
    //密码可见按钮
    _eyeBoolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _eyeBoolBtn.frame = CGRectMake(self.view.bounds.size.width-60, 30+40+20+30+20+30+20+7.5, 25, 12.5);
    if (_isOn) {
        
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"redEye"] forState:UIControlStateNormal];
    }else{
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"grayEye"] forState:UIControlStateNormal];
    }
    [_eyeBoolBtn addTarget:self action:@selector(canSee) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_eyeBoolBtn];
    
    //一条线
    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel3.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel3];

    //密码
    _qrMiMaField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20+30+20, self.view.bounds.size.width-60, 30)];
    _qrMiMaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _qrMiMaField.font = [UIFont systemFontOfSize:15];
    _qrMiMaField.placeholder = @"请再次输入密码";
    _qrMiMaField.secureTextEntry = YES;
    _qrMiMaField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
   
    [_backScrollView addSubview:_qrMiMaField];
    
    //一条线
    UILabel *lineLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20+30+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel4.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel4];
    
    //确定按钮
    _queDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _queDingBtn.frame = CGRectMake(30, 30+40+20+30+20+30+20+30+20+30+30, self.view.bounds.size.width-60, 50);
    _queDingBtn.clipsToBounds = YES;
    _queDingBtn.layer.cornerRadius = 25;
    [_queDingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_queDingBtn setBackgroundColor:[UIColor lightGrayColor]];
    _queDingBtn.userInteractionEnabled = NO;
    [_queDingBtn addTarget:self action:@selector(queDing) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_queDingBtn];

    _backScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,30+40+20+30+20+30+20+30+20+30+30+50);
    
    //更改所有textfiled光标的颜色
    [[UITextField appearance] setTintColor:[UIColor redColor]];
    
    //添加手势点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    [_backScrollView addGestureRecognizer:tap];
    
    
    //添加所有TextField监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldChanged:)name:UITextFieldTextDidChangeNotification object:nil];
    
    //添加键盘监听事件
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
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
        
        _backScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height-64+offset);
        
        
    }
}
#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    
    _backScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height-64);
    
}

#pragma mark -- 设置导航
-(void)setUpNavigation{
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarMetricsDefault;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[self drawPngWithAlpha:1] forBarMetrics:UIBarMetricsDefault];
    
    //自定义一个按钮
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 16, 16);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"ico_denglu_cha"] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    
}
// 开启倒计时效果
-(void)openCountdown{
    
    
    NSString *phoneType = @"1";
    
    NSString *url = [myBaseUrl stringByAppendingString:[NSString stringWithFormat:@"xy/user/send/%@/%@.json",_phoneNumField.text,phoneType]];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:_phoneNumField.text forKey:@"phoneNumber"];
//    [dict setObject:phoneType forKey:@"phoneType"];
//
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功了返回---%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"成功了返回---%@",error);
    }];
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.authCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.authCodeBtn setTitle:[NSString stringWithFormat:@"(%.2ds)", seconds] forState:UIControlStateNormal];
                [self.authCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = NO;

                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
#pragma mark -- 密码是否可见
-(void)canSee{
    
    if (_isOn) {
        _miMaField.secureTextEntry = _isOn;
        _isOn = NO;
        
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"grayEye"] forState:UIControlStateNormal];
        
    }else{
        _miMaField.secureTextEntry = _isOn;
        _isOn = YES;
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"redEye"] forState:UIControlStateNormal];
    }
    
    
}

#pragma mark -- 确定
-(void)queDing{
    
    if ([_miMaField.text isEqualToString:_qrMiMaField.text]) {
       
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        
        
        //mobil：手机号 | password：密码 | code：验证码
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:_phoneNumField.text forKey:@"mobil"];
        [dict setObject:_yzmField.text forKey:@"code"];
        [dict setObject:_qrMiMaField.text forKey:@"password"];
        __weak typeof(self)weakSelf =self;
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindBackUserPwd] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"成功了返回---%@",responseObject);
            //200：密码修改成功！ | 400：非法操作！ | 500：异常操作！ | 1302：验证码输入错误！ | 1307：该手机账号不存在！ |
            int codeStr = [responseObject[@"code"]intValue];
            
            if (codeStr == 200) {
                hud.labelText = @"密码修改成功";
                [hud hide:YES afterDelay:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            
            if (codeStr == 400) {
                
                hud.labelText = @"非法操作!";
                [hud hide:YES afterDelay:1];
                
            }
            if (codeStr == 500) {
                
                hud.labelText = @"请求异常";
                [hud hide:YES afterDelay:1];
                
            }
            if (codeStr == 1302) {
                
                hud.labelText = @"验证码输入错误";
                [hud hide:YES afterDelay:1];
                
            }
            if (codeStr == 1307) {
                
                hud.labelText = @"该手机账号不存在";
                [hud hide:YES afterDelay:1];
                
            }
            if (codeStr == 1308) {
                
                hud.labelText = @"该账号已被锁定，请联系客服";
                [hud hide:YES afterDelay:1];
                
            }
            if (codeStr == 1309) {
                
                hud.labelText = @"密码修改失败";
                [hud hide:YES afterDelay:1];
                
            }
            
            
            
            
            [hud hide:YES afterDelay:0.6];
            
            
            //1308：该手机账号已被锁定，请联系平台客服！ | 1309：密码修改失败！
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败了返回---%@",error);
            hud.labelText = @"修改失败";
            [hud hide:YES afterDelay:1];
            
        }];
        
        [hud hide:YES afterDelay:5];
        
        NSString * regex = @"^[A-Za-z0-9]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if(![pred evaluateWithObject: _miMaField.text]){
            
            NSLog(@"请输入6-16位字母数字组合");
            MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hudd.mode = MBProgressHUDModeCustomView;
            hudd.labelText = @"请输入6-16位字母数字组合";
            [hudd hide:YES afterDelay:0.7];
            
        }

    }else{
        
        MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hudd.mode = MBProgressHUDModeCustomView;
        hudd.labelText = @"两次密码不一致";
        [hudd hide:YES afterDelay:0.7];
        
    }
    
    
    
}
#pragma mark -- 监听所有的TextField
-(void)textFieldChanged:(NSNotification *)notification{
    
    if (_phoneNumField.text.length >0&& _miMaField.text.length > 5 && _qrMiMaField.text.length >5) {
        
        
        _queDingBtn.userInteractionEnabled = YES;
        _queDingBtn.alpha = 1;
        [_queDingBtn setBackgroundColor:[UIColor redColor]];
    }
    else{
        
        _queDingBtn.userInteractionEnabled = NO;
        _queDingBtn.alpha = 0.5;
        [_queDingBtn setBackgroundColor:[UIColor lightGrayColor]];
        
    }
    
    
}
#pragma mark 单击手势操作
-(void)tapAction{
    
    
    [_phoneNumField resignFirstResponder];
    [_miMaField resignFirstResponder];
    [_qrMiMaField resignFirstResponder];
    [_yzmField resignFirstResponder];
    
}



#pragma mark --导航返回按钮
-(void)backLastView{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 绘制图片
- (UIImage *)drawPngWithAlpha:(CGFloat)alpha
{
    UIColor *color = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    //位图大小
    CGSize size = CGSizeMake(1, 1);
    //绘制位图
    UIGraphicsBeginImageContext(size);
    //获取当前创建的内容
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //充满指定的填充色
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    //充满指定的矩形
    CGContextFillRect(contextRef, CGRectMake(0, 0, 1, 1));
    //绘制image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束绘制
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark --监听文本框变化
-(void)textFieldDidChange:(UITextField *)textField{
    
    
    if (textField == _phoneNumField) {
        
        NSLog(@"%ld",_phoneNumField.text.length);
        if (_phoneNumField.text.length ==11) {
            
            [_phoneNumField resignFirstResponder];
            _authCodeBtn.userInteractionEnabled = YES;
            _authCodeBtn.alpha = 1;
  
        }
    }
    
    NSLog(@"变化了");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
