//
//  BiddingDetailViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kLabelHeight 44
#define kTitleHeight (kDevice_iPhone4 ? 100 : 150)

#import "BiddingDetailViewController.h"
#import "TitleValueView.h"
#import "BiddingModel.h"
#import "MarqueeLabel.h"

#import "SIOSocket.h"

@interface BiddingDetailViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property(strong, nonatomic)UIScrollView *myScrollView;
@property(strong, nonatomic)UILabel *maxPriceLabel;
@property(assign, nonatomic)NSInteger maxPriceValue;
@property(assign, nonatomic)NSInteger myPriceValue;
@property(assign, nonatomic)NSInteger tsAddPrice;

@property(strong, nonatomic)UITextField *myTextField;
@property(strong, nonatomic)MarqueeLabel *titleLabel;
@property(strong, nonatomic)UILabel *countDownLabel;
@property(assign, nonatomic)NSInteger countDownSeconds;
@property(strong, nonatomic)TitleValueView *endTimeView;


@property(strong, nonatomic)UIView *bottomBar;
@property(strong, nonatomic)UIButton *addPriceBtn;
@property(strong, nonatomic)UIButton *sendPriceBtn;

@property(assign, nonatomic)BOOL isSocketConnect;
@property(strong, nonatomic)SIOSocket *socket;
@property(strong, nonatomic)NSMutableDictionary *socketSendDic;
//倒计时定时器
@property (nonatomic,strong)NSTimer *countDownTimer;
//结束后心跳包定时器
@property (nonatomic,strong)NSTimer *requestResultTimer;
@end

@implementation BiddingDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kDevice_iPhone4) {
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self serveResult:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    NSLog(@"视图消失了");
    [self.countDownTimer invalidate];
    [self.requestResultTimer invalidate];
    if ([self.backDelegate respondsToSelector:@selector(backRefresh)]) {
        [self.backDelegate backRefresh];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionApplicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序，（把程序放在后台执行其他操作）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionApplicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil]; //监听是否重新进入程序程序.（回到程序)

    if (!([NSObject isString:self.biddingM.tsAddPrice])) {
        self.tsAddPrice = 1;
    }else{
        self.tsAddPrice = [self.biddingM.tsAddPrice integerValue];
    }
    
    if (!([NSObject isString:self.biddingM.maxPrice])|| [self.biddingM.maxPrice isEqualToString:@"no"]) {
        self.maxPriceValue = 0;
    }else{
        self.maxPriceValue = [self.biddingM.maxPrice integerValue];
    }

    if (!([NSObject isString:self.biddingM.tsMinPrice])) {
        self.myPriceValue = 0;
    }else{
        self.myPriceValue = [self.biddingM.tsMinPrice integerValue];
    }
    if ([NSObject isString:self.biddingM.endTime]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"beijing"]];
        NSInteger timesp =  (long)[[formatter dateFromString:self.biddingM.endTime] timeIntervalSince1970]*1000;
        NSLog(@"timeSp:%ld",timesp); //时间戳的值
        NSNumber *number = [NSNumber numberWithInteger:timesp];
        [self.socketSendDic setValue:number forKey:@"tsEndTime"];
    }
    
    if ((![NSObject isString:self.biddingM.endTime])) {
        self.sendPriceBtn.enabled = NO;
        [self.sendPriceBtn setTitle:@"竞价结束" forState:UIControlStateNormal];
        self.countDownLabel.text = @"本场竞拍结束";
        self.countDownLabel.textColor = [UIColor redColor];
    }else{
        _countDownSeconds = ([self.biddingM.endTime integerValue])/1000;
        //倒计时秒数
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionCountDown) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
        if (_countDownSeconds <= 120) {
            self.countDownLabel.textColor = [UIColor redColor];
        }
        else{
            self.countDownLabel.textColor = [UIColor blackColor];
        }
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:[self configDetailTimeStr:_countDownSeconds]];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 4)];
//        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, attriStr.length - 3)];
        self.countDownLabel.attributedText = attriStr;
        [[NSRunLoop mainRunLoop]addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
        [_countDownTimer fire];
    }
    [self configSocket];
    
    [self configTopView];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ConfigUI
