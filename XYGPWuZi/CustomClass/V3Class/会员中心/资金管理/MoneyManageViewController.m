//
//  MoneyManageViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MoneyManageViewController.h"
#import "BandingAccountViewController.h"
#import "MyBottomBoxView.h"
#import "Record_ChujinViewController.h"
#import "Record_JiaoyiLiushuiViewController.h"
#import "PayForBailViewController.h"

#import "ChhuJiaJiLuTCell.h"
#import "ChuJiaJiLuModel.h"

#import "Api_FindUserBankInfo.h"

#import "Model_FacUser.h"
#import "Model_FacInfo.h"
#import "Api_drawMoney.h"
#import "Api_SendSMSCode.h"

#import "OpenAccountViewController.h"

@interface HeadeModel : NSObject
@property(copy, nonatomic)NSString *titleName, *accountNumber, *accountName, *accountTime, *allMoney, *canuseMoney, *frazeMoney;
@end
@implementation HeadeModel

@end

@interface MoneyManageViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)HeadeModel *headM;
@property(strong, nonatomic)UIButton *bottomBtn;
@property(strong, nonatomic)UITextField *moneyNumberField;
@property(strong, nonatomic)UIButton *mobileCodeBtn;
@property(strong, nonatomic)UITextField *mobileCodeField;
@property(strong, nonatomic)UIButton *sendRequestBtn;
@property(assign, nonatomic)BOOL isBanding;

@property(strong, nonatomic)Model_FacUser *facUserM;
@property(strong, nonatomic)MyBottomBoxView *bottomBoxView;
@end

