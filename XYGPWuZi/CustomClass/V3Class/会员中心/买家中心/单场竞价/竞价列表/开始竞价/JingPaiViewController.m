//
//  JingPaiViewController.m
//  WebSocketTest
//
//  Created by 河北熙元科技有限公司 on 2017/5/27.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "JingPaiViewController.h"
#import "SIOSocket.h"

#import "XRLabel.h"

#import "BiddingDetailViewController.h"

@interface JingPaiViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UIScrollView *myScrollView;
@property (nonatomic,strong)UILabel *titleLabel;
//底部按钮
@property (nonatomic,strong)UIButton *chujiaBtn;

@property (nonatomic,strong)UILabel *zuiGaoChuJiaLabel;
@property (nonatomic,strong)UILabel *endTimeLabel;
@property (nonatomic,strong)UILabel *gongGaoNameLabel;
@property (nonatomic,strong)UILabel *userNameL;
@property (nonatomic,strong)XRLabel *companyNameL;
@property (nonatomic,strong)UILabel *qyTypeL;
@property (nonatomic,strong)XRLabel *bHField;
@property (nonatomic,strong)UILabel *qiShiPriceLabel;
@property (nonatomic,strong)UILabel *jiaJiaFuDuLabel;


//竞价倒计时
@property (nonatomic,strong)UILabel *countDownLabel;

@property (nonatomic,assign)NSInteger countDownSeconds;
//倒计时定时器
@property (nonatomic,strong)NSTimer *countDownTimer;
//结束后心跳包定时器
@property (nonatomic,strong)NSTimer *requestResultTimer;


//出价text
@property (strong, nonatomic)UITextField *myTextField;
//记录最高出价
@property (nonatomic,assign)NSUInteger theMaxPrice;
//起始价格
@property (nonatomic,assign)NSUInteger startPrice;
//加价幅度
@property (nonatomic,assign)NSUInteger addPriceFudu;
//记录当前用户是否出价
@property (nonatomic,assign)BOOL isChuJia;
//结束时间
@property (nonatomic,copy)NSString *overTimee;

//Socket
@property (nonatomic,strong)SIOSocket *socket;
@property (nonatomic,assign)BOOL socketIsConnected;
@property (nonatomic,strong)NSMutableDictionary *socketSendDict;

//连接提示
@property (nonatomic,strong)MBProgressHUD *lianJieHud;

//出价提示
@property (nonatomic,strong)MBProgressHUD *chuJiaHud;

//结束后提示
@property (nonatomic,strong)MBProgressHUD *endHud;
@end

@implementation JingPaiViewController

