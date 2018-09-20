//
//  PayForProductViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/14.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "PayForProductViewController.h"
#import "XianZhiGongYingTCell.h"
#import "MyProductModel.h"
#import "MyBottomBoxView.h"
#import "Api_SendSMSCode.h"
#import "Api_findPayInfo.h"
#import "MyProductModel.h"
#import "Api_updateHasMoney.h"


@interface PayForProductViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;

@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UIButton *payBtn;

@property(strong, nonatomic)UIButton *mobileCodeBtn;
@property(strong, nonatomic)UITextField *mobileCodeField;
@property(strong, nonatomic)UIButton *sendRequestBtn;
@property(strong, nonatomic)Model_PayForProduct *payForM;
@property(strong, nonatomic)MyBottomBoxView *myBottomBoxView;
@end

@implementation PayForProductViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionIndexBackgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
        _tableView.contentInset = insets;
        _tableView.scrollIndicatorInsets = insets;
    }return _tableView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.userInteractionEnabled = YES;
        CGFloat btnWidth = 100;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreen_Width -15 - btnWidth, CGRectGetHeight(_bottomView.frame))];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"应付金额：%@",@"￥999999.00"] color:[UIColor redColor] length:5];
        self.priceLabel = label;
        [_bottomView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreen_Width - btnWidth, 0, btnWidth, CGRectGetHeight(_bottomView.frame));
        [btn setTitle:@"确认并支付" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [btn setBackgroundColor:kColorNav];
        [btn addTarget:self action:@selector(actionPayFor) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
        self.payBtn = btn;
    }return _bottomView;
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
        [_sendRequestBtn setTitle:@"确认付款" forState:UIControlStateNormal];
        [_sendRequestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendRequestBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_sendRequestBtn setCornerRadius:btnHeight/2];
        [_sendRequestBtn setBackgroundColor:kColorNav];
        [_sendRequestBtn addTarget:self action:@selector(actionSendRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    }return _sendRequestBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"支付货款"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kSafeBottomOffset);
        make.height.mas_equalTo(CGRectGetHeight(self.bottomView.frame));
    }];
    [self serveInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Action
-(void)serveInfo{
    Api_findPayInfo *api = [[Api_findPayInfo alloc] initWithtsId:self.cpId];
    api.animatingText = @"正在上传数据";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject[@"success"] integerValue]==1) {
//            [NSObject ToastShowStr:@"提交成功"];
            self.payForM = [[Model_PayForProduct alloc] initWithDictionary:request.responseJSONObject[@"object"] error:nil];
            
            //应付金额
            self.priceLabel.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"应付金额：%@",[NSObject moneyStyle:self.payForM.lastPay]] color:[UIColor redColor] length:5];
            //下方商品列表
            self.dataSourceArray =[NSMutableArray arrayWithArray:self.payForM.productList];
            [self.tableView reloadData];
            
            
        }else if ([request.responseJSONObject[@"code"] integerValue]==0){
            if ([NSObject isString:request.responseJSONObject[@"message"]]) {
                [NSObject ToastShowStr:request.responseJSONObject[@"message"]];
            }
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
-(void)actionMobileCode{
    Api_SendSMSCode *SendUpdateLoginMobileCodeApi = [[Api_SendSMSCode alloc] initWithMobile:self.payForM.payMoble type:@"6"];
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
        NSLog(@"succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"SendUpdateLoginMobileCodeApi failed");

    }];
}
-(void)actionPayFor{
    [self configBottomBoxView_payForOnline];
}
-(void)actionSendRequestBtn{
    if (![NSObject isString:self.mobileCodeField.text]) {
        [NSObject ToastShowStr:@"请输入验证码"];
        return;
    }
    [self.sendRequestBtn startQueryAnimate];
    Api_updateHasMoney *api = [[Api_updateHasMoney alloc] initWithCpId:self.cpId phoneCode:self.mobileCodeField.text];
    api.animatingText = @"正在付款，请稍候";
    api.animatingView = self.view.window;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [self.sendRequestBtn stopQueryAnimate];

        if ([request.responseJSONObject[@"success"] integerValue] == 1) {
            [NSObject ToastShowStr:@"支付货款成功！"];
            [self.myBottomBoxView closeBottomBoxView];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([request.responseJSONObject[@"success"] integerValue] == 0){
            NSString *str = request.responseJSONObject[@"message"];
            [NSObject ToastShowStr:str];
        }
        NSLog(@"succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest *request) {
        [self.sendRequestBtn stopQueryAnimate];

        NSLog(@"SendUpdateLoginMobileCodeApi failed");
        
    }];
}
-(void)configBottomBoxView_payForOnline{
    MyBottomBoxView *boxView = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.6)];
    boxView.showInfoBtn = YES;
    self.myBottomBoxView = boxView;
    [self.view.window addSubview:boxView];
    
