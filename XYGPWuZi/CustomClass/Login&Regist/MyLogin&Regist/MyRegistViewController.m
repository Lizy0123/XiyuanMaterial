//
//  MyRegistViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/22.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRegistViewController.h"
#import "LQXSwitch.h"
#import "MyLoginViewController.h"

#import "Api_SendSMSCode.h"
#import "Api_login.h"
#import "Api_loginByMobile.h"
#import "Api_findBackPsd.h"
#import "Api_regist.h"
#import "ClickTextView.h"
#import "RxWebViewController.h"


@interface MyRegistViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property(strong, nonatomic)UIScrollView *myScrollView;/*主View 存放mainView*/
@property(assign, nonatomic)float contentSizeHeight;/*scrollView的高度*/
@property(strong, nonatomic)UITextField *accountField;/*账号*/
@property(strong, nonatomic)UITextField *passwordField;/*密码*/
@property(strong, nonatomic)UITextField *thirdField;/*验证码*/
@property(strong, nonatomic)UITextField *nameField;/*联系人*/
@property(strong, nonatomic)UITextField *mobileField;/*手机号*/
@property(strong, nonatomic)UITextField *companyField;/*公司名*/
@property(strong, nonatomic)UIButton *typeBtn;/*忘记密码按钮*/
@property(strong, nonatomic)UILabel *typeLabel;/*显示已经选择的类型*/
@property(strong, nonatomic)UIButton *mobileCodeBtn;/*发送验证码按钮*/
@property(strong, nonatomic)LQXSwitch *showPassBtn;/*显示密码按钮*/
@property(strong, nonatomic)UIView *mainView;/*存放各个部件的View*/
@property(strong, nonatomic)UIButton *bottomBtn;/*底部的主操作按钮*/
@property(strong, nonatomic)UIButton *acceptBtn;/*注册协议按钮*/


@end