#pragma mark - init UI
-(id)initWithTitle:(NSString *)title tsName:(NSString *)tsName tsMinPrice:(NSString *)minPrice tsAddPrice:(NSString *)addPrice bianHao:(NSString *)bianHao userName:(NSString *)userName companyName:(NSString *)companyName qiYeType:(NSString *)type maxPrice:(NSString *)maxPrice buyTime:(NSString *)buyTime endTime:(NSInteger)endTime overTime:(NSString *)overTime andtsId:(NSString *)tsId
{

    
   
    if (self = [super init]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.socketSendDict = [NSMutableDictionary dictionary];
        if (tsId != nil) {
            [self.socketSendDict setObject:tsId forKey:@"tsId"];
            [self.socketSendDict setObject:bianHao forKey:@"changci"];
        }

        if (addPrice==nil) {
            
            _addPriceFudu = 1;
        }
        else{
            _addPriceFudu = [addPrice integerValue];
        }
        
        if ([maxPrice isEqualToString:@"no"]) {
            
            _theMaxPrice = 0;
        }
        else{
            _theMaxPrice = [maxPrice integerValue];
        }
        if (minPrice != nil) {
            
            _startPrice = [minPrice integerValue];
        }else{
            _startPrice = 0;
        }
        
        _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _myScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myScrollView.delegate = self;
        _myScrollView.showsVerticalScrollIndicator = NO;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
        [recognizer setNumberOfTapsRequired:1];
        [recognizer setNumberOfTouchesRequired:1];
        [_myScrollView addGestureRecognizer:recognizer];
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _myScrollView.frame.size.width, 70)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.text = title;
        [_myScrollView addSubview:_titleLabel];
        
        
        //竞拍倒计时label
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 70+10, 220, 40)];
        label1.text = @"竞拍倒计时 :";
        //label1.backgroundColor = [UIColor magentaColor];
        label1.font = [UIFont systemFontOfSize:20];
        [_myScrollView addSubview:label1];
        
        //绿色条
        _countDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70+10+40+10, _myScrollView.frame.size.width, 70)];
        //_countDownLabel.text = @"这里显示倒计时";
        _countDownLabel.font = [UIFont systemFontOfSize:22];
        _countDownLabel.textColor = [UIColor blackColor];
        _countDownLabel.textAlignment = NSTextAlignmentCenter;
        //label2.backgroundColor = [UIColor greenColor];
        [_myScrollView addSubview:_countDownLabel];
        
        _chujiaBtn =  [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"出  价" andFrame:CGRectMake(0, 0, 0, 44) target:self action:@selector(chuJia)];
        
        
        
        if (endTime<=0) {
            _chujiaBtn.enabled = NO;
            [_chujiaBtn setHidden:YES];
            [_chujiaBtn setTitle:@"竞价结束" forState:UIControlStateNormal];
            self.countDownLabel.text = @"本场竞拍结束";
            _countDownLabel.textColor = [UIColor redColor];
        }else{
        _countDownSeconds = endTime/1000;
            NSLog(@"进入app的倒计时_secondsCountDown是-%lu",(long)_countDownSeconds);
        //倒计时秒数
         _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionCountDown) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 actionCountDown
            if (_countDownSeconds <= 120) {
                
                _countDownLabel.textColor = [UIColor redColor];
            }
            else{
                _countDownLabel.textColor = [UIColor blackColor];
            }
            
        //设置倒计时显示的时间
        NSString *str_day = [NSString stringWithFormat:@"%02ld",_countDownSeconds/(3600*24)];//天
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_countDownSeconds%(3600*24))/3600];//时
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_countDownSeconds%3600)/60];
        NSString *str_second = [NSString stringWithFormat:@"%02ld",_countDownSeconds%60];
        NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
        NSLog(@"time:%@",format_time);
        
        self.countDownLabel.text = [NSString stringWithFormat:@"%@",format_time];
        [[NSRunLoop mainRunLoop]addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
            
        [_countDownTimer fire];
        }

        //最高出价label
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10, 80, 30)];
        label3.text = @"最高出价 :";
        //label3.backgroundColor = [UIColor magentaColor];
        label3.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:label3];
        
        _zuiGaoChuJiaLabel= [[UILabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10, 160, 30)];
        if ([maxPrice isEqualToString:@"no"]) {
            _zuiGaoChuJiaLabel.text = @"暂时无人出价";
            _theMaxPrice = 0;
        }else{
        _zuiGaoChuJiaLabel.text = maxPrice;
            _theMaxPrice = [maxPrice intValue];
        }
        _zuiGaoChuJiaLabel.textColor = [UIColor redColor];
        _zuiGaoChuJiaLabel.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_zuiGaoChuJiaLabel];
        
        //出价时间label
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10, 80, 30)];
        label4.text = @"结束时间 :";
        //label4.backgroundColor = [UIColor magentaColor];
        label4.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:label4];
        
        _endTimeLabel= [[UILabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10, 160, 30)];
        _endTimeLabel.text = overTime;
        self.overTimee = overTime;
        NSLog(@"----------%@",self.overTimee);
        
        //_chuJiaTimeLabel.backgroundColor = [UIColor magentaColor];
        _endTimeLabel.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_endTimeLabel];
        
        if (self.overTimee!=nil) {
            NSString* timeStr = self.overTimee;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"beijing"]];
            NSInteger timesp =  (long)[[formatter dateFromString:timeStr] timeIntervalSince1970]*1000;
            NSLog(@"timeSp:%ld",timesp); //时间戳的值
            
            NSNumber *number = [NSNumber numberWithInteger:timesp];
            
            [self.socketSendDict setValue:number forKey:@"tsEndTime"];
            
        }
        //公告名称
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10+30+10, 80, 30)];
        label5.text = @"公告名称 :";
        //label5.backgroundColor = [UIColor magentaColor];
        label5.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:label5];
        
        _gongGaoNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10-5, 160, 40)];
        _gongGaoNameLabel.text = tsName;
        _gongGaoNameLabel.numberOfLines = 0;
        
        //_gongGaoNameLabel.backgroundColor = [UIColor magentaColor];
        _gongGaoNameLabel.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_gongGaoNameLabel];
        
        
        //出价人
        UILabel *userNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10+30+10+30+10, 80, 30)];
        userNamelabel.text = @"卖方         :";
        //label5.backgroundColor = [UIColor magentaColor];
        userNamelabel.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:userNamelabel];

        _userNameL = [[UILabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10+30+10, 160, 30)];
        _userNameL.text = userName;
        _userNameL.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_userNameL];
        
        //公司名称
        UILabel *companyL = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10, 80, 30)];
        companyL.text = @"公司名称 :";
        //label5.backgroundColor = [UIColor magentaColor];
        companyL.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:companyL];
        
        _companyNameL = [[XRLabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10, S_W-140, 30)];
        _companyNameL.numberOfLines = 0;
        _companyNameL.text = companyName;
        _companyNameL.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_companyNameL];
        CGSize size = [_companyNameL.text boundingRectWithSize:CGSizeMake(S_W-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_companyNameL.font} context:nil].size;
        if (size.height>=30) {
           _companyNameL.frame = CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10, S_W-140, 40);
        }
        

        
        //场次编号
        UILabel *bianhaoL = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10, 80, 30)];
        bianhaoL.text = @"场次编号 :";
        //label5.backgroundColor = [UIColor magentaColor];
        bianhaoL.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:bianhaoL];
        
        _bHField = [[XRLabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10-5, self.view.bounds.size.width-20-130 , 40)];
        _bHField.text = bianHao;
        _bHField.numberOfLines = 0;
        _bHField.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_bHField];

        
        //起始价格
        UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, 80, 30)];
        label6.text = @"起始价格 :";
        //label6.backgroundColor = [UIColor magentaColor];
        label6.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:label6];
        
        _qiShiPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, 160, 30)];
        _qiShiPriceLabel.text = minPrice;
        //_qiShiPriceLabel.backgroundColor = [UIColor magentaColor];
        _qiShiPriceLabel.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_qiShiPriceLabel];
        
        
        //加价幅度
        UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, 80, 30)];
        label7.text = @"加价幅度 :";
        //label7.backgroundColor = [UIColor magentaColor];
        label7.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:label7];
        
        _jiaJiaFuDuLabel = [[UILabel alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, 160, 30)];
        _jiaJiaFuDuLabel.text = addPrice;
        //_jiaJiaFuDuLabel.backgroundColor = [UIColor magentaColor];
        _jiaJiaFuDuLabel.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:_jiaJiaFuDuLabel];
        
        
        
        //出价金额label
        UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(30, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, 80, 30)];
        label8.text = @"出价金额 :";
        //label8.backgroundColor = [UIColor magentaColor];
        label8.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:label8];
        
        _myTextField = [[UITextField alloc]initWithFrame:CGRectMake(30+80+20, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, S_W-130-80-30, 30)];
        _myTextField.delegate = self;
        _myTextField.placeholder = @"请出价";
        _myTextField.borderStyle = UITextBorderStyleRoundedRect;
        _myTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_myScrollView addSubview:_myTextField];
        
        
        UILabel *label9 = [[UILabel alloc]initWithFrame:CGRectMake(S_W-20-30-60, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, 20, 30)];
        label9.text = @"元";
        //label9.backgroundColor = [UIColor magentaColor];
        label9.font = [UIFont systemFontOfSize:15];
        [_myScrollView addSubview:label9];
        
        UIButton *btn100 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn100.frame = CGRectMake(S_W-20-60, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10, 60, 30);
        //[btn100 setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
        NSString *str = [NSString stringWithFormat:@"+%ld",_addPriceFudu];
        [btn100 setTitle:str forState:UIControlStateNormal];
        [btn100 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn100 setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
        btn100.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn100 addTarget:self action:@selector(btnAdd100) forControlEvents:UIControlEventTouchUpInside];
        
        [_myScrollView addSubview:btn100];
        
        [self.view addSubview:_myScrollView];
        
        //最后设置这个属性
        _myScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 40+70+10+40+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+10+30+30+10+20+20+50+20);
        _lianJieHud = [MBProgressHUD showHUDAddedTo:self.myScrollView animated:YES];
        _lianJieHud.mode = MBProgressHUDModeCustomView;
        
        _lianJieHud.labelText = @"正在连接...";

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_lianJieHud hide:YES];
        });
        
        [self.view addSubview:_chujiaBtn];
        [_chujiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(S_W-32, 44));
            make.left.equalTo(self.view).offset(16);
            make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight-kMyPadding/2);
        }];
        
    }
    return self;
    
}
-(void)setDictParma:(NSMutableDictionary *)dictParma{
    
    _dictParma = dictParma;
}
-(void)goToBiddingList{
    BiddingDetailViewController *vc = [BiddingDetailViewController new];
    vc.biddingM = self.biddingM;
    vc.companyName = self.biddingM.companyName;

    [self.navigationController pushViewController:vc animated:YES];
}