@implementation MoneyManageViewController
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] init];
    }return _dataSourceArray;
}
-(HeadeModel *)headM{
    if (!_headM) {
        _headM = [HeadeModel new];
        _headM.titleName = @"平安银行";
//        _headM.accountNumber = @"1000000000000";
//        _headM.accountName = @"河北修远科技有限公司";
//        _headM.accountTime = @"2018-08-08 10:00:00";
//        _headM.allMoney = @"$888888888.88";
//        _headM.canuseMoney = @"$888888888.88";
//        _headM.frazeMoney = @"0";
    }return _headM;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        _tableView.tableHeaderView = self.tableHeaderView;
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
        _tableView.contentInset = insets;
        _tableView.scrollIndicatorInsets = insets;
        
    }return _tableView;
}
-(UIView *)tableHeaderView{
        /*
          
          */
    CGFloat imageViewWidth = 90;
    CGFloat backColorViewHeight = 180;
    CGFloat headerViewHeight = 180 + 10 + 30+40 +1 +30*2 +10;

    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, headerViewHeight)];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *backColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, backColorViewHeight)];
    backColorView.backgroundColor = [UIColor orangeColor];
    [backView addSubview:backColorView];
    
    
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMyPadding, kMyPadding, 110, 60)];
    imageView.image = [UIImage imageNamed:@"pinganImg"];
    imageView.clipsToBounds = YES;
    imageView.cornerRadius = 10;
    [backColorView addSubview:imageView];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+kMyPadding/2, CGRectGetMidY(imageView.frame)-30, kScreen_Width - CGRectGetMaxX(imageView.frame) - kMyPadding*2, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = self.headM.titleName?self.headM.titleName:@"";
    titleLabel.textColor = [UIColor whiteColor];
    [backColorView addSubview:titleLabel];
    
    UILabel *accountNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+kMyPadding/2, CGRectGetMidY(imageView.frame), kScreen_Width - CGRectGetMaxX(imageView.frame) - kMyPadding*2, 30)];
    accountNumLabel.font = [UIFont boldSystemFontOfSize:15];
    accountNumLabel.textAlignment = NSTextAlignmentLeft;
    accountNumLabel.text = self.headM.accountNumber?self.headM.accountNumber:@"";
    accountNumLabel.textColor = [UIColor whiteColor];

    [backColorView addSubview:accountNumLabel];

    UILabel *accountNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, CGRectGetMaxY(imageView.frame)+kMyPadding, kScreen_Width - kMyPadding*2, 20)];
    accountNameLabel.font = [UIFont boldSystemFontOfSize:15];
    accountNameLabel.textAlignment = NSTextAlignmentLeft;
    accountNameLabel.text = self.headM.accountName?self.headM.accountName:@"";
    accountNameLabel.textColor = [UIColor whiteColor];

    [backColorView addSubview:accountNameLabel];
    
    UILabel *accountTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, CGRectGetMaxY(accountNameLabel.frame)+kMyPadding/2, kScreen_Width - kMyPadding*2, 20)];
    accountTimeLabel.font = [UIFont boldSystemFontOfSize:15];
    accountTimeLabel.textAlignment = NSTextAlignmentLeft;
    accountTimeLabel.text = self.headM.accountTime?self.headM.accountTime:@"";
    accountTimeLabel.textColor = [UIColor whiteColor];

    [backColorView addSubview:accountTimeLabel];
    

    
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backColorView.frame)+5, kScreen_Width, 30)];
    label0.backgroundColor = [UIColor whiteColor];
    label0.font = [UIFont systemFontOfSize:16];
    label0.textColor = kColorNav;
    label0.textAlignment = NSTextAlignmentCenter;
    label0.text = @"账户余额";
    [backView addSubview:label0];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label0.frame), kScreen_Width, 40)];
    label1.backgroundColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:20];
    label1.textColor = kColorNav;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [NSObject moneyStyle:self.headM.allMoney?self.headM.allMoney:@""];
    [backView addSubview:label1];
    

    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame)+1, kScreen_Width/2, 30)];
    label2.backgroundColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:16];
    label2.textColor = [UIColor grayColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"可用余额";
    [backView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame), kScreen_Width/2, 30)];
    label3.backgroundColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:20];
    label3.textColor = kColorNav;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = [NSObject moneyStyle:self.headM.canuseMoney?self.headM.canuseMoney:@""];
    [backView addSubview:label3];
    
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width/2+1, CGRectGetMaxY(label1.frame)+1, kScreen_Width/2-1, 30)];
    label4.backgroundColor = [UIColor whiteColor];
    label4.font = [UIFont systemFontOfSize:16];
    label4.textColor = [UIColor grayColor];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.text = @"冻结余额";
    [backView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width/2+1, CGRectGetMaxY(label4.frame), kScreen_Width/2-1, 30)];
    label5.backgroundColor = [UIColor whiteColor];
    label5.font = [UIFont systemFontOfSize:20];
    label5.textColor = kColorNav;
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = [NSObject moneyStyle:self.headM.frazeMoney?self.headM.frazeMoney:@""];
    [backView addSubview:label5];
    

    return backView;
}
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        CGFloat btnHeight = 44;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setSize:CGSizeMake(btnWidth, btnHeight)];
        [_bottomBtn setTitle:@"出金" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_bottomBtn setCornerRadius:btnHeight/2];
        [_bottomBtn setBackgroundColor:kColorNav];
        [_bottomBtn addTarget:self action:@selector(actionBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    }return _bottomBtn;
}