@implementation MyRegistViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO];
}

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
            view.frame = (CGRect){{0,70}, {kScreen_Width, 470}};
            view.backgroundColor = [UIColor clearColor];
            
            /*
             -- 高：20+30+50+30+20
             */
            //登录按钮
            [view addSubview:self.bottomBtn];
            [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo((CGSize){kScreen_Width - 80, 50});
                make.centerX.equalTo(view);
                make.bottom.mas_equalTo(view).offset(0);
            }];
            view;
        });
        //账号
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
        
        //密码
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
        
        //联系人
        [_mainView addSubview:self.nameField];
        [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(102);
        }];
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){CGRectGetMinX(self.nameField.frame), CGRectGetMaxY(self.nameField.frame), CGRectGetWidth(self.nameField.frame),1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [_mainView addSubview:lineView];
        }
        //联系人
        [_mainView addSubview:self.mobileField];
        [self.mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(153);
        }];
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){CGRectGetMinX(self.mobileField.frame), CGRectGetMaxY(self.mobileField.frame), CGRectGetWidth(self.mobileField.frame),1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [_mainView addSubview:lineView];
        }
        
        //验证码
        [_mainView addSubview:self.thirdField];
        [self.thirdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(204);
        }];
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){CGRectGetMinX(self.thirdField.frame), CGRectGetMaxY(self.thirdField.frame), CGRectGetWidth(self.thirdField.frame),1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [_mainView addSubview:lineView];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.text = @"用户类型";
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = UIColor.grayColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = UIColor.clearColor;
        [_mainView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(255);
        }];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label1.text = @"企业用户 ❯ ";
        label1.font = [UIFont systemFontOfSize:17];
        label1.textColor = UIColor.grayColor;
        label1.textAlignment = NSTextAlignmentRight;
        label1.backgroundColor = UIColor.clearColor;
        [_mainView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(255);
        }];
        self.typeLabel = label1;
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){0, 49, kScreen_Width - 60,1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [label1 addSubview:lineView];
        }
        [_mainView addSubview:self.typeBtn];
        [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(255);
        }];
        //验证码
        [_mainView addSubview:self.companyField];
        [self.companyField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){kScreen_Width - 60,50});
            make.centerX.equalTo(_mainView);
            make.top.equalTo(_mainView).offset(306);
        }];
        {
            UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){0, 49, kScreen_Width - 60,1}];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self.companyField addSubview:lineView];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 22, 20)];
        [btn setBackgroundImage:[UIImage imageNamed:@"对号灰色"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"对号"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(actionXieyi:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){22,20});
            make.left.equalTo(_mainView).offset(50);
            make.top.equalTo(_mainView).offset(376);
        }];
        btn.selected = YES;
        self.acceptBtn = btn;
        //各种声明及条款textView
        ClickTextView *clickTextView = [[ClickTextView alloc] initWithFrame:CGRectMake(50, 0, 200, 30)];
        [_mainView addSubview:clickTextView];
        [clickTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){200,30});
            make.left.mas_equalTo(btn.mas_right).offset(5);
            make.centerY.equalTo(btn);
        }];
        
        //clickTextView.backgroundColor = [UIColor redColor];
        
        //clickTextView.userInteractionEnabled = NO;
        clickTextView.editable = NO;
        clickTextView.delegate = self;
        
        
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
            self.navigationController.navigationBar.tintColor = kColorNav;
            self.navigationController.navigationBarHidden = NO;
            [self.navigationController pushViewController:webViewController animated:YES];
        }];
    }return _mainView;
}
-(void)actionXieyi:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.acceptBtn.selected) {
        self.bottomBtn.userInteractionEnabled = YES;
        self.bottomBtn.alpha = 1;
    }else{
        self.bottomBtn.userInteractionEnabled = NO;
        self.bottomBtn.alpha = 0.5;
    }
}
-(UITextField *)accountField{
    if (!_accountField) {
        _accountField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, kScreen_Width - 60, 50)];
            
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入登录账号" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"登录账号"];
            [textField.leftView addSubview:imgUser];
            
            textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 80, 50)];
            textField.rightViewMode = UITextFieldViewModeAlways;
            [textField.rightView addSubview:self.showPassBtn];
            
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16.0f];
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeDefault;
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
            
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请设置6-20位登录密码" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"登录密码"];
            [textField.leftView addSubview:imgUser];
            
            textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 80, 50)];
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
    }return _passwordField;
}
-(UITextField *)nameField{
    if (!_nameField) {
        _nameField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 102, kScreen_Width - 60, 50)];
            
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请填写联系人" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"联系人"];
            [textField.leftView addSubview:imgUser];

            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16.0f];
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeDefault;
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
    }return _nameField;
}
-(UITextField *)mobileField{
    if (!_mobileField) {
        _mobileField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 153, kScreen_Width - 60, 50)];
            
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请填写手机号" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"手机号"];
            [textField.leftView addSubview:imgUser];
            
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
    }return _mobileField;
}
-(UITextField *)thirdField{
    if (!_thirdField) {
        _thirdField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 204, kScreen_Width - 60, 50)];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"短信验证码" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"验证码"];
            [textField.leftView addSubview:imgUser];
            
            textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 80, 50)];
            textField.rightViewMode = UITextFieldViewModeAlways;
            [textField.rightView addSubview:self.mobileCodeBtn];

            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16.0f];
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.secureTextEntry = NO;
            
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
-(UITextField *)companyField{
    if (!_companyField) {
        _companyField = ({
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 306, kScreen_Width - 60, 50)];
            
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请填写公司名称" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
            textField.leftViewMode = UITextFieldViewModeAlways;
            UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            imgUser.image = [UIImage imageNamed:@"公司名称"];
            [textField.leftView addSubview:imgUser];
            
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16.0f];
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeDefault;
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
    }return _companyField;
}
-(UIButton *)typeBtn{
    if (!_typeBtn) {
        _typeBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setSize:(CGSize){kScreen_Width - 60,50}];
            [btn addTarget:self action:@selector(actionType) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }return _typeBtn;
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
    label.text = @"欢迎加入工平闲置物资";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:30];
    [self.myScrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.myScrollView);
        make.top.mas_equalTo(self.myScrollView.mas_top).offset(kSafeAreaTopHeight);
        make.size.mas_equalTo((CGSize){kScreen_Width,70});
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
    self.myScrollView.contentSize = (CGSize){kScreen_Width,700};
}
-(void)configMainView{
    [self.myScrollView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myScrollView);
        make.top.mas_equalTo(self.myScrollView).offset(70+70);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(470);
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
        self.passwordField.secureTextEntry = NO;
    }else{
        self.passwordField.secureTextEntry = YES;
    }
}
-(void)actionSendMobileCode:(UIButton *)sender{
    if (![NSObject isMobileNum:self.mobileField.text]) {
        [NSObject ToastShowStr:@"请输入正确的手机号"];
        return;
    }
    Api_SendSMSCode *api = [[Api_SendSMSCode alloc] initWithMobile:self.mobileField.text type:@"1"];
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
-(void)actionType{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"企业用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.companyField.hidden = NO;
        self.typeLabel.text = @"企业用户 ❯ ";
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"个人用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.companyField.hidden = YES;
        self.typeLabel.text = @"个人用户 ❯ ";

    }];
//    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"集团用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.companyField.hidden = NO;
//        self.typeLabel.text = @"集团用户 ❯  ";
//    }];

    [alert addAction:action1];
    [alert addAction:action2];
//    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)actionBottomBtn{
    if (![NSObject isString:self.passwordField.text]) {
        [NSObject ToastShowStr:@"请输入验证码"];
        return;
    }
    [self actionRegist];
    