-(void)configSocket{
    UserModel *entityMember = [UserManager readUserInfo];
    [self.socketSendDict setObject:entityMember.caseName forKey:@"username"];
    [self.socketSendDict setValue:entityMember.loginName forKey:@"userid"];
    [self.socketSendDict setObject:entityMember.token forKey:@"sessionId"];
    [self.socketSendDict setObject:@"m" forKey:@"source"];
    
    //socket连接
    [SIOSocket socketWithHost:mySocketBaseUrl response:^(SIOSocket *socket) {
        self.socket = socket;
        __weak typeof(self) weakSelf = self;
        
        
        self.socket.onConnect = ^(){
            NSLog(@"%@",@"已链接");
            weakSelf.socketIsConnected = YES;
            if (weakSelf.socketIsConnected) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 回到主线程进行UI操作
                    weakSelf.lianJieHud.labelText = @"连接成功";
                    [weakSelf.lianJieHud hide:YES afterDelay:0.5];
                });
            }
            //登录
            [weakSelf.socket emit:@"login" args:@[weakSelf.socketSendDict]];
        };
        [self.socket on:@"login" callback:^(SIOParameterArray *args) {
            NSLog(@"login返回的数据----%@",args);
            NSUInteger maxPrice = [args[0][@"user"][@"content"]integerValue];
            if (maxPrice >= _theMaxPrice) {
                _theMaxPrice = maxPrice;
            }
            /*
             {
             content = "1.000000";
             date = 1502270374233;
             userid = 17731556096;
             username = "\U5728\U5bb6\U5462";
             }
             */
        }];
        
        //发送message后返回的数据
        [self.socket on:@"message" callback:^(SIOParameterArray *args) {
            NSLog(@"message返回的数据----%@",args);
            NSString *userid = args[0][@"userid"];
            [weakSelf chujiaWithUserId:userid];
            NSString *maxPrice = args[0][@"content"];
            weakSelf.theMaxPrice = [maxPrice integerValue];
            NSString *max = [NSString stringWithFormat:@"%ld",weakSelf.theMaxPrice];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 回到主线程进行UI操作
                weakSelf.zuiGaoChuJiaLabel.text = max;
            });
            
            NSInteger oldEndTime = [weakSelf.socketSendDict[@"tsEndTime"] integerValue];
            NSInteger newEndTime = [args[0][@"tsEndTime"] integerValue];
            NSLog(@"----旧的时间-%ld-----新的时间%ld",oldEndTime,newEndTime);
            
            if (oldEndTime != newEndTime) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
                NSString *dateString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:newEndTime/ 1000.0]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 回到主线程进行UI操作
                    weakSelf.endTimeLabel.text = dateString;
                });
                
                /*
                 NSDate *datenow = [NSDate date];//现在时间
                 NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
                 //时间转时间戳的方法:
                 NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
                 NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
                 newEndTime = newEndTime - timeSp*1000;
                 */
                
                [weakSelf.socketSendDict setValue:[NSNumber numberWithInteger:newEndTime] forKey:@"tsEndTime"];
                NSInteger fwqcurrentTime = [args[0][@"date"] integerValue];
                _countDownSeconds = (newEndTime - fwqcurrentTime)/1000;
                NSLog(@"触发延时后的_secondsCountDown是-%ld",_countDownSeconds);
            }
        }];
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"竞价";
    //右上角按钮
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"竞价详情" style:UIBarButtonItemStyleDone target:self action:@selector(goToBiddingList)];
    self.navigationItem.rightBarButtonItem = barBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];

    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self configSocket];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"视图消失了");
    [self.countDownTimer invalidate];
    [self.requestResultTimer invalidate];
    [self.socket close];
    if ([self.backDelegate respondsToSelector:@selector(backRefresh)]) {
        NSLog(@"33333");
        [self.backDelegate backRefresh];
    }
}
#pragma mark - Action
#pragma mark 加价
-(void)btnAdd100{
    NSLog(@"加价");
    NSUInteger a;
    if ([_myTextField.text integerValue]<_theMaxPrice) {
        
        if (_theMaxPrice <= _startPrice) {
            a = _startPrice;
            a+= _addPriceFudu;
            _myTextField.text = [NSString stringWithFormat:@"%ld",a];
            
        }else{
            a = _theMaxPrice;
            a+= _addPriceFudu;
            _myTextField.text = [NSString stringWithFormat:@"%ld",a];

        }
    }
    else{
        
        if ([_myTextField.text integerValue] <= _startPrice) {
            
            a = _startPrice;
            a+= _addPriceFudu;
            _myTextField.text = [NSString stringWithFormat:@"%ld",a];

        }else{
            a = [_myTextField.text integerValue];
            a+= _addPriceFudu;
            _myTextField.text = [NSString stringWithFormat:@"%ld",a];

        }
    }
}

