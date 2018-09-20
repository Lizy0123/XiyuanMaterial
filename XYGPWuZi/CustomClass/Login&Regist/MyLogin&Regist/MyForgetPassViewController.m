//
//  MyForgetPassViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/22.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyForgetPassViewController.h"
#import "LQXSwitch.h"
#import "MyLoginViewController.h"

#import "Api_SendSMSCode.h"
#import "Api_login.h"
#import "Api_loginByMobile.h"
#import "Api_findBackPsd.h"

@interface MyForgetPassViewController ()<UITextFieldDelegate>
@property(strong, nonatomic)UIScrollView *myScrollView;/*主View 存放mainView*/
@property(assign, nonatomic)float contentSizeHeight;/*scrollView的高度*/
@property(strong, nonatomic)UITextField *accountField;/*账号*/
@property(strong, nonatomic)UITextField *passwordField;/*密码*/
@property(strong, nonatomic)UITextField *thirdField;/*验证码*/

@property(strong, nonatomic)UIButton *mobileCodeBtn;/*发送验证码按钮*/
@property(strong, nonatomic)LQXSwitch *showPassBtn;/*显示密码按钮*/
@property(strong, nonatomic)UIView *mainView;/*存放各个部件的View*/
@property(strong, nonatomic)UIButton *bottomBtn;/*底部的主操作按钮*/

@end

@implementation MyForgetPassViewController
-(UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = ({
            UIScrollView *scrollView = [UIScrollView new];
            scrollView.userInteractionEnabled = YES;
            scrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
            scrollView.bounces = YES;
            scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
            scrollView;
        });
    }return _myScrollView;
}
-(UIView *)mainView{
    if (!_mainView) {
        _mainView = ({
            UIView *view = [UIView new];
            view.frame = (CGRect){{0,0}, {kScreen_Width, 320}};
            view.backgroundColor = [UIColor clearColor];
            
            /*
             -- 高：20+30+50+30+20
             */
            //登录按钮
            [view addSubview:self.bottomBtn];
            [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo((CGSize){kScreen_Width - 80, 50});
                make.centerX.equalTo(view);
                make.bottom.mas_equalTo(view).offset(-30);
            }];
            view;
        });
        //账号或手机号
        [_mainView addSubview:self.accountField];
        [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView);
        }];
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){CGRectGetMinX(self.accountField.frame), CGRectGetMaxY(self.accountField.frame), CGRectGetWidth(self.accountField.frame),1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [_mainView addSubview:lineView];
        }
        
        //密码或验证码
        [_mainView addSubview:self.passwordField];
        [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(51);
        }];
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){CGRectGetMinX(self.passwordField.frame), CGRectGetMaxY(self.passwordField.frame), CGRectGetWidth(self.passwordField.frame),1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [_mainView addSubview:lineView];
        }
        
        //确认密码
        [_mainView addSubview:self.thirdField];
        [self.thirdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(102);
        }];
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){CGRectGetMinX(self.thirdField.frame), CGRectGetMaxY(self.thirdField.frame), CGRectGetWidth(self.thirdField.frame),1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [_mainView addSubview:lineView];
        }
    }return _mainView;
}
-(UITextField *)accountField{
    if (!_accountField) {
        _accountField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, kScreen_Width - 60, 50)];

            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号码" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"手机号"];
            [textField.leftView addSubview:imgUser];
            
            textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 80, 50)];
            textField.rightViewMode = UITextFieldViewModeAlways;
            [textField.rightView addSubview:self.showPassBtn];
            
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16.0f];
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            //        textField.borderStyle = UITextBorderStyleNone;
            textField.borderStyle = UITextBorderStyleNone;
            textField.delegate = self;
            textField.layer.cornerRadius = 5;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.translatesAutoresizingMaskIntoConstraints = NO;
            
            textField.layer.borderColor = [[UIColor whiteColor] CGColor];
            textField.layer.borderWidth = 0.5;
            textField.layer.masksToBounds = YES;
            textField.cornerRadius = 5;
            textField;
        });
    }return _accountField;
}
-(UITextField *)passwordField{
    if (!_passwordField) {
        _passwordField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 51, kScreen_Width - 60, 50)];

            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"短信验证码" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"验证码"];
            [textField.leftView addSubview:imgUser];
            
            textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 80, 50)];
            textField.rightViewMode = UITextFieldViewModeAlways;
            [textField.rightView addSubview:self.mobileCodeBtn];
            
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16.0f];
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.secureTextEntry = YES;
            
            //        textField.borderStyle = UITextBorderStyleNone;
            textField.borderStyle = UITextBorderStyleNone;
            textField.delegate = self;
            textField.layer.cornerRadius = 5;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.translatesAutoresizingMaskIntoConstraints = NO;
            
            textField.layer.borderColor = [[UIColor whiteColor] CGColor];
            textField.layer.borderWidth = 0.5;
            textField.layer.masksToBounds = YES;
            textField.cornerRadius = 5;
            textField;
        });
    }return _passwordField;
}
-(UITextField *)thirdField{
    if (!_thirdField) {
        _thirdField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 101, kScreen_Width - 60, 50)];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"新的登录密码" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"登录密码"];
            [textField.leftView addSubview:imgUser];
            
            textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 80, 50)];
            textField.rightViewMode = UITextFieldViewModeAlways;
            [textField.rightView addSubview:self.showPassBtn];
            
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16.0f];
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.secureTextEntry = YES;
            
            //        textField.borderStyle = UITextBorderStyleNone;
            textField.borderStyle = UITextBorderStyleNone;
            textField.delegate = self;
            textField.layer.cornerRadius = 5;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.translatesAutoresizingMaskIntoConstraints = NO;
            
            textField.layer.borderColor = [[UIColor whiteColor] CGColor];
            textField.layer.borderWidth = 0.5;
            textField.layer.masksToBounds = YES;
            textField.cornerRadius = 5;
            textField;
        });
    }return _thirdField;
}
-(LQXSwitch *)showPassBtn{//密码可见按钮
    if (!_showPassBtn) {
        _showPassBtn = ({
            LQXSwitch *btn = [[LQXSwitch alloc] initWithFrame:CGRectMake(60, 150, 80, 40) onColor:kColorNav offColor:UIColor.lightGrayColor font:[UIFont systemFontOfSize:15] ballSize:30];
            [btn setFrame:(CGRect){0,10,80,30}];
            [btn setBackgroundColor:UIColor.clearColor];
            [btn setOnText:@"123"];
            [btn setOffText:@"***"];
            
            [btn addTarget:self action:@selector(actionShowPassBtn:) forControlEvents:UIControlEventValueChanged];
            btn;
        });
    }return _showPassBtn;
}