-(UITextField *)moneyNumberField{
    if (!_moneyNumberField) {
        _moneyNumberField = [[UITextField alloc] initWithFrame:CGRectMake(16, 7, kScreen_Width - 16*2, 30)];
        _moneyNumberField.placeholder = @"出金金额(元)";
        _moneyNumberField.borderStyle = UITextBorderStyleNone;
        _moneyNumberField.delegate = self;
        _moneyNumberField.keyboardType = UIKeyboardTypeNumberPad;
        _moneyNumberField.layer.cornerRadius = 5;
        _moneyNumberField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _moneyNumberField.font = [UIFont systemFontOfSize:15];
        _moneyNumberField.textAlignment = NSTextAlignmentRight;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
        label.text = @"出金金额(元)：";
        label.font = [UIFont systemFontOfSize:15];
        _moneyNumberField.leftView = label;
        _moneyNumberField.leftViewMode = UITextFieldViewModeAlways;
    }return _moneyNumberField;
}
-(UITextField *)mobileCodeField{
    if (!_mobileCodeField) {
        _mobileCodeField = [[UITextField alloc] init];
        _mobileCodeField.placeholder = @"短信验证码";
        _mobileCodeField.borderStyle = UITextBorderStyleNone;
        _mobileCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileCodeField.keyboardType = UIKeyboardTypeNumberPad;
        
        _mobileCodeField.delegate = self;
        _mobileCodeField.layer.cornerRadius = 5;
        _mobileCodeField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _mobileCodeField.rightViewMode = UITextFieldViewModeAlways;
        _mobileCodeField.rightView = self.mobileCodeBtn;
    }return _mobileCodeField;
}
-(UIButton *)mobileCodeBtn{
    if (!_mobileCodeBtn) {
        _mobileCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mobileCodeBtn.size = CGSizeMake(100, 30);
        [_mobileCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _mobileCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _mobileCodeBtn.clipsToBounds = YES;
        _mobileCodeBtn.layer.cornerRadius = 15;
        _mobileCodeBtn.backgroundColor = kColorNav;
        _mobileCodeBtn.userInteractionEnabled = YES;
        _mobileCodeBtn.alpha = 0.5;
        
        [_mobileCodeBtn addTarget:self action:@selector(actionMobileCode) forControlEvents:UIControlEventTouchUpInside];
    }return _mobileCodeBtn;
}
-(UIButton *)sendRequestBtn{
    if (!_sendRequestBtn) {
        CGFloat btnHeight = 44;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        
        _sendRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendRequestBtn setSize:CGSizeMake(btnWidth, btnHeight)];
        [_sendRequestBtn setTitle:@"提交出金申请" forState:UIControlStateNormal];
        [_sendRequestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendRequestBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_sendRequestBtn setCornerRadius:btnHeight/2];
        [_sendRequestBtn setBackgroundColor:kColorNav];
        [_sendRequestBtn addTarget:self action:@selector(actionSendRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    }return _sendRequestBtn;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self serveUserInfo];
    
    [self setTitle:@"资金管理"];
    self.isBanding = NO;
    //添加TableView
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).offset(-kSafeBottomOffset-44);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafeBottomOffset);
        make.left.equalTo(self.view).offset(kMyPadding);
        make.right.equalTo(self.view).offset(-kMyPadding);

    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self serveUserInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configBottomBoxView{
    MyBottomBoxView *boxView = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.6)];
    [self.view.window addSubview:boxView];
    self.bottomBoxView = boxView;
    //账户信息部分
    Model_Account *accountM = self.facUserM.accounts.count>0? [self.facUserM.accounts objectAtIndex:0]:[Model_Account new];
    
    
    // 设置数据
    NSArray *titleArray = [NSArray arrayWithObjects:@"出金付款账户",@"出金付款账户名称",@"出金收款账户银行",@"出金收款账户",@"出金收款账户名称", nil];
    NSArray *detailArray = [NSArray arrayWithObjects:accountM.zizhanghao,accountM.zizhanghmc,accountM.fbaBankHm,accountM.fbaBankNo, accountM.fbaBankName, nil];
    [boxView initWithTitle:@"出金" titleArray:titleArray detailArray:detailArray imageArray:nil];
    [boxView.scrollView addSubview:self.moneyNumberField];
    CGFloat scrollViewContentHeight = 44*5;
    self.moneyNumberField.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 44);
    scrollViewContentHeight +=44;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 30)];
    label1.textColor = kColorNav;
    label1.font = [UIFont systemFontOfSize:13];
    label1.numberOfLines = 0;

    NSMutableString * num = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",self.facUserM.facPayMobil]];
    [num replaceCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
    
    label1.text = [NSString stringWithFormat:@"向安全支付操作手机 %@ 发送支付验证码",num];
    [boxView.scrollView addSubview:label1];
    scrollViewContentHeight +=30;
    
    //验证码
    self.mobileCodeField.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 30, 44);
    [boxView.scrollView addSubview:self.mobileCodeField];
    scrollViewContentHeight +=44;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50)];
    label.textColor = kColorNav;
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.text = @"⚠︎出金申请提交后，货款将第一时间转至您的出入金账户中，请您耐心等待。";
    [boxView.scrollView addSubview:label];
    scrollViewContentHeight +=50;
    
    [boxView.scrollView addSubview:self.sendRequestBtn];
    self.sendRequestBtn.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50);
    scrollViewContentHeight +=50;
    
    
    boxView.scrollView.contentSize = CGSizeMake(kScreen_Width, scrollViewContentHeight+44);
    boxView.scrollView.backgroundColor = [UIColor whiteColor];
    
    __weak MyBottomBoxView *tanKuangView1 = boxView;
    __weak typeof(self) weakSelf = self;
    boxView.clickBlock = ^(UIView *itemView) {
        if (itemView.tag == 100) {// 点击选项一
            NSLog(@"1");
        }
        if (itemView.tag == 101) {// 点击选项二
            NSLog(@"2");
        }
        if (itemView.tag == 102) {// 点击选项三
            
        }
        BoxItemView *itemView1 = (BoxItemView*)itemView;
        //        [tanKuangView1 closeBottomBoxView];
    };
    
    
    // 显示弹框
    [boxView showBottomBoxView];
}


