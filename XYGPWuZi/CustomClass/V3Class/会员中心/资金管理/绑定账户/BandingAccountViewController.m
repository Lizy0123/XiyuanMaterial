//
//  BandingAccountViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/11.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BandingAccountViewController.h"
#import "TitleTextFieldTView.h"
#import "BRPickerView.h"
#import "Api_bindBank.h"

@interface BandingAccountViewController ()<UITextFieldDelegate>
@property(strong, nonatomic)UIScrollView *myScrollView;

@property(strong, nonatomic)UITextField *accountBankCode;
@property(strong, nonatomic)UITextField *accountName;
@property(strong, nonatomic)UITextField *accountBankName;
@property(strong, nonatomic)UITextField *accountBankCardCode;

@property(strong, nonatomic)TitleTextFieldTView *view_i_0;

@property(strong, nonatomic)UIButton *bottomBtn;
@property(assign, nonatomic)NSInteger contentViewHeight;
@property(strong, nonatomic)Model_BindBank *bindBankM;
@end

@implementation BandingAccountViewController
-(Model_BindBank *)bindBankM{
    if (!_bindBankM) {
        _bindBankM = [Model_BindBank new];
        _bindBankM.fbaBankBs = @"0";

    }return _bindBankM;
}
-(UIScrollView *)myScrollView{
    if (!_myScrollView) {
        //ScrollView
        _myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _myScrollView.userInteractionEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator = _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.bounces = YES;
        _myScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }return _myScrollView;
}
-(UITextField *)accountBankCode{
    if (!_accountBankCode) {
        _accountBankCode = [[UITextField alloc] init];
        _accountBankCode.placeholder = @"出金银行帐号";
        _accountBankCode.borderStyle = UITextBorderStyleNone;
        _accountBankCode.delegate = self;
        _accountBankCode.layer.cornerRadius = 5;
        _accountBankCode.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountBankCode.keyboardType = UIKeyboardTypeNumberPad;
        _accountBankCode.font = [UIFont systemFontOfSize:15];
        _accountBankCode.textAlignment = NSTextAlignmentLeft;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
        label.text = @"出金银行帐号：";
        label.font = [UIFont systemFontOfSize:15];
        _accountBankCode.leftView = label;
        _accountBankCode.leftViewMode = UITextFieldViewModeAlways;
    }return _accountBankCode;
}
-(UITextField *)accountName{
    if (!_accountName) {
        _accountName = [[UITextField alloc] init];
        _accountName.placeholder = @"出金账户名称";
        _accountName.borderStyle = UITextBorderStyleNone;
        _accountName.delegate = self;
        _accountName.layer.cornerRadius = 5;
        _accountName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountName.keyboardType = UIKeyboardTypeDefault;
        _accountName.font = [UIFont systemFontOfSize:15];
        _accountName.textAlignment = NSTextAlignmentLeft;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
        label.text = @"出金账户名称：";
        label.font = [UIFont systemFontOfSize:15];
        _accountName.leftView = label;
        _accountName.leftViewMode = UITextFieldViewModeAlways;
    }return _accountName;
}
-(UITextField *)accountBankName{
    if (!_accountBankName) {
        _accountBankName = [[UITextField alloc] init];
        _accountBankName.placeholder = @"出金账户银行行名";
        _accountBankName.borderStyle = UITextBorderStyleNone;
        _accountBankName.delegate = self;
        _accountBankName.layer.cornerRadius = 5;
        _accountBankName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountBankName.keyboardType = UIKeyboardTypeDefault;
        _accountBankName.font = [UIFont systemFontOfSize:15];
        _accountBankName.textAlignment = NSTextAlignmentLeft;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
        label.text = @"出金账户银行行名：";
        label.font = [UIFont systemFontOfSize:15];
        _accountBankName.leftView = label;
        _accountBankName.leftViewMode = UITextFieldViewModeAlways;
    }return _accountBankName;
}
-(UITextField *)accountBankCardCode{
    if (!_accountBankCardCode) {
        _accountBankCardCode = [[UITextField alloc] init];
        _accountBankCardCode.placeholder = @"出金账户银行行号";
        _accountBankCardCode.borderStyle = UITextBorderStyleNone;
        _accountBankCardCode.delegate = self;
        _accountBankCardCode.layer.cornerRadius = 5;
        _accountBankCardCode.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountBankCardCode.keyboardType = UIKeyboardTypeNumberPad;
        _accountBankCardCode.font = [UIFont systemFontOfSize:15];
        _accountBankCardCode.textAlignment = NSTextAlignmentLeft;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
        label.text = @"出金账户银行行号：";
        label.font = [UIFont systemFontOfSize:15];
        _accountBankCardCode.leftView = label;
        _accountBankCardCode.leftViewMode = UITextFieldViewModeAlways;
    }return _accountBankCardCode;
}