-(void)configTopView{
    UIScrollView *myScroolView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:myScroolView];
    [myScroolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-(100 + kSafeBottomOffset));
    }];
    self.myScrollView = myScroolView;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTitleHeight)];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTouchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [topView addGestureRecognizer:recognizer];

    [self.view addSubview:topView];
    {//竞拍场次名称
        MarqueeLabel *titleLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width - 30, 44)];
        titleLabel.text = self.biddingM.tnTitle;
        titleLabel.textColor= [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.marqueeType = MLContinuous;
        titleLabel.scrollDuration = 15.0;
        titleLabel.animationCurve = UIViewAnimationOptionCurveEaseInOut;
        titleLabel.fadeLength = 40.0f;
        titleLabel.leadingBuffer = 40.0f;
        titleLabel.trailingBuffer = 20.0f;
        [self.navigationController.navigationBar addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    {//倒计时Label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, (kTitleHeight - 44))];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:[self configDetailTimeStr:_countDownSeconds]];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 4)];
//        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, attriStr.length - 3)];
        titleLabel.attributedText = attriStr;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:23];
        titleLabel.textColor = [UIColor blackColor];
        [topView addSubview:titleLabel];
        self.countDownLabel = titleLabel;
    }

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, (kTitleHeight - 44), kScreen_Width, kLabelHeight)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, 120, 44)];
    titleLabel.text = @"最高出价";
    [view addSubview:titleLabel];
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, 100, 44)];
    if (self.maxPriceValue == 0) {
        valueLabel.text = @"暂时无人出价";
    }else{
        valueLabel.text = [NSString stringWithFormat:@"%ld",self.maxPriceValue];
    }
    valueLabel.textColor = [UIColor redColor];
    valueLabel.font = [UIFont systemFontOfSize:20];
    [view addSubview:valueLabel];
    self.maxPriceLabel = valueLabel;

    [topView addSubview:view];
    [self configScrollView];
}
-(void)configScrollView{
    CGFloat height = kTitleHeight;
//    {
//        TitleValueView * view = [[TitleValueView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, kLabelHeight)];
//        [view setTitleStr:@"结束时间" valueStr:self.biddingM.tsEndTime valueColor:nil];
//        self.endTimeView = view;
//        [self.myScrollView addSubview:view];
//    }
    {
        TitleValueView * view = [[TitleValueView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, kLabelHeight)];
        [view setTitleStr:@"公告名称" valueStr:self.biddingM.tsName valueColor:nil];
        [self.myScrollView addSubview:view];
    }
    {
        TitleValueView * view = [[TitleValueView alloc] initWithFrame:CGRectMake(0, height+kLabelHeight *1, kScreen_Width, kLabelHeight)];
        [view setTitleStr:@"卖方" valueStr:self.biddingM.userName valueColor:nil];
        [self.myScrollView addSubview:view];
    }
    {
        TitleValueView * view = [[TitleValueView alloc] initWithFrame:CGRectMake(0, height+kLabelHeight *2, kScreen_Width, kLabelHeight)];
    if ([NSObject isString:self.companyName] ){
        [view setTitleStr:@"公司名称" valueStr:self.biddingM.companyName valueColor:nil];
    }else{
        [view setTitleStr:@"公司名称" valueStr:self.biddingM.companyName valueColor:nil];

    }
        [self.myScrollView addSubview:view];
    }
    {
        TitleValueView * view = [[TitleValueView alloc] initWithFrame:CGRectMake(0, height+kLabelHeight *3, kScreen_Width, kLabelHeight)];
        [view setTitleStr:@"场次编号" valueStr:self.biddingM.tsTradeNo valueColor:nil];
        [self.myScrollView addSubview:view];
    }
    {
        TitleValueView * view = [[TitleValueView alloc] initWithFrame:CGRectMake(0, height+kLabelHeight *4, kScreen_Width, kLabelHeight)];
        [view setTitleStr:@"起始价格" valueStr:self.biddingM.tsMinPrice valueColor:nil];
        [self.myScrollView addSubview:view];
    }
    {
        TitleValueView * view = [[TitleValueView alloc] initWithFrame:CGRectMake(0, height+kLabelHeight *5, kScreen_Width, kLabelHeight)];
        [view setTitleStr:@"加价幅度" valueStr:self.biddingM.tsAddPrice valueColor:nil];
        [self.myScrollView addSubview:view];
    }
    self.myScrollView.contentSize = CGSizeMake(kScreen_Width, height+kLabelHeight *7);
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTouchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.myScrollView addGestureRecognizer:recognizer];
    [self configButtomView];
}
-(void)configButtomView{
    CGFloat btnWidth = 60;
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectZero];
    bottomBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomBar];
    [bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(100 + kSafeBottomOffset);
    }];
    self.bottomBar = bottomBar;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, 110, 44)];
    label.text = @"出价金额(￥)：";
    label.font = [UIFont systemFontOfSize:14];
    [bottomBar addSubview:label];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(kScreen_Width - kMyPadding*2 - kScreen_Width/3 - btnWidth , 7, kScreen_Width/3, 30)];
    
    textField.delegate = self;
    textField.placeholder = @"请出价";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.borderColor = [UIColor groupTableViewBackgroundColor];
    textField.borderWidth = 0.5;
    textField.layer.cornerRadius = 5;
    textField.clipsToBounds = YES;
    textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.9];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [bottomBar addSubview:textField];
    self.myTextField = textField;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:[NSString stringWithFormat:@"+%ld",(long)self.tsAddPrice] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:0.8]];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:5];
    [btn addTarget:self action:@selector(actionAddPrice) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(CGRectGetMaxX(textField.frame) + kMyPadding, 7, btnWidth, 30)];
    [bottomBar addSubview:btn];
    self.addPriceBtn = btn;
    UIButton *bottomBtn =  [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"出  价" andFrame:CGRectMake(kMyPadding, 50, kScreen_Width - kMyPadding*2, 44) target:self action:@selector(actionSendPrice)];
    [bottomBar addSubview:bottomBtn];
    self.sendPriceBtn = bottomBtn;
}
-(void)configSocket{
    if (!self.socketSendDic) {
        NSMutableDictionary *socketSendDic = [NSMutableDictionary new];
        if ([NSObject isString:self.biddingM.tsId]) {
            [socketSendDic setObject:self.biddingM.tsId forKey:@"tsId"];
        }
        if ([NSObject isString:self.biddingM.tsTradeNo]) {
            [socketSendDic setObject:self.biddingM.tsTradeNo forKey:@"changci"];
        }
        if ([NSObject isString:self.biddingM.tsEndTime]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"beijing"]];
            NSInteger timesp =  (long)[[formatter dateFromString:self.biddingM.tsEndTime] timeIntervalSince1970]*1000;
            NSLog(@"timeSp:%ld",timesp); //时间戳的值
            [socketSendDic setValue:[NSNumber numberWithInteger:timesp] forKey:@"tsEndTime"];
        }
        
        UserModel *entityMember = [UserManager readUserInfo];
        [socketSendDic setObject:entityMember.caseName forKey:@"username"];
        [socketSendDic setValue:entityMember.loginName forKey:@"userid"];
        [socketSendDic setObject:entityMember.token forKey:@"sessionId"];
        [socketSendDic setObject:@"m" forKey:@"source"];
        self.socketSendDic = socketSendDic;
    }


    [SIOSocket socketWithHost:mySocketBaseUrl response:^(SIOSocket *socket) {
        self.socket = socket;
        __weak typeof(self) weakSelf = self;
        self.socket.onConnect = ^(){
            NSLog(@"1.服务器连接成功!");
            weakSelf.isSocketConnect = YES;
            [weakSelf actionShowMessage:@"连接成功" userId:nil];

            //登录
            [weakSelf.socket emit:@"login" args:@[weakSelf.socketSendDic]];
        };


        [self.socket on:@"login" callback:^(SIOParameterArray *args) {
            NSLog(@"2.登录返回的：%@",args);
            NSUInteger maxPrice = [args[0][@"user"][@"content"]integerValue];
            if (maxPrice >= self.maxPriceValue) {
                self.maxPriceValue = maxPrice;
            }
        }];

        [self.socket on:@"message" callback:^(SIOParameterArray *args) {
            NSLog(@"3.发送message后返回：%@",args);
            //显示信息，若userId与自己相同，则提示为出家成功
            [weakSelf actionShowMessage:@"" userId:args[0][@"userid"]];

            //更改记录的最高值，并显示
            weakSelf.maxPriceValue = [args[0][@"content"] integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 回到主线程进行UI操作
                [weakSelf.maxPriceLabel fakeStartAnimationWithDirection:FakeAnimationUp toText:[NSString stringWithFormat:@"%ld",weakSelf.maxPriceValue]];

            });

            //取记录的竞价结束时间，与现在的竞价结束时间进行比较，若相同则不做处理，若不同进行更新（显示最新的结束时间，并将结束时间进行记录）
            NSInteger oldEndTime = [weakSelf.socketSendDic[@"tsEndTime"] integerValue];
            NSInteger newEndTime = [args[0][@"tsEndTime"] integerValue];
            NSLog(@"旧的时间：%ld-----新的时间：%ld",oldEndTime,newEndTime);
            if (oldEndTime != newEndTime) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
                NSString *dateString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:newEndTime/ 1000.0]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 回到主线程进行UI操作
//                    weakSelf.countDownLabel.text = dateString;
                    [weakSelf.endTimeView setTitleStr:@"结束时间" valueStr:dateString valueColor:nil];
                });