//    Api_findBackPsd *api = [[Api_findBackPsd alloc] initWithMobile:self.accountField.text password:self.thirdField.text code:self.passwordField.text];
//    api.animatingText = @"正在请求数据...";
//    api.animatingView = self.view;
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"success");
//        NSLog(@"requestArgument:%@",request.requestArgument);
//        NSLog(@"response:%@",request.response);
//        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
//            //1.创建UUseModel
//            UserModel *userModel = [[UserModel alloc] initWithDictionary:request.responseJSONObject[@"object"] error:nil];
//            if (!userModel) {
//                return ;
//            }
//            //2.存储UserInfo（userModel）
//            userModel.codeId = request.responseJSONObject[@"codeId"];
//            userModel.token = request.responseJSONObject[@"token"];
//            userModel.facId = request.responseJSONObject[@"facId"];
//            userModel.status = request.responseJSONObject[@"status"];
//            [UserManager saveUserInfo:userModel];
//            //3.token存储到useDefault中
//            if (((NSString *)request.responseJSONObject[@"token"]).length>0) {
//                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//                [userDefault setValue:request.responseJSONObject[@"token"] forKey:kToken];
//                [userDefault synchronize];
//            }else{
//                [UserManager clearUserInfo];
//            }
//            //登录成功后跳转
//            [self.navigationController popViewControllerAnimated:YES];
//            [NSObject ToastShowStr:@"更改密码成功"];
//        }else{
//            if ([request.responseJSONObject[@"code"] integerValue] == 1310) {
//                [NSObject ToastShowStr:@"登录信息不合法"];
//            }
//            if ([request.responseJSONObject[@"code"] integerValue] == 1311) {
//                [NSObject ToastShowStr:@"账号或密码不正确"];
//
//            }  if ([request.responseJSONObject[@"code"] integerValue] == 1312) {
//                [NSObject ToastShowStr:@"缓存数据异常"];
//            }
//        }
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"failed");
//        NSLog(@"requestArgument:%@",request.requestArgument);
//        NSLog(@"response:%@",request.response);
//        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//        [NSObject ToastShowStr:@"登录失败"];
//    }];
}

-(void)actionRegist{
    
    if ([self.typeLabel.text isEqualToString:@"企业用户 ❯ "]) {
        if (![NSObject isString:self.companyField.text]) {
            [NSObject ToastShowStr:@"请填写公司名"];
            return;
        }else if ([self.typeLabel.text isEqualToString:@"个人用户 ❯ "]){
            
        }
    }
    if (!self.acceptBtn.selected) {
        [NSObject ToastShowStr:@"请同意协议！"];
        return;
    }
        
    
    
    Model_regist *registM = [Model_regist new];
    registM.account = self.accountField.text;
    registM.password = self.passwordField.text;
    registM.name = self.nameField.text;
    registM.mobile = self.mobileField.text;
    registM.code = self.thirdField.text;
    if ([self.typeLabel.text isEqualToString:@"企业用户 ❯ "]) {
        registM.type = @"0";
    }else if ([self.typeLabel.text isEqualToString:@"个人用户 ❯ "]){
            registM.type = @"1";
    }
    registM.companyName = self.companyField.text;
    
    
    Api_regist *api = [[Api_regist alloc] initWithRegistM:registM];
    api.animatingText = @"上传数据...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"success");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
            //1.创建UUseModel
//            UserModel *userModel = [[UserModel alloc] initWithDictionary:request.responseJSONObject[@"object"] error:nil];
//            if (!userModel) {
//                return ;
//            }
//            //2.存储UserInfo（userModel）
//            userModel.codeId = request.responseJSONObject[@"codeId"];
//            userModel.token = request.responseJSONObject[@"token"];
//            userModel.facId = request.responseJSONObject[@"facId"];
//            userModel.status = request.responseJSONObject[@"status"];
//            [UserManager saveUserInfo:userModel];
//            //3.token存储到useDefault中
//            if (((NSString *)request.responseJSONObject[@"token"]).length>0) {
//                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//                [userDefault setValue:request.responseJSONObject[@"token"] forKey:kToken];
//                [userDefault synchronize];
//            }else{
//                [UserManager clearUserInfo];
//            }
            //登录成功后跳转
            [self.navigationController popViewControllerAnimated:YES];
            [NSObject ToastShowStr:@"注册成功"];
        }else{
            if ([request.responseJSONObject[@"code"] integerValue] == 400) {
                [NSObject ToastShowStr:@"非法操作"];
            }
            if ([request.responseJSONObject[@"code"] integerValue] == 500) {
                [NSObject ToastShowStr:@"注册请求异常"];
                
            }
            if ([request.responseJSONObject[@"code"] integerValue] == 1301) {
                [NSObject ToastShowStr:@"改手机号已注册！"];
            }
            if ([request.responseJSONObject[@"code"] integerValue] == 1302) {
                [NSObject ToastShowStr:@"验证码输入错误！"];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        [NSObject ToastShowStr:@"注册失败！"];

    }];
}
-(void)judgeBottomBtnStatus{
    //判断底部按钮状态
    if (self.accountField.text.length>=3 && self.passwordField.text.length >= 5 && self.thirdField.text.length>=3 && self.acceptBtn.selected) {
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
    if ([textField isEqual:self.mobileField]) {
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