-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        CGFloat btnHeight = 44;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setSize:CGSizeMake(btnWidth, btnHeight)];
        [_bottomBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_bottomBtn setCornerRadius:btnHeight/2];
        [_bottomBtn setBackgroundColor:kColorNav];
        [_bottomBtn addTarget:self action:@selector(actionBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    }return _bottomBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"绑定出金账户"];
    [self.view addSubview:self.myScrollView];
    
    [self.myScrollView addSubview:self.accountBankCode];
    self.accountBankCode.frame = CGRectMake(16, self.contentViewHeight, kScreen_Width - kMyPadding*2, 50);
    self.contentViewHeight +=50;
    [self.myScrollView addSubview:[NSObject lineViewWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, 1) color:nil]];
    
    [self.myScrollView addSubview:self.accountName];
    self.accountName.frame = CGRectMake(16, self.contentViewHeight, kScreen_Width - kMyPadding*2, 50);
    self.contentViewHeight +=50;
    [self.myScrollView addSubview:[NSObject lineViewWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, 1) color:nil]];
    
    [self.myScrollView addSubview:self.accountBankName];
    self.accountBankName.frame = CGRectMake(16, self.contentViewHeight, kScreen_Width - kMyPadding*2, 50);
    self.contentViewHeight +=50;
    [self.myScrollView addSubview:[NSObject lineViewWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, 1) color:nil]];
    

    [self.myScrollView addSubview:self.accountBankCardCode];
    self.accountBankCardCode.frame = CGRectMake(16, self.contentViewHeight, kScreen_Width - kMyPadding*2, 50);
    self.contentViewHeight +=50;
    [self.myScrollView addSubview:[NSObject lineViewWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, 1) color:nil]];
    
    
    __weak typeof(self) weakSelf = self;

    if (!self.view_i_0) {
        TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
        self.contentViewHeight += [TitleTextFieldTView cellHeight];
        [cell addSubview:[NSObject lineViewWithFrame:CGRectMake(0, CGRectGetHeight(cell.frame) - 1, kScreen_Width, 1) color:nil]];

        [self.myScrollView addSubview:cell];
        self.view_i_0 = cell;
    }
    [self.view_i_0 setTitleStr:@"银行归属标识" valueStr:@"" placeHolder:@"平安银行"];
    self.view_i_0.tapAcitonBlock = ^{
        NSArray *dataSources = @[@"平安银行", @"他行"];
        [BRStringPickerView showStringPickerWithTitle:@"银行归属标识" dataSource:dataSources defaultSelValue:@"平安银行" isAutoSelect:YES resultBlock:^(id selectValue) {
            [weakSelf.view_i_0 setTitleStr:@"银行归属标识" valueStr:selectValue placeHolder:@"平安银行"];
            if ([selectValue isEqualToString:@"平安银行"]) {
                weakSelf.bindBankM.fbaBankBs = @"0";
            }else{
                weakSelf.bindBankM.fbaBankBs = @"1";
            }
        }];
    };
    
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - kMyPadding *2, 50));
        make.bottom.equalTo(self.view).offset(-kSafeBottomOffset);
        make.left.equalTo(self.view).offset(kMyPadding);
    }];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, 50)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kScreen_Width - 32, 50)];
    label.text = @"若对出金账户银行行号内容存在疑问，可前往工平闲置物资网站利用行号查询小工具进行查询";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = kColorNav;
    [view addSubview:label];
    [self.myScrollView addSubview:view];
    self.myScrollView.contentSize = CGSizeMake(kScreen_Width, self.contentViewHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionBottomBtn{
    if (!((self.accountBankCode.text.length)>0)) {
        [NSObject ToastShowStr:@"请填写出金银行帐号"];
        return;
    }
    self.bindBankM.fbaBankHh = self.accountBankCardCode.text;
    self.bindBankM.fbaBankName = self.accountName.text;
    self.bindBankM.fbaBankHm = self.accountBankName.text;
    self.bindBankM.fbaBankNo = self.accountBankCode.text;
    self.bindBankM.fbaId = self.fbaId;
    
    Api_bindBank *api = [[Api_bindBank alloc] initWithModelBindBank:self.bindBankM];
    api.animatingText = @"正在上传数据...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject[@"success"] integerValue] == 1) {
            [NSObject ToastShowStr:@"绑定成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [NSObject ToastShowStr:request.responseJSONObject[@"message"]];
        }
        NSLog(@"succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [NSObject ToastShowStr:@"绑定失败!"];

        NSLog(@"failer");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    }];
}

@end