//用新的时间替换旧的时间
                [weakSelf.socketSendDic setValue:[NSNumber numberWithInteger:newEndTime] forKey:@"tsEndTime"];
                NSInteger fwqcurrentTime = [args[0][@"date"] integerValue];
                self.countDownSeconds = (newEndTime - fwqcurrentTime)/1000;
                NSLog(@"触发延时后的_secondsCountDown是-%ld",self.countDownSeconds);
            }
        }];
        
        [self.socket setOnReconnect:^(NSInteger numberOfAttempts) {
            
        }];
        [self.socket setOnReconnectionError:^(NSDictionary *errorInfo) {
            weakSelf.isSocketConnect = NO;
            [weakSelf actionShowMessage:@"连接失败！" userId:nil];

        }];

    }];
}
- (NSString *)configDetailTimeStr:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    //    NSLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
    NSString *timeStr = @"距结束:";
    if (day>0) {
        timeStr = [NSString stringWithFormat:@"距结束:%zd天%zd时%zd分%zd秒",day,hour,minute,second];
    }else if (day <= 0&& hour > 0){
        timeStr = [NSString stringWithFormat:@"距结束:%zd时%zd分%zd秒",hour,minute,second];
    }else if (day <= 0&& hour <= 0&& minute > 0){
        timeStr = [NSString stringWithFormat:@"距结束:%zd分%zd秒",minute,second];
    }else if (day <= 0&& hour <= 0&& minute <= 0&& second > 0){
        timeStr = [NSString stringWithFormat:@"距结束:%zd秒",second];
    }
    return timeStr;
}