//    Model_Account *accountM = self.tradeM.facUser.accounts.count>0? [self.tradeM.facUser.accounts objectAtIndex:0]:nil;
//    if (!accountM) {
//        return;
//    }
    // 设置数据
    NSArray *titleArray = [NSArray arrayWithObjects:@"应缴金额 ",@"成交时间",@"账户名称",@"支付账户",@"可用余额", nil];
    NSArray *detailArray = [NSArray arrayWithObjects:[NSObject moneyStyle:self.payForM.lastPay],self.payForM.cpCreateTime,self.payForM.payNo,self.payForM.payName, [NSObject moneyStyle:self.payForM.balance], nil];
    [boxView initWithTitle:@"付款至银行监管账户" titleArray:titleArray detailArray:detailArray imageArray:nil];
    CGFloat scrollViewContentHeight = 44*5;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50)];
        label.textColor = kColorNav;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        
        NSMutableString * num = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",self.payForM.payMoble]];
        [num replaceCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];

        label.text = [NSString stringWithFormat:@"向安全支付操作手机 %@ 发送支付验证码",num];
        [boxView.scrollView addSubview:label];
        scrollViewContentHeight +=50;
    }
    //验证码
    self.mobileCodeField.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 30, 44);
    [boxView.scrollView addSubview:self.mobileCodeField];
    scrollViewContentHeight +=44;
    
    
    
    [boxView.scrollView addSubview:self.sendRequestBtn];
    self.sendRequestBtn.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50);
    scrollViewContentHeight +=50;
    
    
    boxView.scrollView.contentSize = CGSizeMake(kScreen_Width, scrollViewContentHeight+44);
    boxView.scrollView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    boxView.clickBlock = ^(UIView *itemView) {
        if ([itemView isKindOfClass:[UIButton class]]) {
            MyBottomBoxView *iew = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.5)];
            [self.view.window addSubview:iew];
            
            [iew initWithTitle:@"竞拍场次银行监管账户" titleArray:nil detailArray:nil imageArray:nil];
            CGFloat scrollViewContentHeight = 44*1;
            {
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height*0.5)];
                backView.backgroundColor = [UIColor whiteColor];
                [iew.scrollView addSubview:backView];
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kScreen_Width - 30, 44)];
                label1.text = weakSelf.payForM.jgzh;
                label1.textColor = UIColor.blueColor;
                [backView addSubview:label1];
                
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 44, kScreen_Width - 32, 150)];
                label.textColor = kColorNav;
                label.font = [UIFont systemFontOfSize:13];
                label.numberOfLines = 0;
                
                NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"●监管账户介绍\n为了保障了买卖双方的交易资金安全，维护了买卖双方的权益。工平物资平台联合第三方银行机构打造安全支付手段--银行监管账户，让保证金、货款在竞拍过程中统一冻结，使竞拍流程更加公开、公平、透明！竞拍全程由银行方提供资金监管服务，安全无忧！"];
                NSDictionary * attri1 = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],}; [str1 setAttributes:attri1 range:NSMakeRange(0,str1.length)];
                NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
                //调整行间距
                paragraphStyle.alignment = NSTextAlignmentLeft;
                paragraphStyle.lineSpacing = 5; //设置行间距
                paragraphStyle.firstLineHeadIndent = 10.0;//设置第一行缩进
                [str1 addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(1)} range:NSMakeRange(0, str1.length)];
                label.attributedText = str1;
                
                [backView addSubview:label];
                scrollViewContentHeight +=50;
            }
            [iew showBottomBoxView];
            
        }
        if (itemView.tag == 100) {// 点击选项一
            NSLog(@"1");
        }
        if (itemView.tag == 101) {// 点击选项二
            NSLog(@"2");
        }
        if (itemView.tag == 102) {// 点击选项三
            
        }
//        BoxItemView *itemView1 = (BoxItemView*)itemView;
        //        [tanKuangView1 closeBottomBoxView];
    };
    
    
    // 显示弹框
    [boxView showBottomBoxView];
}
#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }
    else{
        return 130;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else{
        return self.dataSourceArray.count;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"竞得场次";
    }else{
        return @"竞得产品";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = [UIColor whiteColor];
        NSAttributedString *textStr = [NSAttributedString new];
        if (indexPath.row == 0) {
            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"场次名称：%@",self.payForM.tsName] color:[UIColor grayColor] length:5];
        }else if (indexPath.row == 1){
            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"场次编号：%@",self.payForM.tsTradeNo] color:[UIColor grayColor] length:5];
        }else if (indexPath.row == 2){
            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"竞价开始时间：%@",self.payForM.cpCreateTime] color:[UIColor grayColor] length:7];
        }else if (indexPath.row == 3){
            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"卖方名称：%@",self.payForM.saleUserName] color:[UIColor grayColor] length:5];
        }else if (indexPath.row == 4){
            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"场次类型：%@",self.payForM.tsSiteType] color:[UIColor grayColor] length:5];
        }else if (indexPath.row == 5){
            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"保证金金额：%@",self.payForM.needPay] color:[UIColor grayColor] length:6];
        }
//        else if (indexPath.row == 6){
//            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"竞得成交总额：%ld",[self.payForM.lastPay integerValue]] color:[UIColor grayColor] length:7];
//        }
        else{
            textStr =[NSObject attributedStr:[NSString stringWithFormat:@"%@",@""] color:[UIColor grayColor] length:0];
        }
        cell.textLabel.attributedText = textStr;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        return cell;
    }else{
        static NSString *cellIdentifier = @"IdleProductTCell";
        XianZhiGongYingTCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[XianZhiGongYingTCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = [UIColor whiteColor];
        MyProductModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
        cell.productModel = model;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}

@end
