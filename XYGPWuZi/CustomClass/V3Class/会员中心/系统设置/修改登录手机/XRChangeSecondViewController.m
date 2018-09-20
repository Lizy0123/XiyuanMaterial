//
//  XRChangeSecondViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/18.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRChangeSecondViewController.h"



@interface XRChangeSecondViewController ()
@property (nonatomic,strong)UITextField *phoneField;
@property (nonatomic,strong)UITextField *yzmField;
@property (nonatomic,strong)UIButton *button;
//获取验证码倒计时按钮
@property(nonatomic,strong)UIButton *authCodeBtn;
@end

@implementation XRChangeSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录手机";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *oldPhone = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, 80, 20)];
    oldPhone.text = @"新原手机号";
    oldPhone.textColor = [UIColor grayColor];
    oldPhone.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:oldPhone];
    
    self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(115, 12.5, S_W-115-100, 20)];
    self.phoneField.borderStyle = UITextBorderStyleNone;
    self.phoneField.textColor = [UIColor blackColor];
    self.phoneField.font = [UIFont systemFontOfSize:14];
    self.phoneField.placeholder = @"请输入手机号";
    self.phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.phoneField];
    
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, S_W-20, 0.2)];
    lineLabel1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineLabel1];
    
    
    UILabel *yzm = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5+45, 80, 20)];
    yzm.text = @"验证码";
    yzm.textColor = [UIColor grayColor];
    yzm.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:yzm];
    
    
    
    self.yzmField = [[UITextField alloc]initWithFrame:CGRectMake(115, 12.5+45, S_W-115-15-15, 20)];
    self.yzmField.keyboardType = UIKeyboardTypeNumberPad;
    self.yzmField.borderStyle = UITextBorderStyleNone;
    self.yzmField.placeholder = @"请输入验证码";
    self.yzmField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.yzmField];
    self.yzmField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, S_W-20, 0.2)];
    lineLabel2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineLabel2];
  
    _authCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _authCodeBtn.frame = CGRectMake(S_W-100, 7.5, 80, 30);
    [_authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _authCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_authCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_authCodeBtn addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_authCodeBtn];
    

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    _button = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"下一步" andFrame:CGRectMake(16, 0, S_W-32, 44) target:self action:@selector(next)];
    _button.userInteractionEnabled = NO;
    _button.alpha = 0.5;
    [bottomView addSubview:_button];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(S_W, kViewAtBottomHeight));
    }];

    //添加所有TextField监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldChanged:)name:UITextFieldTextDidChangeNotification object:nil];
    
    
}
#pragma mark -- 监听所有的TextField
-(void)textFieldChanged:(NSNotification *)notification{
    
    if (self.phoneField.text.length > 11) {
        
        [self.phoneField resignFirstResponder];
        
    }
    if (_yzmField.text.length > 5) {
        
        [_yzmField resignFirstResponder];
        
    }
    
}
-(void)next{
    
    __block UserModel *entityMember = [UserManager readUserInfo];

    //token：登录令牌 | mobil：新的手机号|code1:原手机的验证码（上一步获取的验证码）|code2:新手机号的验证码
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:entityMember.token forKey:@"token"];
    [dict setObject:_phoneField.text forKey:@"mobil"];
    [dict setObject:self.yzm forKey:@"code1"];
    [dict setObject:_yzmField.text forKey:@"code2"];
    
    __weak typeof(self)weakSelf = self;
    MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_UpadteMobile] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hudd hide:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        
        int codeStr = [responseObject[@"code"]intValue];
        
        if (codeStr == 200) {

            hud.labelText = @"修改成功";
            [hud hide:YES afterDelay:1];
            entityMember.mobil = responseObject[@"object"];
            [UserManager  saveUserInfo:entityMember];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                
            });
            
        }
        
        //{"code":200,"object":"18831516966","success":true}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hudd hide:YES];
    }];
    
    
    
}

-(void)openCountdown{
    
    if (![NSObject isMobileNum:self.phoneField.text]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"请输入正确的手机号";
        [hud hide:YES afterDelay:0.7];
    }else{
    
    NSString *phoneType = @"3";
    NSString *url = [myBaseUrl stringByAppendingString:[NSString stringWithFormat:@"xy/user/send/%@/%@.json",self.phoneField.text,phoneType]];
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        
        int codeStr = [responseObject[@"code"]intValue];
        
        if (codeStr == 200) {
            hud.labelText = @"短信发送成功";
            [hud hide:YES afterDelay:1];
            weakSelf.button.userInteractionEnabled = YES;
            weakSelf.button.alpha = 1;
        }
        if (codeStr == 500) {
            hud.labelText = @"异常操作";
            [hud hide:YES afterDelay:1];
        }
        if (codeStr == 1305) {
            hud.labelText = @"短信发送失败";
            [hud hide:YES afterDelay:1];
        }
        if (codeStr == 1306) {
            hud.labelText = @"手机号不合法";
            [hud hide:YES afterDelay:1];
        }
        if (codeStr == 1324) {
            hud.labelText = @"手机号已绑定";
            [hud hide:YES afterDelay:1];
        }
        [hud hide:YES afterDelay:1];
        
        
       //200：短信发送成功！ | 500：异常操作！ | 1305：短信发送失败！ | 1306：手机号码不合法！1324：手机号已绑定其它帐号
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
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
                [self.authCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.authCodeBtn setTitle:[NSString stringWithFormat:@"%.2d秒", seconds] forState:UIControlStateNormal];
                [self.authCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = NO;
                
                
                
                
                
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
