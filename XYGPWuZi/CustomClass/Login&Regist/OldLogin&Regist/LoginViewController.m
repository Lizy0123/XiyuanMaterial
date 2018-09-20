
//
//  XRLoginViewController.m
//  LoginDemo
//
//  Created by 河北熙元科技有限公司 on 2017/6/2.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "XRRegistViewController.h"
#import "XRFindBackPsdViewController.h"

@interface LoginViewController ()<UINavigationControllerDelegate>

//账号登录界面
@property(nonatomic,strong)UIView *ZHLoginView;
//手机号登录界面
@property(nonatomic,strong)UIView *SJHLoginView;
//ZHLoginView这个视图是否在最上层,默认为YES
@property(nonatomic,assign)BOOL isTop;




//模拟左侧nav返回按钮
@property(nonatomic,strong)UIButton *backBtn;
//右上角跳转按钮
@property(nonatomic,strong)UIButton *topRightBtn;
//账号textfiled
@property(nonatomic,strong)UITextField *nameField;
//密码textfiled
@property(nonatomic,strong)UITextField *miMaField;
//密码可见按钮
@property(nonatomic,strong)UIButton *eyeBoolBtn;
//密码是否可见
@property(nonatomic,assign)BOOL isOn;
//登录按钮
@property(nonatomic,strong)UIButton *loginBtn;
//忘记密码按钮
@property(nonatomic,strong)UIButton *forgetBtn;
//注册按钮
@property(nonatomic,strong)UIButton *regiseBtn;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isTop = YES;
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //window.backgroundColor = [UIColor whiteColor];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
-(void)backLastView{
    [_miMaField resignFirstResponder];
    [_nameField resignFirstResponder];
    //    __weak typeof(self)weakself = self;
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.delegate = self;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarMetricsDefault;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[self drawPngWithAlpha:1] forBarMetrics:UIBarMetricsDefault];
    
    [self configUI];
    
    //添加所有TextField监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:)name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Delegate_Navigation
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:animated];
}