#pragma mark 出价
-(void)chuJia {
    if (self.socketIsConnected)
    {
        NSLog(@"用户出价");
        if (_myTextField.text.length > 0) {
            if ([_myTextField.text integerValue]<=_theMaxPrice) {
                NSLog(@"出价低于最高出价");
                MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud1.mode = MBProgressHUDModeCustomView;
                hud1.color = [UIColor grayColor];
                hud1.labelText = @"出价低于最高出价";
                [hud1 hide:YES afterDelay:0.7];
            }
            else{
                if ([_myTextField.text integerValue]-_addPriceFudu>=_theMaxPrice) {
                    [self.socketSendDict setValue:_myTextField.text forKey:@"content"];
                    [self.socket emit:@"message" args:@[self.socketSendDict]];
                    NSLog(@"---传的参数---%@",self.socketSendDict);
                    [_myTextField resignFirstResponder];
                }
                else{
                    
                    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud1.mode = MBProgressHUDModeCustomView;
                    hud1.color = [UIColor grayColor];
                    hud1.labelText = @"加价低于加价幅度";
                    [hud1 hide:YES afterDelay:0.7];
                }
            }
        }
    }
}
#pragma mark 出价显示一个提示,只在自己的客户端显示
-(void)chujiaWithUserId:(NSString *)userId{
//    __weak typeof(self)weakSelf =self;
    if ([userId isEqualToString:[UserManager readUserInfo].loginName]) {
         dispatch_async(dispatch_get_main_queue(), ^{
         // 回到主线程进行UI操作
             //[weakSelf.chuJiaHud hide:YES];
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.mode = MBProgressHUDModeIndeterminate;
         hud.color = [UIColor blackColor];
         hud.labelText = @"出价成功";
         [hud hide:YES afterDelay:0.7];
         });
    }
}

