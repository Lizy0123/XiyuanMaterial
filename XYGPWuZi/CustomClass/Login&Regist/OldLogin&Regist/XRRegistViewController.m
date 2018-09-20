//
//  LoginViewController.m
//  LoginDemo
//
//  Created by 河北熙元科技有限公司 on 2017/6/1.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRRegistViewController.h"

#import "LoginViewController.h"
#import "ClickTextView.h"
#import "RxWebViewController.h"

@interface XRRegistViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    UIScrollView *_backScrollView;
    UITextField *_nameField;
    UITextField *_phoneNumField;
    UITextField *_yzmField;
    UITextField *_miMaField;
    
}


@property(nonatomic,strong)UIButton *tpyeBtn;
@property(nonatomic,copy)NSString *peopleType;
//获取验证码倒计时按钮
@property(nonatomic,strong)UIButton *authCodeBtn;
//密码是否可见
@property(nonatomic,assign)BOOL isOn;
//可见按钮
@property(nonatomic,strong)UIButton *eyeBoolBtn;
//注册按钮
@property(nonatomic,strong)UIButton *zhuCeBtn;

//阅读条款按钮
@property(nonatomic,strong)UIButton *isReadBtn;
//是否阅读
@property(nonatomic,assign)BOOL isRead;

@end