#pragma mark - Action
-(void)serveData{
}
-(void)actionApplicationWillResignActive:(NSNotification *)notification{
    
}

-(void)actionApplicationDidBecomeActive:(NSNotification *)notification{
    [self serveResult:nil];
}
- (void)actionKeyboardWillChange:(NSNotification *)note{
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height-kSafeAreaTopHeight;
    //这个64是我减去的navigationbar加上状态栏20的高度,可以看自己的实际情况决定是否减去;
    
    [UIView animateWithDuration:duration animations:^{
        self.bottomBar.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}

-(void)actionAddPrice{
    NSUInteger tempInt;
    if (self.myPriceValue >= self.maxPriceValue) {
        tempInt = self.myPriceValue;
    }else{
        tempInt = self.maxPriceValue;
    }
    tempInt+= self.tsAddPrice;

    self.myPriceValue = tempInt;
    _myTextField.text = [NSString stringWithFormat:@"%ld",self.myPriceValue];

}
-(void)actionSendPrice{
    if (self.isSocketConnect) {
        if (self.myPriceValue>=self.maxPriceValue) {
            if (self.myPriceValue - self.maxPriceValue>=self.tsAddPrice) {
                [self.socketSendDic setValue:[NSString stringWithFormat:@"%ld",(long)self.myPriceValue] forKey:@"content"];
                [self.socket emit:@"message" args:@[self.socketSendDic]];
                NSLog(@"---传的参数---%@",self.socketSendDic);
                [_myTextField resignFirstResponder];

            }else{
                [self actionShowMessage:@"出价必须大于加价幅度！" userId:nil];
            }
        }else{
            [self actionShowMessage:@"出价必须大于最高出价！" userId:nil];
        }
    }else{
        [self actionShowMessage:@"链接失败，正在重连..." userId:nil];
    }
}

//提示最高价（若userId与自己相通，则显示出价成功）
-(void)actionShowMessage:(NSString *)messageStr userId:(NSString *)userId{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([NSObject isString:userId]) {
            if ([userId isEqualToString:[UserManager readUserInfo].loginName]) {
                [NSObject ToastShowStr:@"出价成功"];
            }
        }
        if ([NSObject isString:messageStr]) {
            [NSObject ToastShowStr:messageStr];
        }
    });
}