#pragma mark - Action
-(void)actionSendRequestBtn{
    if (![NSObject isString:self.moneyNumberField.text]) {
        [NSObject ToastShowStr:@"请输入出金金额"];
        return;
    }
    if (![NSObject isString:self.mobileCodeField.text]) {
        [NSObject ToastShowStr:@"请输入验证码"];
        return;
    }
//    [self.bottomBoxView closeBottomBoxView];

    Api_drawMoney *api = [[Api_drawMoney alloc] initWithDrawMoney:self.moneyNumberField.text phoneCode:self.mobileCodeField.text];
    api.animatingText = @"正在上传数据";
    api.animatingView = self.bottomBoxView;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject[@"code"] integerValue]==200) {
            [NSObject ToastShowStr:@"提交成功"];
            [self.bottomBoxView closeBottomBoxView];
        }else if ([request.responseJSONObject[@"code"] integerValue]==0){
            if ([NSObject isString:request.responseJSONObject[@"message"]]) {
                [NSObject ToastShowStr:request.responseJSONObject[@"message"]];
            }
            [self.bottomBoxView closeBottomBoxView];
        }
        
        NSLog(@"succeed");
        
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [NSObject ToastShowStr:@"提交失败，请联系管理员"];

        NSLog(@"failed");
        
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    }];
}
-(void)serveUserInfo{
    Api_FindUserBankInfo *api = [[Api_FindUserBankInfo alloc] init];
    api.animatingText = @"正在获取数据...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"getAllCategoryDataApi succeed");
        NSLog(@"getAllCategoryDataApi succeed");
        
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        
        if ([request.responseJSONObject[@"success"] integerValue]== 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你还没有绑定账户" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                OpenAccountViewController *vc = [OpenAccountViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:okAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }else{
            
        }
        
        self.facUserM = [[Model_FacUser alloc] initWithDictionary:request.responseJSONObject[@"object"][@"facUser"] error:nil];
        
        //账户信息部分
        Model_Account *accountM = self.facUserM.accounts.count>0? [self.facUserM.accounts objectAtIndex:0]:[Model_Account new];
        self.headM.titleName = @"平安银行";
        self.headM.accountNumber = accountM.zizhanghao;
        self.headM.accountName = accountM.zhanghumc;
        self.headM.accountTime = accountM.fbaCretime;
        self.headM.allMoney = [NSString stringWithFormat:@"%ld",[accountM.fbaBalance integerValue]+[accountM.fbaBalanceLock integerValue]];
        self.headM.canuseMoney = accountM.fbaBalance;
        self.headM.frazeMoney = accountM.fbaBalanceLock;
        self.tableView.tableHeaderView =  self.tableHeaderView;
        
        //出金账户
        if (!([NSObject isString:accountM.fbaBankName])||!([NSObject isString:accountM.fbaBankNo])) {
            self.isBanding = NO;
        }else{
            self.isBanding = YES;
        }
        
        //出金记录
        self.dataSourceArray = [Model_dm arrayOfModelsFromDictionaries:request.responseJSONObject[@"object"][@"dmList"] error:nil];
        [self.tableView reloadData];

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"getAllCategoryDataApi failed");
        
    }];


    
}
// 开启倒计时效果
-(void)actionMobileCode{
    Api_SendSMSCode *SendUpdateLoginMobileCodeApi = [[Api_SendSMSCode alloc] initWithMobile:self.facUserM.facPayMobil type:@"5"];
    [SendUpdateLoginMobileCodeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
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
                        [self.mobileCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        self.mobileCodeBtn.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = time % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置按钮显示读秒效果
                        [self.mobileCodeBtn setTitle:[NSString stringWithFormat:@"(%.2ds)", seconds] forState:UIControlStateNormal];
                        [self.mobileCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        self.mobileCodeBtn.userInteractionEnabled = NO;
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
        }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
            NSString *str = request.responseJSONObject[@"msg"];
            [NSObject ToastShowStr:str];
        }
        NSLog(@"SendUpdateLoginMobileCodeApi succeed");
        NSLog(@"SendUpdateLoginMobileCodeApi succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"responseHeaders:%@",request.responseHeaders);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseData:%@",request.responseData);
        NSLog(@"responseString:%@",request.responseString);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"SendUpdateLoginMobileCodeApi failed");
        
    }];