-(void)configUI{
    //自定义一个按钮
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 16, 16);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"ico_denglu_cha"] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    _ZHLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _ZHLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_ZHLoginView];
    _regiseBtn =  [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"注  册" andFrame:CGRectMake(2, 2, 2, 44) target:self action:@selector(jumpToRegiseVC)];
    [_ZHLoginView addSubview:_regiseBtn];
    [_regiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(S_W-32, 44));
        make.left.equalTo(self.view).offset(16);
        if (kDevice_iPhoneX) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-34);
        }else{
            make.bottom.equalTo(self.view.mas_bottom).offset(-5);
        }
        
    }];
    
    //右侧跳转按钮
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-120, 34, 90, 16);
    [backbtn addTarget:self action:@selector(overturnView) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backbtn setTitle:@"账号登录" forState:UIControlStateNormal];
    backbtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_SJHLoginView addSubview:backbtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 40)];
    //titleLabel.backgroundColor = [UIColor magentaColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"账号登录";
    titleLabel.font = [UIFont systemFontOfSize:22];
    [_ZHLoginView addSubview:titleLabel];
    
    //账号textfiled
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20, self.view.bounds.size.width-60, 30)];
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.placeholder = @"请输入账号或手机号";
    _nameField.font = [UIFont systemFontOfSize:15];
    //_nameField.backgroundColor = [UIColor magentaColor];
    [_ZHLoginView addSubview:_nameField];
    
    //一条线
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel1.backgroundColor = [UIColor grayColor];
    [_ZHLoginView addSubview:lineLabel1];
    
    
    //密码
    _miMaField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20, self.view.bounds.size.width-60-30, 30)];
    _miMaField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _miMaField.font = [UIFont systemFontOfSize:15];
    _miMaField.placeholder = @"请输入密码(6-16位数组+字母)";
    _miMaField.secureTextEntry = YES;
    _miMaField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    //_yzmField.keyboardType = UIKeyboardTypeNumberPad;
    //_miMaField.backgroundColor = [UIColor magentaColor];
    
    [_ZHLoginView addSubview:_miMaField];
    
    //密码可见按钮
    _eyeBoolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _eyeBoolBtn.frame = CGRectMake(self.view.bounds.size.width-60, 30+40+20+30+20+7.5, 25, 12.5);
    if (_isOn) {
        
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"redEye"] forState:UIControlStateNormal];
    }else{
        [_eyeBoolBtn setImage:[UIImage imageNamed:@"grayEye"] forState:UIControlStateNormal];
    }
    [_eyeBoolBtn addTarget:self action:@selector(canSee) forControlEvents:UIControlEventTouchUpInside];
    [_ZHLoginView addSubview:_eyeBoolBtn];
    
    
    //一条线
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30+40+20+30+20+30+5, self.view.bounds.size.width-60, 0.1)];
    lineLabel2.backgroundColor = [UIColor grayColor];
    [_ZHLoginView addSubview:lineLabel2];
    
    //登录按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(30, 30+40+20+30+20+30+30, self.view.bounds.size.width-60, 50);
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.cornerRadius = 25;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:[UIColor lightGrayColor]];
    _loginBtn.alpha = 0.2;
    _loginBtn.userInteractionEnabled = NO;
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [_ZHLoginView addSubview:_loginBtn];
    
    
    _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetBtn.frame = CGRectMake(self.view.bounds.size.width-80-30, 30+40+20+30+20+30+30+50+20, 80, 30);
    [_forgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_forgetBtn addTarget:self action:@selector(fogitMiMa) forControlEvents:UIControlEventTouchUpInside];
    [_ZHLoginView addSubview:_forgetBtn];
    
    
    //更改所有textfiled光标的颜色
    [[UITextField appearance] setTintColor:[UIColor redColor]];
    
    //添加手势点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    [_ZHLoginView addGestureRecognizer:tap];
}
#pragma mark -- 跳转注册界面
-(void)jumpToRegiseVC{
    XRRegistViewController *vc = [[XRRegistViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
#pragma mark 单击手势操作
-(void)tapAction{
    [_nameField resignFirstResponder];
    [_miMaField resignFirstResponder];
}
#pragma mark 登录操作
-(void)login:(UIButton *)btn{
    [_miMaField resignFirstResponder];
    [_nameField resignFirstResponder];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_nameField.text forKey:@"mobil"];
    [dict setObject:_miMaField.text forKey:@"password"];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_ZHLoginView animated:YES];
    hud.color = [UIColor lightGrayColor];
    __weak LoginViewController * weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindUserLogin] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[hud hide:YES];
        NSLog(@"登录后返回----%@",responseObject);
        int codeStr = [responseObject[@"code"] intValue];
        float loadingTime = 1.0f;
        
        if (codeStr == 200) {
            //code:200 登陆成功
            hud.labelText = @"登录成功";
            [hud hide:YES afterDelay:loadingTime];
            
            //1.创建UUseModel
            UserModel *userModel = [[UserModel alloc] initWithDictionary:responseObject[@"object"] error:nil];
            if (!userModel) {
                return ;
            }
            //2.存储UserInfo（userModel）
            userModel.codeId = responseObject[@"codeId"];
            userModel.token = responseObject[@"token"];
            userModel.facId = responseObject[@"facId"];
            userModel.status = responseObject[@"status"];
            [UserManager saveUserInfo:userModel];
            //3.token存储到useDefault中
            if (((NSString *)responseObject[@"token"]).length>0) {
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setValue:responseObject[@"token"] forKey:kToken];
                [userDefault synchronize];
            }else{
                [UserManager clearUserInfo];
            }
        
            
//            Member *member = [[Member alloc]init];
//            //token:登录令牌
//            member.token = responseObject[@"token"];
//            //codeId:账号主键ID
//            member.codeId = responseObject[@"codeId"];
//            //caseName:姓名
//            member.caseName = responseObject[@"object"][@"caseName"];
//            //loginName:登陆账号
//            member.loginName = responseObject[@"object"][@"loginName"];
//            //facIsTrade:交易会员（0、否 1、是）
//            member.facIsTrade = responseObject[@"object"][@"facIsTrade"];
//            //email:电子邮箱
//            member.email = responseObject[@"object"][@"email"];
//            //mobil:手机号码
//            member.mobil = responseObject[@"object"][@"mobil"];
//            //facUserType:账户类型（0、企业 1、个人）
//            member.facUserType = responseObject[@"object"][@"facUserType"];
//            //facIsTradeReson:交易会员不通过原因
//            member.facIsTradeReson = responseObject[@"object"][@"facIsTradeReson"];
//            //facHeadPic:头像地址
//            member.facHeadPic = responseObject[@"object"][@"facHeadPic"];
//            //facSex:性别（1、男 2、女）
//            member.facSex = responseObject[@"object"][@"facSex"];
//            //facProvince:省
//            member.facProvince = responseObject[@"object"][@"facProvince"];
//            //facCity:市
//            member.facCity = responseObject[@"object"][@"facCity"];
//            //facCounty:县
//            member.facCounty = responseObject[@"object"][@"facCounty"];
//            //facAddress:详细地址
//            member.facAddress = responseObject[@"object"][@"facAddress"];
//
//            [member save];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(loadingTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //登录成功后跳转
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                }];
            });
            
        }else{
            if (codeStr == 1310) {
                hud.labelText = @"登录信息不合法";
                [hud hide:YES afterDelay:loadingTime];
            }
            if (codeStr == 1311) {
                hud.labelText = @"账号或密码不正确";
                [hud hide:YES afterDelay:loadingTime];
                
            }  if (codeStr == 1312) {
                hud.labelText = @"缓存数据异常";
                [hud hide:YES afterDelay:loadingTime];
            }
            [hud hide:YES afterDelay:loadingTime];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
    }];
    [hud hide:YES afterDelay:5];
}
#pragma mark -- 监听所有的TextField
-(void)textFieldChanged:(NSNotification *)notification{
    if (_nameField.text.length >0&& _miMaField.text.length >= 6) {
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.alpha = 1;
        [_loginBtn setBackgroundColor:[UIColor redColor]];
    }
    else{
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.alpha = 0.5;
        [_loginBtn setBackgroundColor:[UIColor lightGrayColor]];
    }  
}
#pragma mark 忘记密码
-(void)fogitMiMa{
    XRFindBackPsdViewController *vc = [[XRFindBackPsdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//翻转到手机号登录界面
-(void)overturnView{
    self.isTop = !self.isTop;
    UIView *fromView = self.isTop ? self.SJHLoginView : self.ZHLoginView;
    UIView *toView = self.isTop ? self.ZHLoginView : self.SJHLoginView;

    UIViewAnimationOptions transitionDirection = self.isTop ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionFromView:fromView toView:toView duration:1.0 options:transitionDirection completion:^(BOOL finished) {
    }];
}


@end