@implementation XRRegistViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //默认不显示密码
    _isOn = NO;
    _isRead = YES;
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _peopleType = nil;
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    
    
    
    
    //self.view.backgroundColor = [UIColor redColor];
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height)];
    _backScrollView.backgroundColor = [UIColor whiteColor];
    _backScrollView.delegate = self;
    _backScrollView.bounces = NO;
    _backScrollView.showsVerticalScrollIndicator = NO;
    _backScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height-64);
    [self.view addSubview:_backScrollView];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 40)];
    //titleLabel.backgroundColor = [UIColor magentaColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"欢迎加入工平";
    titleLabel.font = [UIFont systemFontOfSize:22];
    [_backScrollView addSubview:titleLabel];
    

    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20, self.view.bounds.size.width-60, 30)];
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.placeholder = @"请输入姓名(限输入汉字和字母)";
    _nameField.font = [UIFont systemFontOfSize:15];
    //_nameField.backgroundColor = [UIColor magentaColor];
    
    [_backScrollView addSubview:_nameField];
    
    //一条线
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel1.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel1];

    //+86label
    UILabel *label86 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20, 40, 30)];
    //label86.backgroundColor = [UIColor magentaColor];
    label86.textAlignment = NSTextAlignmentCenter;
    label86.text = @"+86";
    label86.font = [UIFont systemFontOfSize:17];
    [_backScrollView addSubview:label86];

    //手机号field
    _phoneNumField = [[UITextField alloc]initWithFrame:CGRectMake(30+40+10, 30+40+20+30+20, self.view.bounds.size.width-30-40-30-10, 30)];
    _phoneNumField.font = [UIFont systemFontOfSize:15];
    _phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumField.placeholder = @"请输入手机号码";
    _phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    //_phoneNumField.backgroundColor = [UIColor magentaColor];
    
    [_phoneNumField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_backScrollView addSubview:_phoneNumField];
    
    //一条线
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel2.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel2];

    //验证码
    _yzmField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20, self.view.bounds.size.width-60-100, 30)];
    _yzmField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _yzmField.placeholder = @"请输入验证码";
    _yzmField.font = [UIFont systemFontOfSize:15];
    _yzmField.keyboardType = UIKeyboardTypeNumberPad;
    //_yzmField.backgroundColor = [UIColor magentaColor];
    
    [_backScrollView addSubview:_yzmField];
    
    
    
    _authCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _authCodeBtn.frame = CGRectMake(self.view.bounds.size.width-130, 30+40+20+30+20+30+20, 100, 30);
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
    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel3.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel3];

    //密码
    _miMaField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20+30+20, self.view.bounds.size.width-60-30, 30)];
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
    _eyeBoolBtn.frame = CGRectMake(self.view.bounds.size.width-60, 30+40+20+30+20+30+20+30+20+7.5, 25, 12.5);
    if (_isOn) {
        
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"redEye"] forState:UIControlStateNormal];
    }else{
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"grayEye"] forState:UIControlStateNormal];
    }
    [_eyeBoolBtn addTarget:self action:@selector(canSee) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_eyeBoolBtn];

    //一条线
    UILabel *lineLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20+30+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel4.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel4];

    
    
    //类型按钮
    _tpyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _tpyeBtn.frame = CGRectMake(30, 30+40+20+30+20+30+20+30+20+30+20, self.view.bounds.size.width-60-30, 30);
    [_tpyeBtn setTitle:@"请选择账号类型" forState:UIControlStateNormal];
    _tpyeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _tpyeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _tpyeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //_tpyeBtn.backgroundColor = [UIColor magentaColor];
    [_tpyeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_tpyeBtn addTarget:self action:@selector(choseType) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_tpyeBtn];
    
    

    //右边的小箭头
    UIButton *jianTouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jianTouBtn.frame = CGRectMake(self.view.bounds.size.width-60, 30+40+20+30+20+30+20+30+20+30+20, 30, 30);
    [jianTouBtn setImage:[UIImage imageNamed:@"ico_zhixiang"] forState:UIControlStateNormal];
    [jianTouBtn addTarget:self action:@selector(choseType) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:jianTouBtn];
    
    //一条线
    UILabel *lineLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+20+30+20+30+5+20+30, self.view.bounds.size.width-60, 0.1)];
    lineLabel5.backgroundColor = [UIColor grayColor];
    [_backScrollView addSubview:lineLabel5];
    
    //注册按钮
    _zhuCeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _zhuCeBtn.frame = CGRectMake(30, 30+40+20+30+20+30+20+30+20+30+20+30+30, self.view.bounds.size.width-60, 50);
    _zhuCeBtn.clipsToBounds = YES;
    _zhuCeBtn.layer.cornerRadius = 25;
    [_zhuCeBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_zhuCeBtn setBackgroundColor:[UIColor lightGrayColor]];
    _zhuCeBtn.userInteractionEnabled = NO;
    [_zhuCeBtn addTarget:self action:@selector(zhuCe) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_zhuCeBtn];
    
    
    //是否阅读条案按钮
    _isReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _isReadBtn.frame = CGRectMake(30, 30+40+20+30+20+30+20+30+20+30+20+30+30+50+20, 20, 20);
    [_isReadBtn setImage:[UIImage imageNamed:@"ico_yigouxuan"] forState:UIControlStateNormal];
    [_isReadBtn addTarget:self action:@selector(isReaded) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:_isReadBtn];
    
    //各种声明及条款textView
    ClickTextView *clickTextView = [[ClickTextView alloc] initWithFrame:CGRectMake(50, 30+40+20+30+20+30+20+30+20+30+20+30+30+50+10, self.view.bounds.size.width-30-30-20, 60)];
    //clickTextView.backgroundColor = [UIColor redColor];
    
    //clickTextView.userInteractionEnabled = NO;
    clickTextView.editable = YES;
    clickTextView.delegate = self;
    
    [_backScrollView addSubview:clickTextView];
    
    // 方便测试，设置textView的边框已经背景
    //clickTextView.backgroundColor = [UIColor cyanColor];
    //clickTextView.layer.borderWidth = 1;
    //clickTextView.layer.borderColor = [UIColor redColor].CGColor;
    clickTextView.font = [UIFont systemFontOfSize:13];
    //    clickTextView.textColor = [UIColor redColor];
    
    NSString *content = @"已阅读并同意《注册协议》";
    // 设置文字
    clickTextView.text = content;
    
    // 设置期中的一段文字有下划线，下划线的颜色为蓝色，点击下划线文字有相关的点击效果
    NSRange range1 = [content rangeOfString:@"《注册协议》"];
    [clickTextView setUnderlineTextWithRange:range1 withUnderlineColor:[UIColor redColor] withClickCoverColor:[UIColor lightGrayColor] withBlock:^(NSString *clickText) {
        NSLog(@"clickText = %@",clickText);
        NSLog(@"版权声明、隐私保护");/*1、保证金协议 2、拍卖规则 3、竞价服务协议 4、免责声明 5、注册协议*/
        NSString* urlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].baseUrl,@"xy/ruleOrAgreement/showDoc?type=5"];
        RxWebViewController* webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:urlStr]];
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        [self.navigationController pushViewController:webViewController animated:YES];
    }];
    

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
#pragma mark 单击手势操作
-(void)tapAction{
    [_miMaField resignFirstResponder];
    [_yzmField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_miMaField resignFirstResponder];
    
    
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
#pragma mark --导航返回按钮
-(void)backLastView{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

// 开启倒计时效果
-(void)openCountdown{
    NSString *phoneType = @"0";
    NSString *url = [myBaseUrl stringByAppendingString:[NSString stringWithFormat:@"xy/user/send/%@/%@.json",_phoneNumField.text,phoneType]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_phoneNumField.text forKey:@"phoneNumber"];
    [dict setObject:phoneType forKey:@"phoneType"];
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


#pragma mark --选择账号类型
-(void)choseType{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    [_nameField resignFirstResponder];
    [_phoneNumField resignFirstResponder];
    [_yzmField resignFirstResponder];
    [_miMaField resignFirstResponder];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"变化了");
        
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"企业" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        _peopleType = @"0";
        
        if (_nameField.text.length > 0 && _phoneNumField.text.length == 11 &&_yzmField.text.length > 0 && _miMaField.text.length > 5 ){
            
            _zhuCeBtn.userInteractionEnabled = YES;
            [_zhuCeBtn setBackgroundColor:[UIColor redColor]];

            
        }
        
        
        [_tpyeBtn setTitle:@"企业" forState:UIControlStateNormal];
        [_tpyeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSLog(@"第一种");
        
        
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"个人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _peopleType = @"1";
        
        [_tpyeBtn setTitle:@"个人" forState:UIControlStateNormal];
        [_tpyeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (_nameField.text.length > 0 && _phoneNumField.text.length == 11 &&_yzmField.text.length > 0 && _miMaField.text.length > 5 ){
            
            _zhuCeBtn.userInteractionEnabled = YES;
            [_zhuCeBtn setBackgroundColor:[UIColor redColor]];
        }
        NSLog(@"第二中");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark --密码可见
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
#pragma mark -- 注册
-(void)zhuCe{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_nameField.text forKey:@"caseName"];
    [dict setObject:_phoneNumField.text forKey:@"mobil"];
    [dict setObject:_yzmField.text forKey:@"code"];
    [dict setObject:_miMaField.text forKey:@"password"];
    [dict setObject:_peopleType forKey:@"facUserType"];
    
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_SaveRegisterUser] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"成功了返回---%@",responseObject);
        
        int codeStr = [responseObject[@"code"]intValue];
        
        if (codeStr == 200) {
            hud.labelText = @"注册成功";
            [hud hide:YES afterDelay:0.7];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:^{
                }];
                
            });
            

            
        }
        
        if (codeStr == 400) {
            
            hud.labelText = @"非法操作!";
            [hud hide:YES afterDelay:0.7];
            
        }
        if (codeStr == 500) {
            
            hud.labelText = @"注册请求异常";
            [hud hide:YES afterDelay:0.7];
            
        }
        if (codeStr == 1301) {
            
            hud.labelText = @"该手机号已注册";
            [hud hide:YES afterDelay:0.7];
          
            
        }
        if (codeStr == 1302) {
        
            hud.labelText = @"验证码有误";
            [hud hide:YES afterDelay:0.7];
        
    }
        [hud hide:YES afterDelay:0.6];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"失败了返回---%@",error);
        hud.labelText = @"注册失败";
        [hud hide:YES afterDelay:0.7];
        
        
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

}
#pragma mark -- 监听所有的TextField
-(void)textFieldChanged:(NSNotification *)notification{
    
    
    //如果先选了类型,那么直接判断textfiled的属性
    if (_peopleType) {
        if (_nameField.text.length > 0 && _phoneNumField.text.length == 11 &&_yzmField.text.length > 0 && _miMaField.text.length > 5 ) {
            
                _zhuCeBtn.userInteractionEnabled = YES;
                [_zhuCeBtn setBackgroundColor:[UIColor redColor]];
        
        }
        if (_nameField.text.length == 0 || _phoneNumField.text.length < 11 ||_yzmField.text.length ==0 ||_miMaField.text.length<6) {
            
            _zhuCeBtn.userInteractionEnabled = NO;
            [_zhuCeBtn setBackgroundColor:[UIColor lightGrayColor]];
            
            
        }
    }
    else{
        //如果没有先选择type,那么先判断type,再判断textfiled
        
        if (_nameField.text.length > 0 && _phoneNumField.text.length == 11 &&_yzmField.text.length > 0 && _miMaField.text.length > 5 ) {
            
            
            
            if (_peopleType) {
                _zhuCeBtn.userInteractionEnabled = YES;
                [_zhuCeBtn setBackgroundColor:[UIColor redColor]];
                
            }
        }
        if (_nameField.text.length == 0 || _phoneNumField.text.length < 11 ||_yzmField.text.length ==0 ||_miMaField.text.length<6) {
            
            _zhuCeBtn.userInteractionEnabled = NO;
            [_zhuCeBtn setBackgroundColor:[UIColor lightGrayColor]];
            
            
        }

    }
    
    
}
#pragma mark 是否阅读按钮
-(void)isReaded{
    if (_isRead) {
        _isRead = NO;
        [_isReadBtn setImage:[UIImage imageNamed:@"ico_weigouxuan"] forState:UIControlStateNormal];

    }
    else{
        
        _isRead = YES;
        [_isReadBtn setImage:[UIImage imageNamed:@"ico_yigouxuan"] forState:UIControlStateNormal];
        
    }
    
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}


@end