//    Api_SendLoginCode *sendCodeApi = [[Api_SendLoginCode alloc] initWithMobile:_mobileField.text];
//    [sendCodeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        NSLog(@"sendCodeApi succeed");
//        NSLog(@"sendCodeApi succeed");
//
//        NSLog(@"requestArgument:%@",request.requestArgument);
//        NSLog(@"responseHeaders:%@",request.responseHeaders);
//        NSLog(@"response:%@",request.response);
//        NSLog(@"responseData:%@",request.responseData);
//        NSLog(@"responseString:%@",request.responseString);
//        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//
//        if ([[request.responseJSONObject[@"code"] stringValue] isEqualToString:@"0"]) {
//            [NSObject showStr:@"验证码发送成功"];
//            NSString*urlStr=[NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].baseUrl,@"login"];
//            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:urlStr]];//得到cookie
//            NSString*JSESSIONID=@"";
//            for (NSHTTPCookie*cookie in cookies) {
//                if ([cookie.name isEqualToString:kSessionId]) {
//                    JSESSIONID=cookie.value;
//                }
//            }
//            [[NSUserDefaults standardUserDefaults] setObject:JSESSIONID forKey:kSessionId];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            //ps ：我们也可以得到cookie里面的session和其他信息
//            NSLog(@"Lzylalala:%@",kStringSessionId);//b2f924e-1d1c-4536-97db-0cb347489344
//
//            __block NSInteger time = 59; //倒计时时间
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//            dispatch_source_set_event_handler(_timer, ^{
//                if(time <= 0){ //倒计时结束，关闭
//                    dispatch_source_cancel(_timer);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //设置按钮的样式
//                        [self.mobileCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                        [self.mobileCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                        self.mobileCodeBtn.userInteractionEnabled = YES;
//                    });
//                }else{
//                    int seconds = time % 60;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //设置按钮显示读秒效果
//                        [self.mobileCodeBtn setTitle:[NSString stringWithFormat:@"(%.2ds)", seconds] forState:UIControlStateNormal];
//                        [self.mobileCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                        self.mobileCodeBtn.userInteractionEnabled = NO;
//                    });
//                    time--;
//                }
//            });
//            dispatch_resume(_timer);
//        }else{
//            NSString *str = request.responseJSONObject[@"msg"];
//            if ([NSObject isString:str]) {
//                [NSObject showStr:str];
//            }
//        }
//
//
//    } failure:^(__kindof YTKBaseRequest *request) {
//        [NSObject showStr:@"验证码发送失败"];
//
//        NSLog(@"LLYTKsendCodeApi failed");
//        NSLog(@"LLYTKsendCodeApi failed");
//
//        NSLog(@"requestArgument:%@",request.requestArgument);
//        NSLog(@"responseHeaders:%@",request.responseHeaders);
//        NSLog(@"response:%@",request.response);
//        NSLog(@"responseData:%@",request.responseData);
//        NSLog(@"responseString:%@",request.responseString);
//        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
//    }];
    
    
    
    
    //    NSString *phoneType = @"0";
    //    NSString *url = [@"http://192.168.0.13/XYGPWuzi_App/" stringByAppendingString:[NSString stringWithFormat:@"xy/user/send/%@/%@.json",_mobileField.text,phoneType]];
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    //    [dict setObject:_mobileField.text forKey:@"phoneNumber"];
    //    [dict setObject:phoneType forKey:@"phoneType"];
    //    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"成功了返回---%@",responseObject);
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        NSLog(@"成功了返回---%@",error);
    //    }];
}
-(void)actionBottomBtn{
    if (self.isBanding == YES) {
        [self configBottomBoxView];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未关联出入金账户，无法进行出金操作。请先提交关联出入金账户进行关联，成功后即可进行出金操作" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            BandingAccountViewController *vc = [BandingAccountViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
}



#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isBanding == YES) {
        return 3;
    }else{
        return 2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.isBanding == YES) {
            return 2;;
        }else{
            return 1;
        }
    }else if (section == 1){
        return 1;
    }else{
        return self.dataSourceArray.count>7?7:self.dataSourceArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.isBanding == YES&& section == 0) {
        return 50;
    }
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height = [self tableView:tableView heightForFooterInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height = [self tableView:tableView heightForFooterInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (self.isBanding == YES&& section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kScreen_Width - 32,  height)];
        label.text = @"出金申请提交后，货款将第一时间转至您的出入金账户中，请您耐心等待。";
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ProductTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;

    if (indexPath.section == 0) {
        Model_Account *accountM = [self.facUserM.accounts count]>0?[self.facUserM.accounts objectAtIndex:0]:[Model_Account new];
        if (self.isBanding == YES) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"出金账户名称";
                cell.detailTextLabel.text = accountM.fbaBankName;
            }else{
                cell.textLabel.text = @"出金账户";
                cell.detailTextLabel.text = accountM.fbaBankNo;
            }
        }else{
            cell.textLabel.text = @"绑定出金账户";
            cell.detailTextLabel.text = @"去绑定";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"交易流水";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"出金记录";
            cell.detailTextLabel.text = @"更多";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            ChhuJiaJiLuTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordTCell"];
            if (cell == nil) {
                cell = [[ChhuJiaJiLuTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecordTCell"];
            }
            Model_dm *dmM = [self.dataSourceArray objectAtIndex:indexPath.row -1];
            
            RecordJiaoyiModel *model = [[RecordJiaoyiModel alloc]init];

            model.tspMoney = dmM.dmMoney;
            model.tspBuyTime = dmM.dmDatetime;
            NSString *str = @"";
            if ([dmM.dmStatus isEqualToString:@"1"]) {
                str = @"申请中";
            }else if ([dmM.dmStatus isEqualToString:@"2"]){
                str = @"通过";
            }else if ([dmM.dmStatus isEqualToString:@"3"]){
                str = @"未通过";
            }
//            model.bidNo = [NSString stringWithFormat:@"%@(%@)",str,[NSObject isString:dmM.dmRefuseReason]?dmM.dmRefuseReason:@"暂无"];
            model.bidNo = str;
            cell.recordJiaoyiM = model;
            return  cell;
        }
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }
    else{
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //绑定出金账户
        if (self.isBanding == NO) {
            BandingAccountViewController *vc = [BandingAccountViewController new];
            Model_Account *accountM = [self.facUserM.accounts count]>0?[self.facUserM.accounts objectAtIndex:0]:nil;
            if (accountM) {
                vc.fbaId = accountM.fbaId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }else if(indexPath.section == 1){
        //交易流水
        Record_JiaoyiLiushuiViewController *vc = [Record_JiaoyiLiushuiViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //出金记录
        if (indexPath.row == 0) {
            Record_ChujinViewController *vc = [Record_ChujinViewController new];
            vc.dataSourceArray = self.dataSourceArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
//        else if (indexPath.row == 1){
//            PayForBailViewController *vc = [PayForBailViewController new];
//            vc.isSingle = NO;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        else{
//            PayForBailViewController *vc = [PayForBailViewController new];
//            vc.isSingle = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
    }
}
@end