-(void)actionCountDown{
    _countDownSeconds--;
    if (_countDownSeconds==120) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.color = [UIColor lightGrayColor];
        hud.labelText = @"竞价即将结束";
        [hud hide:YES afterDelay:0.7];
    }
    if (_countDownSeconds<=120) {
        _countDownLabel.textColor = [UIColor redColor];
    }
    else{
        _countDownLabel.textColor = [UIColor blackColor];
    }

    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:[self configDetailTimeStr:_countDownSeconds]];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 4)];
//    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, attriStr.length - 3)];
    self.countDownLabel.attributedText = attriStr;
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_countDownSeconds<=0){
        [_countDownTimer invalidate];
        self.countDownLabel.text = @"本场竞拍结束";
        _countDownLabel.textColor = [UIColor redColor];
        [self.sendPriceBtn setTitle:@"竞价结束" forState:UIControlStateNormal];
        self.sendPriceBtn.enabled = NO;
        [self actionShowMessage:@"竞价结束,正在查询结果..." userId:nil];
        _requestResultTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(serveResult:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.requestResultTimer forMode:NSRunLoopCommonModes];
        [_requestResultTimer fire];
    }
}
-(void)serveResult:(NSTimer *)timer{
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetBidInfo] parameters:@{@"id":self.biddingM.tsId,@"token":[UserManager readUserInfo].token} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---结束后返回的数据----%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            {//刷新当前竞价页面
                BiddingModel *biddingM = [[BiddingModel alloc] initWithDictionary:responseObject[@"object"] error:nil];
                if (![biddingM.maxPrice isEqualToString:self.biddingM.maxPrice]) {
                    weakSelf.maxPriceValue = [biddingM.maxPrice integerValue];
                    [weakSelf.maxPriceLabel fakeStartAnimationWithDirection:FakeAnimationUp toText:[NSString stringWithFormat:@"%ld",weakSelf.maxPriceValue]];
                }
                weakSelf.biddingM = biddingM;
                weakSelf.countDownSeconds = ([self.biddingM.endTime integerValue])/1000;
                [weakSelf.endTimeView setTitleStr:@"结束时间" valueStr:weakSelf.biddingM.tsEndTime valueColor:nil];
            }
            {//竞价结束相关操作
                NSString *tsIsSuccess = responseObject[@"object"][@"tsIsSuccess"];
                if (tsIsSuccess!=nil) {
                    [timer invalidate];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert ];
                    if ([tsIsSuccess isEqualToString:@"1"]) {
                        alertController.title = @"本场竞拍成功";
                        NSString *userName = responseObject[@"object"][@"bidNo"];
                        NSString *maxPrice = responseObject[@"object"][@"maxPrice"];
                        if (userName && maxPrice) {
                            alertController.message = [NSString stringWithFormat:@"该商品被%@以%@元的价格竞拍成功",userName,maxPrice];
                        }
                    }else{
                        alertController.title = @"本场流拍";
                    }
                    
                    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:OKAction];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---结束后返回的数据----%@",error);
        [timer invalidate];
    }];
}


#pragma mark - Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
- (void)actionTouchScrollView{
    [self.view endEditing:YES];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]){//按会车可以改变
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    self.myPriceValue = [toBeString integerValue];
    return YES;
}
@end