#pragma mark 倒计时
-(void)actionCountDown{
    //NSLog(@"-----%ld",_secondsCountDown);
    //倒计时-1
    _countDownSeconds--;
//    NSLog(@"--倒计时秒数----%ld",_countDownSeconds);
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
    
    NSString *str_day = [NSString stringWithFormat:@"%02ld",_countDownSeconds/(3600*24)];//天
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_countDownSeconds%(3600*24))/3600];//时
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_countDownSeconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_countDownSeconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
    //修改倒计时标签现实内容
    self.countDownLabel.text=[NSString stringWithFormat:@"%@",format_time];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_countDownSeconds<=0){
        [_countDownTimer invalidate];
        self.countDownLabel.text = @"本场竞拍结束";
        _countDownLabel.textColor = [UIColor redColor];
        [_chujiaBtn setTitle:@"竞价结束" forState:UIControlStateNormal];
        _chujiaBtn.enabled = NO;
        [_chujiaBtn setHidden:YES];
        _endHud = [MBProgressHUD showHUDAddedTo:self.myScrollView animated:YES];
        _endHud.color = [UIColor grayColor];
        _endHud.labelText = @"竞价结束,正在查询结果...";
        _requestResultTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(serveResult:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.requestResultTimer forMode:NSRunLoopCommonModes];
        [_requestResultTimer fire];
        
    }
}
-(void)serveResult:(NSTimer *)timer{
    
    NSLog(@"--参数是--%@--%@--定时器--",_dictParma,timer);
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetBidInfo] parameters:_dictParma progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---结束后返回的数据----%@",responseObject);
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {

            NSString *tsIsSuccess = responseObject[@"object"][@"tsIsSuccess"];
            if (tsIsSuccess!=nil) {
                [weakSelf.endHud hide:YES];
                [timer invalidate];
                //UIAlertController风格：UIAlertControllerStyleAlert
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert ];
                
                //添加确定到UIAlertController中
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
               
                
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
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---结束后返回的数据----%@",error);
        [timer invalidate];
        [weakSelf.endHud hide:YES];
    }];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self.view endEditing:YES];
}
- (void)touchScrollView
{
    [self.view endEditing:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
- (void)keyboardWillChange:(NSNotification *)note{
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height-kSafeAreaTopHeight;
    //这个64是我减去的navigationbar加上状态栏20的高度,可以看自己的实际情况决定是否减去;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
    
}
@end