-(UIButton *)mobileCodeBtn{
    if (!_mobileCodeBtn) {
        _mobileCodeBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:(CGRect){0,10,80,30}];
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [btn setTitleColor:kColorNav forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(actionSendMobileCode:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius = 15;
            btn.backgroundColor = UIColor.whiteColor;
            btn.userInteractionEnabled = NO;
            btn.alpha = 0.5;
            btn;
        });
    }return _mobileCodeBtn;
}

-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        CGFloat btnHeight = 50;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - 15*2;
        _bottomBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setSize:(CGSize){btnWidth,btnHeight}];
            [btn setTitle:@"确认" forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:kColorNav];
            
            [btn addTarget:self action:@selector(actionBottomBtn) forControlEvents:UIControlEventTouchUpInside];
            [btn setCornerRadius:btnHeight/2];
            [btn setUserInteractionEnabled:NO];
            [btn setAlpha:0.5];
            btn;
        });
    }return _bottomBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    //myScrollView
    [self.view addSubview:self.myScrollView];
    [self.myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UILabel *label = [UILabel new];
    label.text = @"找回密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:30];
    [self.myScrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(kSafeAreaTopHeight);
        make.size.mas_equalTo((CGSize){150,70});
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"❮" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [btn setTitleColor:kColorNav forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionPop) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo((CGSize){50,50});
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    [self configMainView];
}
-(void)configMainView{
    [self.myScrollView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.myScrollView);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(320);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)actionClose{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)actionPop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)actionShowPassBtn:(LQXSwitch *)sender{
    if (sender.on) {
        self.thirdField.secureTextEntry = NO;
    }else{
        self.thirdField.secureTextEntry = YES;
    }
}
-(void)actionSendMobileCode:(UIButton *)sender{
    if (![NSObject isMobileNum:self.accountField.text]) {
        [NSObject ToastShowStr:@"请输入正确的手机号"];
        return;
    }
    Api_SendSMSCode *api = [[Api_SendSMSCode alloc] initWithMobile:self.accountField.text type:@"1"];
    api.animatingText = @"正在发送验证码...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
            [NSObject ToastShowStr:@"验证码发送成功"];
            __block NSInteger time = 59; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(time <= 0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置按钮的样式
                        [self.mobileCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        [self.mobileCodeBtn setTitleColor:kColorNav forState:UIControlStateNormal];
                        self.mobileCodeBtn.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = time % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置按钮显示读秒效果
                        [self.mobileCodeBtn setTitle:[NSString stringWithFormat:@"(%.2ds)", seconds] forState:UIControlStateNormal];
                        [self.mobileCodeBtn setTitleColor:kColorNav forState:UIControlStateNormal];
                        self.mobileCodeBtn.userInteractionEnabled = NO;
                        self.mobileCodeBtn.alpha = 0.5;
                        
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
        }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
            NSString *str = request.responseJSONObject[@"msg"];
            [NSObject ToastShowStr:str];
        }
        NSLog(@"succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"failed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        [NSObject ToastShowStr:@"验证码发送失败"];
    }];
}
-(void)actionForgetPass{
    MyForgetPassViewController *vc = [MyForgetPassViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)actionBottomBtn{
    if (![NSObject isString:self.passwordField.text]) {
        [NSObject ToastShowStr:@"请输入验证码"];
        return;
    }
        Api_findBackPsd *api = [[Api_findBackPsd alloc] initWithMobile:self.accountField.text password:self.thirdField.text code:self.passwordField.text];
        api.animatingText = @"正在请求数据...";
        api.animatingView = self.view;
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"success");
            NSLog(@"requestArgument:%@",request.requestArgument);
            NSLog(@"response:%@",request.response);
            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"code"] integerValue] == 200) {
                //1.创建UUseModel
                UserModel *userModel = [[UserModel alloc] initWithDictionary:request.responseJSONObject[@"object"] error:nil];
                if (!userModel) {
                    return ;
                }
                //2.存储UserInfo（userModel）
                userModel.codeId = request.responseJSONObject[@"codeId"];
                userModel.token = request.responseJSONObject[@"token"];
                userModel.facId = request.responseJSONObject[@"facId"];
                userModel.status = request.responseJSONObject[@"status"];
                [UserManager saveUserInfo:userModel];
                //3.token存储到useDefault中
                if (((NSString *)request.responseJSONObject[@"token"]).length>0) {
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setValue:request.responseJSONObject[@"token"] forKey:kToken];
                    [userDefault synchronize];
                }else{
                    [UserManager clearUserInfo];
                }
                //登录成功后跳转
                [self.navigationController popViewControllerAnimated:YES];
                    [NSObject ToastShowStr:@"更改密码成功"];
            }else{
                if ([request.responseJSONObject[@"code"] integerValue] == 1310) {
                    [NSObject ToastShowStr:@"登录信息不合法"];
                }
                if ([request.responseJSONObject[@"code"] integerValue] == 1311) {
                    [NSObject ToastShowStr:@"账号或密码不正确"];
                    
                }  if ([request.responseJSONObject[@"code"] integerValue] == 1312) {
                    [NSObject ToastShowStr:@"缓存数据异常"];
                }
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"failed");
            NSLog(@"requestArgument:%@",request.requestArgument);
            NSLog(@"response:%@",request.response);
            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
            [NSObject ToastShowStr:@"登录失败"];
            
        }];

}

-(void)actionRegist{

}
-(void)judgeBottomBtnStatus{
    //判断底部按钮状态
    if (self.accountField.text.length>=3 && self.thirdField.text.length >= 5 && self.passwordField.text.length>=3) {
        self.bottomBtn.userInteractionEnabled = YES;
        self.bottomBtn.alpha = 1;
    }else{
        self.bottomBtn.userInteractionEnabled = NO;
        self.bottomBtn.alpha = 0.5;
    }
}
#pragma maark - Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //判断底部按钮状态
    [self judgeBottomBtnStatus];

        //验证码登录
        if ([textField isEqual:self.accountField]) {
            NSLog(@"账号输入");
            if (resultString.length >=10) {
                self.mobileCodeBtn.userInteractionEnabled = YES;
                self.mobileCodeBtn.alpha = 1;
            }else{
                self.mobileCodeBtn.userInteractionEnabled = NO;
                self.mobileCodeBtn.alpha = 0.5;
            }
        }else{
            NSLog(@"密码输入");
        }
    return YES;
}

@end
