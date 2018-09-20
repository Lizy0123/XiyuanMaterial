//
//  XRChangePhoneFirstViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/18.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRChangePhoneFirstViewController.h"
#import "XRChangeSecondViewController.h"



@interface XRChangePhoneFirstViewController ()
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UITextField *yzmLabel;
@property (nonatomic,strong)UIButton *button;

@property (nonatomic,copy)__block NSString *yzm;
//获取验证码倒计时按钮
@property(nonatomic,strong)UIButton *authCodeBtn;
@end

@implementation XRChangePhoneFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改登录手机";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *oldPhone = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, 80, 20)];
    oldPhone.text = @"原手机号";
    oldPhone.textColor = [UIColor grayColor];
    oldPhone.font = [UIFont systemFontOfSize:14]; 
    [self.view addSubview:oldPhone];

    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 12.5, S_W-115-100, 20)];
    self.phoneLabel.text = self.oldPhoneNumber;
    self.phoneLabel.textColor = [UIColor blackColor];
    self.phoneLabel.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:self.phoneLabel];

    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, S_W-20, 0.2)];
    lineLabel1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineLabel1];
    
    
    UILabel *yzm = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5+45, 80, 20)];
    yzm.text = @"验证码";
    yzm.textColor = [UIColor grayColor];
    yzm.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:yzm];
    
    
    
    self.yzmLabel = [[UITextField alloc]initWithFrame:CGRectMake(115, 12.5+45, S_W-115-15-15, 20)];
    self.yzmLabel.keyboardType = UIKeyboardTypeNumberPad;
    self.yzmLabel.borderStyle = UITextBorderStyleNone;
    self.yzmLabel.placeholder = @"请输入验证码";
    self.yzmLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.yzmLabel];
    self.yzmLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
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
    [bottomView addSubview:_button];

    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(S_W, kViewAtBottomHeight));
    }];
    

    //添加所有TextField监听事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldChanged:)name:UITextFieldTextDidChangeNotification object:nil];
    
}
//跳转下一页,先验证验证码
-(void)next{
    
    NSLog(@"%@",self.yzm);
    if (_yzmLabel.text.length==0) {
        NSLog(@"验证码不能为空");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"验证码不能为空";
        [hud hide:YES afterDelay:0.7];
    }else{
        if (_yzmLabel.text.length < 6) {
            NSLog(@"验证码不正确");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.labelText = @"验证码不正确";
            [hud hide:YES afterDelay:0.7];
            
        }else{
            //token：登录令牌 |code:验证码
            //验证验证码
            __weak typeof(self)weakSelf = self;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:_yzmLabel.text forKey:@"code"];
            [dict setObject:kStringToken forKey:@"token"];
            [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_CheckMobileCode] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [hud hide:YES];
                int codeStr = [responseObject[@"code"]intValue];
             
                if (codeStr == 200) {
                    XRChangeSecondViewController *vc = [[XRChangeSecondViewController alloc]init];
                    vc.yzm = weakSelf.yzmLabel.text;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                // 1302：验证码错误
                if (codeStr == 1302) {
                   MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
                    hudd.mode = MBProgressHUDModeCustomView;
                    hudd.labelText = @"验证码不正确";
                    [hudd hide:YES afterDelay:1.0];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [hud hide:YES];
            }];
        }
    }
}
#pragma mark -- 监听所有的TextField
-(void)textFieldChanged:(NSNotification *)notification{
    if (_yzmLabel.text.length > 5) {
        [self.view endEditing:YES];
    }
}
-(void)openCountdown{
    
    NSString *phoneType = @"2";
    NSString *url = [myBaseUrl stringByAppendingString:[NSString stringWithFormat:@"xy/user/send/%@/%@.json",self.oldPhoneNumber,phoneType]];
    __weak typeof(self)weakSelf = self;

    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功了返回---%@",responseObject);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            hud.labelText = @"短信发送成功";
            [hud hide:YES afterDelay:0.7];
            weakSelf.yzm = responseObject[@"object"];
            weakSelf.button.userInteractionEnabled = YES;
            weakSelf.button.alpha = 1;
        }
        if (codeStr == 500) {
            hud.labelText = @"异常操作";
            [hud hide:YES afterDelay:0.7];
        }
        if (codeStr == 1305) {
            hud.labelText = @"短信发送失败";
            [hud hide:YES afterDelay:0.7];
        }
        if (codeStr == 1306) {
            hud.labelText = @"手机号不合法";
            [hud hide:YES afterDelay:0.7];
        }
        if (codeStr == 1324) {
            hud.labelText = @"手机号已绑定";
            [hud hide:YES afterDelay:0.7];
        }
        [hud hide:YES afterDelay:0.8];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
