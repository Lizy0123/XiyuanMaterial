//
//  JingJiaDetailViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/12.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//
/*
#pragma - mark UI
 configTableView{//section
    0:userInfo<=>accountInfo
    1:biddingInfo
    2:conpanyInfo
    3:recordInfo
    4:biddingFlow
    5:fourBtn
    6:biddingAnnouncement
    7:productDetail
    8:pictures
 }
 configTopView
 configTableHeaderView
 configBottomView
 configBottomBtn
 
 #pragma - mark Action:
 serveData
 actionEnroll
 actionRefreshCountDown
 actionPicture
 actionAccount
 actionCompany
 actionRecord
 actionFourBtn
 actionBidding{
    refreshTopView
    refreshHeadView
    refreshRecord
 }
 #pragma - Additional
 倒计时相关操作
 */

#import "JingJiaDetailViewController.h"
#import "JingJiaDetail_HeaderModel.h"
#import "X_JJDetailOneCellModel.h"
#import "X_JJDetailTwoCellModel.h"
#import "X_JJDetailThreeCellModel.h"
#import "X_JJDetailFourCellModel.h"


#import "X_JJDetailOneTableViewCell.h"
#import "X_JJDetailTwoTableViewCell.h"
#import "X_JJDetailThreeTableViewCell.h"
#import "X_JJDetailFourTableViewCell.h"

#import "X_GongGaoInfoViewController.h"
#import "xieYiViewController.h"


#import "DanChangJingJiaViewController.h"
#import "LoginViewController.h"
//轮播图
#import "SDCycleScrollView.h"


#import "BiddingDetailViewController.h"
#import "ChuJiaRecordViewController.h"
//-----------------------------------
#import "XRCarouselView.h"
#import "CountDown.h"
#import "MyStepper.h"
#import "Bidding_TitleValueTowTCell.h"
#import "TitleValueTCell.h"
#import "MyCT_PriceHistoryTCell.h"
#import "MyBottomBoxView.h"




@interface JingJiaDetailViewController ()<UITableViewDelegate, UITableViewDataSource, oneCellBtnClickDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
//myTableView
@property(nonatomic,strong)UITableView * myTableView;
//tableHeadView
@property(nonatomic,strong)UIView *tableHeaderView;
//轮播图
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
//表头视图
@property(nonatomic,strong)UIView *topView;

//第一个条的数据模型数组
@property(nonatomic,strong)NSMutableArray *firstModelArray;
//即将开始的倒计时
@property (nonatomic,assign)NSInteger secondsCountDown;
//正在进行的倒计时
@property (nonatomic,assign)NSInteger twoSecondsCountDown;
//变成正在进行的倒计时
@property (nonatomic,assign)NSInteger threeSecondsCountDown;

//倒计时,左上角图片跟随变化
@property(nonatomic,strong)UIImageView *leftImage;
//倒计时左上角文字跟随变化
@property(nonatomic,strong)UILabel *leftLabel;

@property (nonatomic,weak)NSTimer *countDownTimer;
@property (nonatomic,strong)UILabel *endTimeLabel;

//所有数据模型的数组
@property(nonatomic,strong)NSMutableArray *allModelArray;
//所有图片数组
@property(nonatomic,strong)NSMutableArray *allPictureArray;

//竞价公告srting
@property(nonatomic,copy)NSString *gongGaoString;

@property(nonatomic, strong)NSNumber *isEntry;
@property(nonatomic, copy)NSString *tsId;

//-----------------------------------------
@property(strong, nonatomic)XRCarouselView *myCarouselView;
@property(strong, nonatomic)JingJiaDetail_HeaderModel *headerModel;
@property(strong, nonatomic)CountDown *countDownForLabel;

//BottomView_Enlist
//@property(strong, nonatomic)UIView *bottomView_Enlist;
//底部按钮背景图
@property(nonatomic,strong)UIButton *bottomBtn_Enlist;


//BottomView_Bidding
@property(strong, nonatomic)UIView *bottomView_Bidding;
@property(strong, nonatomic)UITextField *myTextField;

@property(strong, nonatomic)UIButton *addPriceBtnLeft;
@property(strong, nonatomic)UIButton *addPriceBtnMiddle;
@property(strong, nonatomic)UIButton *addPriceBtnRight;

@property(strong, nonatomic)UIButton *sendPriceBtn;
@property(strong, nonatomic)UILabel *nowPriceLabel;
@property(strong, nonatomic)UILabel *priceAddNumLabel;
@property(strong, nonatomic)MyStepper *numberStepper;
@property(assign, nonatomic)CGFloat topViewHeight;




@end

@implementation JingJiaDetailViewController
#pragma mark - Accessor
-(NSMutableArray *)firstModelArray{
    if (!_firstModelArray) {
        _firstModelArray = [[NSMutableArray alloc]init];
    }
    return  _firstModelArray;
}
-(NSMutableArray *)allModelArray{
    if (!_allModelArray) {
        _allModelArray = [[NSMutableArray alloc]init];
    }
    return  _allModelArray;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.isShowBottomView = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"竞价详情";
    self.isSpecialGroup = NO;

    
    
    self.topViewHeight = 40;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back_bt_7"] highImage:[UIImage imageNamed:@"back_bt_7"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = left;
    
    //添加左划返回手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pop)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizer];
    
    [self configTableView];

    [self serveData];
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    BiddingDetailViewController *vc = [BiddingDetailViewController new];
////    vc.biddingM = biddingM;
//    [self.navigationController pushViewController:vc animated:YES];
//}
-(void)dealloc{
    [_countDownForLabel destoryTimer];
    NSLog(@"%s dealloc",object_getClassName(self));
}

#pragma mark - UI
-(void)configTableView{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topViewHeight, 0, kSafeAreaBottomHeight, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;
    
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[TitleValueTCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueTCell];

    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;

    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)configTopView{
    //创建tabble的头部
    if (!self.topView) {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.topViewHeight )];
        topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:topView];
        self.topView = topView;
        
        _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1, kScreen_Width/3, self.topViewHeight)];
        [self.topView addSubview:_leftImage];
        
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, (kScreen_Width/3)-30, self.topViewHeight)];
        leftLabel.textColor = [UIColor whiteColor];
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:leftLabel];
        self.leftLabel = leftLabel;
        
        
        self.endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width/3, 0, 2*kScreen_Width/3, self.topViewHeight)];
        self.endTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:self.endTimeLabel];
        
    }
    //倒计时管理
    self.countDownForLabel = [[CountDown alloc] init];
    long long startLongLong = 1467713971000;
    long long finishLongLong = 1467714322000;
    [_countDownForLabel countDownWithStratTimeStamp:startLongLong finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"666");
        self.endTimeLabel.text = [NSString stringWithFormat:@"%ld天 %ld小时 %ld分 %ld秒",(long)day, (long)hour, (long)minute, (long)second];
    }];

    JingJiaDetail_HeaderModel *model = [self.firstModelArray lastObject];
    
    NSLog(@"tobegin-%ld---ongoing-%ld----isend-%@",model.toBegin,model.onGoing,model.isEnd);
    if ([model.isEnd isEqualToString:@"1"]) {
        _leftImage.image = [UIImage imageNamed:@"kaiShiAndEndBackground"];
        _leftLabel.text = @"已结束";
        NSLog(@"结束了--%@",model.isEnd);
    }else if([model.isEnd isEqualToString:@"0"]){
        
        if (model.toBegin >0) {
            _secondsCountDown = model.toBegin/1000;  //倒计时秒数
            _leftImage.image = [UIImage imageNamed:@"kaiShiAndEndBackground"];
            _leftLabel.text = @"即将开始";
            
            _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(firstCountDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
            //设置倒计时显示的时间
            NSString *str_day = [NSString stringWithFormat:@"%02ld",_secondsCountDown/(3600*24)];
            NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_secondsCountDown%(3600*24))/3600];//时
            NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_secondsCountDown%3600)/60];//分
            NSString *str_second = [NSString stringWithFormat:@"%02ld",_secondsCountDown%60];//秒
            NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
            NSLog(@"time:%@",format_time);
            self.endTimeLabel.text = [NSString stringWithFormat:@"%@",format_time];
            [[NSRunLoop mainRunLoop]addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
            [_countDownTimer fire];
        }else{
            if (model.onGoing>0) {
                _twoSecondsCountDown = model.onGoing/1000 ;  //倒计时秒数
                _leftImage.image = [UIImage imageNamed:@"startingBackground"];
                _leftLabel.text = @"正在进行";
                
                _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondCountDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
                //设置倒计时显示的时间
                NSString *str_day = [NSString stringWithFormat:@"%02ld",_twoSecondsCountDown/(3600*24)];
                NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_twoSecondsCountDown%(3600*24))/3600];//时
                NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_twoSecondsCountDown%3600)/60];//分
                NSString *str_second = [NSString stringWithFormat:@"%02ld",_twoSecondsCountDown%60];//秒
                NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
                NSLog(@"time:%@",format_time);
                self.endTimeLabel.text = [NSString stringWithFormat:@"%@",format_time];
                [[NSRunLoop mainRunLoop]addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
                [_countDownTimer fire];
            }
            else{
                
                _leftImage.image = [UIImage imageNamed:@"kaiShiAndEndBackground"];
                _leftLabel.text = @"已结束";
            }
        }
    }
}
-(void)configTableHeaderViewWithHeight:(CGFloat)height{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.myTableView.tableHeaderView = headerView;
    
    if (!self.myCarouselView) {
        XRCarouselView *carousView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kScreen_Width*0.45)];
        carousView.placeholderImage = [UIImage imageNamed:@"MyImage"];
        carousView.time = 4;
        carousView.contentMode = UIViewContentModeScaleAspectFill;
        carousView.pagePosition = PositionBottomCenter;
        [carousView setDescribeTextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] bgColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
        [headerView addSubview:carousView];
        self.myCarouselView = carousView;
    }
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    //    for (CarouselModel *model in self.carouselArray) {
    //        [arr addObject:model.imageUrl];
    //    }
    self.myCarouselView.imageArray = self.allPictureArray;
    __weak typeof(self)weakSelf = self;
    self.myCarouselView.imageClickBlock = ^(NSInteger index) {
        //        if (weakSelf.carouselArray.count>0) {
        //            CarouselModel *model= [weakSelf.carouselArray objectAtIndex:index];
        //        }
    };
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = self.headerModel.tnTitle;
    titleLabel.numberOfLines = 2;
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myCarouselView.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
    }];
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    numberLabel.text = [NSString stringWithFormat:@"%@",self.headerModel.tsTradeNo];
    [headerView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *newPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    newPriceLabel.text = [NSString stringWithFormat:@"当前价：%@",@"￥99990"];
    
    [headerView addSubview:newPriceLabel];
    [newPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numberLabel.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((kScreen_Width-kMyPadding*2)/2);
    }];
    
    UILabel *pricwnerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    pricwnerLabel.text = [NSString stringWithFormat:@"出价人：%@",@"12345000"];
    
    [headerView addSubview:pricwnerLabel];
    [pricwnerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numberLabel.mas_bottom);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((kScreen_Width-kMyPadding*2)/2);
    }];
    UILabel *presonNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    presonNumLabel.text = [NSString stringWithFormat:@"已报名：%@",@"123人"];
    
    [headerView addSubview:presonNumLabel];
    [presonNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(newPriceLabel.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((kScreen_Width-kMyPadding*2)/2);
    }];
}
-(void)configBottomView{
    CGFloat addPriceBtnWidth = 60;
    CGFloat sendPriceBtnWidth = 120;
    CGFloat bottomViewHeight = 120;
    CGFloat priceInfoBackViewHeight = 40;
    CGFloat labelWidth = 70;
    CGFloat stepperLeft = kMyPadding + labelWidth + kMyPadding/4;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topViewHeight, 0, bottomViewHeight + kSafeAreaBottomHeight, 0);
    self.myTableView.contentInset = insets;
    self.myTableView.scrollIndicatorInsets = insets;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(bottomViewHeight + kSafeBottomOffset);
    }];
    self.bottomView_Bidding = bottomView;
    UIView *priceInfoBackView = [[UIView alloc] initWithFrame:CGRectZero];
    priceInfoBackView.backgroundColor = [UIColor yellowColor];
    [bottomView addSubview:priceInfoBackView];
    [priceInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(bottomView);
        make.right.equalTo(bottomView).offset(-sendPriceBtnWidth);
        make.height.mas_equalTo(priceInfoBackViewHeight);
    }];
    
    
    UILabel *nowPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nowPriceLabel.textAlignment = NSTextAlignmentLeft;
    nowPriceLabel.font = [UIFont boldSystemFontOfSize:14];
    nowPriceLabel.textColor = [UIColor whiteColor];
    [priceInfoBackView addSubview:nowPriceLabel];
    
    UILabel *priceAddNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    priceAddNumLabel.textAlignment = NSTextAlignmentRight;
    priceAddNumLabel.font = [UIFont boldSystemFontOfSize:14];
    priceAddNumLabel.textColor = [UIColor whiteColor];
    [priceInfoBackView addSubview:priceAddNumLabel];
    
    
    [nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(priceInfoBackView);
        make.left.equalTo(priceInfoBackView).offset(kMyPadding);
        make.right.mas_equalTo(priceAddNumLabel.mas_left);
    }];
    [priceAddNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(priceInfoBackView);
        make.left.mas_equalTo(nowPriceLabel.mas_right);
    }];
    self.nowPriceLabel = nowPriceLabel;
    self.priceAddNumLabel = priceAddNumLabel;
    self.nowPriceLabel.text = [NSString stringWithFormat:@"当前价:%@",@"￥10000.00"];
    self.priceAddNumLabel.text = [NSString stringWithFormat:@"出价次数:%@",@"300"];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"出价(￥)：";
    label.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(kMyPadding);
        make.top.mas_equalTo(priceInfoBackView.mas_bottom).offset(kMyPadding/4);
        make.size.mas_equalTo(CGSizeMake(labelWidth, 30));
    }];
    
    if (!self.numberStepper) {
        //CGRectMake(100, 7, 120, 30)
        MyStepper *stepper = [[MyStepper alloc] initWithFrame:CGRectMake(stepperLeft, priceInfoBackViewHeight + kMyPadding/4, kScreen_Width - stepperLeft - sendPriceBtnWidth - kMyPadding/4, 30)];
        [stepper setBorderColor:kColorNav];
        [stepper setTextColor:[UIColor blackColor]];
        [stepper setButtonTextColor:kColorNav forState:UIControlStateNormal];
        stepper.value = 100;
        //        self.numberStepper.hidesDecrementWhenMinimum = YES;
        //        self.numberStepper.hidesIncrementWhenMaximum = YES;
        [bottomView addSubview:stepper];
        self.numberStepper = stepper;
    }
    

    // plain
    self.numberStepper.valueChangedCallback = ^(MyStepper *stepper, float count) {
        NSLog(@"返回的数字%@",@(count));
//        stepper.countTextField.text = weakSelf.addProductM.piNumber = [NSString stringWithFormat:@"%.0f", count];
    };
    [self.numberStepper setup];
    

    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"+%d",/*(long)self.tsAddPrice*/100] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:0.8]];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5];
        [btn addTarget:self action:@selector(actionAddPrice) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(kMyPadding + kMyPadding, CGRectGetMaxY(self.numberStepper.frame)+kMyPadding/2, addPriceBtnWidth, 30)];
        [bottomView addSubview:btn];
        self.addPriceBtnLeft = btn;
    }
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"+%d",/*(long)self.tsAddPrice*/200] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:0.8]];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5];
        [btn addTarget:self action:@selector(actionAddPrice) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(CGRectGetMaxX(self.addPriceBtnLeft.frame) +kMyPadding, CGRectGetMaxY(self.numberStepper.frame)+kMyPadding/2, addPriceBtnWidth, 30)];
        [bottomView addSubview:btn];
        self.addPriceBtnMiddle = btn;
    }
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"+%d",/*(long)self.tsAddPrice*/500] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:0.8]];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5];
        [btn addTarget:self action:@selector(actionAddPrice) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(kMyPadding + CGRectGetMaxX(self.addPriceBtnMiddle.frame), CGRectGetMaxY(self.numberStepper.frame)+kMyPadding/2, addPriceBtnWidth, 30)];
        [bottomView addSubview:btn];
        self.addPriceBtnRight = btn;
    }
    
    
    //确认发送按钮
    UIButton *sendPriceBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [sendPriceBtn setTitle:@"确认出价" forState:UIControlStateNormal];
    [sendPriceBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [sendPriceBtn addTarget:self action:@selector(actionSendPrice) forControlEvents:UIControlEventTouchUpInside];
    [sendPriceBtn setBackgroundColor:kColorNav];
    [bottomView addSubview:sendPriceBtn];
    [sendPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(bottomView);
        make.bottom.equalTo(bottomView).offset(-kSafeBottomOffset);
        make.width.mas_equalTo(sendPriceBtnWidth);
    }];
    self.sendPriceBtn = sendPriceBtn;
}

-(void)configBottomBtn{
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topViewHeight, 0, kViewAtBottomHeight, 0);
    self.myTableView.contentInset = insets;
    self.myTableView.scrollIndicatorInsets = insets;

    NSString *titleStr = @"报  名";
    if ([self.isEntry integerValue] == 1) {
        titleStr = @"出  价";
    }
    if (!self.bottomBtn_Enlist) {
        self.bottomBtn_Enlist = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:titleStr andFrame:CGRectMake(kMyPadding, 0, kScreen_Width - kMyPadding *2, 44) target:self action:@selector(actionBottomBtn:)];
        [self.view addSubview:self.bottomBtn_Enlist];
        [self.bottomBtn_Enlist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreen_Width - kMyPadding *2, 44));
            make.left.equalTo(self.view).offset(kMyPadding);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-(kSafeAreaBottomHeight));
        }];
    }
    self.bottomBtn_Enlist.enabled = YES;
}









#pragma mark - Action
-(void)serveData{
    if (0) {
        if (self.isShowBottomView) {
            [self configBottomBtn];
        }
    }else{
        [self configBottomView];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.color = [UIColor lightGrayColor];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.tnId forKey:@"tnId"];
    if ([NSObject isString:[UserManager readUserInfo].token]) {
        [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    }
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_TradeNoticeDetail] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.bottomBtn_Enlist.hidden = NO;
        [hud hide:YES];
        NSLog(@"------%@",responseObject);
        weakSelf.isEntry = responseObject[@"object"][@"isEntry"];
        weakSelf.tsId = responseObject[@"object"][@"tsId"];
        
        weakSelf.gongGaoString = responseObject[@"object"][@"tnContent"];
        JingJiaDetail_HeaderModel *headermodel = [[JingJiaDetail_HeaderModel alloc]init];
        //isEnd：是否结束（0、否 1、是）
        headermodel.isEnd = responseObject[@"object"][@"isEnd"];
        headermodel.toBegin = [responseObject[@"object"][@"toBegin"] integerValue];
        headermodel.onGoing = [responseObject[@"object"][@"onGoing"] integerValue];
        headermodel.tnTitle = responseObject[@"object"][@"tnTitle"];
        headermodel.tsTradeNo = responseObject[@"object"][@"tradeSite"][@"tsTradeNo"];

        [weakSelf.firstModelArray addObject:headermodel];
        weakSelf.headerModel = headermodel;
        [weakSelf configTopView];
        
        X_JJDetailOneCellModel *oneModel = [[X_JJDetailOneCellModel alloc]init];
        oneModel.tnTitle = responseObject[@"object"][@"tnTitle"];
        oneModel.tnCreTime = responseObject[@"object"][@"tnCreTime"];
        oneModel.tsTradeNo = responseObject[@"object"][@"tradeSite"][@"tsTradeNo"];
        oneModel.tnNum = responseObject[@"object"][@"tnNum"];
        oneModel.tnWeigth = responseObject[@"object"][@"tnWeigth"];
        oneModel.tnTradeDate = responseObject[@"object"][@"tnTradeDate"];
        oneModel.tnType = responseObject[@"object"][@"tnType"];
        oneModel.tnUserType = responseObject[@"object"][@"tnUserType"];
        oneModel.tnYyjz = responseObject[@"object"][@"tnYyjz"];
        oneModel.thBlPrice = responseObject[@"object"][@"thBlPrice"];
        oneModel.tnId = responseObject[@"object"][@"tnId"];
        [weakSelf.allModelArray addObject:oneModel];
        
        X_JJDetailTwoCellModel *twoModel = [[X_JJDetailTwoCellModel alloc]init];
        twoModel.tsTradeNo = responseObject[@"object"][@"tradeSite"][@"tsTradeNo"];
        twoModel.tnOwnerName = responseObject[@"object"][@"tnOwnerName"];
        twoModel.tsName = responseObject[@"object"][@"tradeSite"][@"tsName"];
        twoModel.tsTradeDate = responseObject[@"object"][@"tradeSite"][@"tsTradeDate"];
        twoModel.tsJoinType = responseObject[@"object"][@"tradeSite"][@"tsJoinType"];
        twoModel.tsStartTime = responseObject[@"object"][@"tradeSite"][@"tsStartTime"];
        twoModel.tsEndTime = responseObject[@"object"][@"tradeSite"][@"tsEndTime"];
        [weakSelf.allModelArray addObject:twoModel];
        
        X_JJDetailThreeCellModel *threeModel = [[X_JJDetailThreeCellModel alloc]init];
        threeModel.tsTradeNo = responseObject[@"object"][@"tradeSite"][@"tsTradeNo"];
        threeModel.tnType = responseObject[@"object"][@"tnType"];
        threeModel.tsTradeType = responseObject[@"object"][@"tradeSite"][@"tsTradeType"];
        threeModel.tsJjfs = responseObject[@"object"][@"tradeSite"][@"tsJjfs"];
        threeModel.tsNum = responseObject[@"object"][@"tradeSite"][@"tsNum"];
        threeModel.isEnd = responseObject[@"object"][@"isEnd"];
        threeModel.toBegin = responseObject[@"object"][@"toBegin"];
        threeModel.onGoing = responseObject[@"object"][@"onGoing"];
        threeModel.tsMinPrice = responseObject[@"object"][@"tradeSite"][@"tsMinPrice"];
        threeModel.tsAddPrice = responseObject[@"object"][@"tradeSite"][@"tsAddPrice"];
        threeModel.tsProtectPrice = responseObject[@"object"][@"tradeSite"][@"tsProtectPrice"];
        threeModel.tsEndPrice = responseObject[@"object"][@"tradeSite"][@"tsEndPrice"];
        [weakSelf.allModelArray addObject:threeModel];
        
        NSArray *xpiListArray = (NSArray *)responseObject[@"object"][@"xpiList"];
        NSMutableArray *pinPanModelArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in xpiListArray) {
            X_JJDetailFourCellModel *fourModel = [X_JJDetailFourCellModel modeleWithDictionary:dict];
            [weakSelf.allModelArray addObject:fourModel];
            [pinPanModelArray addObject:fourModel];
            
            if (pinPanModelArray.count == xpiListArray.count) {
                weakSelf.allPictureArray = [[NSMutableArray alloc]init];
                for (X_JJDetailFourCellModel *picModel in pinPanModelArray) {
                    NSArray *onePicArray = picModel.picUrls;
                    for (NSString *picUrl in onePicArray) {
                        if ([NSObject isString:picUrl]) {
                            NSString *completePicUrl = [myCDNUrl stringByAppendingString:picUrl];
                            [weakSelf.allPictureArray addObject:completePicUrl];
                        }
                    }
                }
                NSLog(@"所有的图片url----%@",weakSelf.allPictureArray);
                [weakSelf configTableHeaderViewWithHeight:kScreen_Width*2/3+30];
            }
        }
        [weakSelf.myTableView reloadData];
        if (weakSelf.isShowBottomView) {
            if (headermodel.toBegin >0) {
                self.bottomBtn_Enlist.enabled = YES;
            }else{
                if ([weakSelf.isEntry integerValue] == 0) {
                    self.bottomBtn_Enlist.enabled = NO;
                }else{
                    self.bottomBtn_Enlist.enabled = YES;
                    [weakSelf.bottomBtn_Enlist setTitle:@"出  价" forState:UIControlStateNormal];
                    //右上角按钮
                    UIBarButtonItem *nextStepBtn = [[UIBarButtonItem alloc]initWithTitle:@"出价记录" style:UIBarButtonItemStyleDone target:self action:@selector(actionGoToBiddingRecord)];
                    self.navigationItem.rightBarButtonItem = nextStepBtn;
                    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];

                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
    }];
}
-(void)actionGoToBiddingRecord{
    ChuJiaRecordViewController *vc = [[ChuJiaRecordViewController alloc]init];
    vc.tsId = self.tsId;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)actionBottomBtn:(id)sender{
    if ([self.isEntry integerValue] == 1) {
        [self actionGoToDetailVcWithTsId:self.tsId];
    }else{
        [self actionEnroll];
    }
}
-(void)actionGoToDetailVcWithTsId:(NSString *)tsId{
    //出价
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:tsId forKey:@"id"];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    
    MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudd.mode = MBProgressHUDModeCustomView;
    hudd.color = [UIColor grayColor];
    hudd.labelText = @"正在加载竞价模块...";
    
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetBidInfo] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hudd hide:YES];
        NSLog(@"--竞价界面---%@",responseObject);
        BiddingModel *biddingM = [[BiddingModel alloc] initWithDictionary:responseObject[@"object"] error:nil];
        BiddingDetailViewController *vc = [BiddingDetailViewController new];
        vc.biddingM = biddingM;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hudd hide:YES];
    }];
}
-(void)actionEnroll{
    if ([kStringToken length]) {
        UserModel *memberEntity = [UserManager readUserInfo];
        if ([memberEntity.facIsTrade isEqualToString:@"0"]) {
            MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hudd.mode = MBProgressHUDModeCustomView;
            hudd.labelText = @"您不是交易会员,请前往认证";
            [hudd hide:YES afterDelay:0.7];
            NSLog(@"您不是交易会员,请前往认证");
        }else{
            //id：竞价公告编码 token:登录令牌
            X_JJDetailOneCellModel *model = _allModelArray[0];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:model.tnId forKey:@"id"];
            [dict setObject:memberEntity.token forKey:@"token"];
        
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            __weak typeof(self)weakSlef =self;
            [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GoTrade] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [hud hide:YES];
                NSLog(@"----报名结果----%@",responseObject);
                
                int codeStr = [responseObject[@"code"]intValue];
                
                MBProgressHUD *huddd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                huddd.mode = MBProgressHUDModeIndeterminate;
                
                if (codeStr == 200) {
                    huddd.labelText = @"报名成功";
                    [huddd hide:YES afterDelay:0.7];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        DanChangJingJiaViewController *vc = [[DanChangJingJiaViewController alloc]init];
                        vc.selectedPage = 0;
                        [weakSlef.navigationController pushViewController:vc animated:YES];
                    });
                }else if (codeStr == 500){
                    huddd.labelText = @"服务器出错";
                    [huddd hide:YES afterDelay:0.7];
                }else if (codeStr == 1402){
                    huddd.labelText = @"该用户不是交易会员";
                    [huddd hide:YES afterDelay:0.7];
                }else if (codeStr == 1403){
                    huddd.labelText = @"当前用户是该场次的卖家";
                    [huddd hide:YES afterDelay:0.7];
                }else if (codeStr == 1404){
                    huddd.labelText = @"您已报名";
                    [huddd hide:YES afterDelay:0.7];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        DanChangJingJiaViewController *vc = [[DanChangJingJiaViewController alloc]init];
                        vc.selectedPage = 0;
                        [weakSlef.navigationController pushViewController:vc animated:YES];
                    });
                }else if (codeStr == 1405){
                    huddd.labelText = @"当前场次无效";
                    [huddd hide:YES afterDelay:0.7];
                }else{
                    
                    [huddd hide:YES];
                }
//                200：查询成功
//                500：服务器内部错误
//                1402:该用户不是交易会员
//                1403:当前用户是该场次的卖家
//                1404:当前用户已经报名参加该场次
//                1405:当前报名的场次是无效的场次
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [hud hide:YES];
            }];
        }
    }
    else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:^{
        }];
    }
}
#pragma mark 即将开始倒计时
-(void)firstCountDownAction{
    
    //倒计时-1
    _secondsCountDown--;
    NSString *str_day = [NSString stringWithFormat:@"%02ld",_secondsCountDown/(3600*24)];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_secondsCountDown%(3600*24))/3600];//时
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_secondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_secondsCountDown%60];
    NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
    //修改倒计时标签现实内容
    self.endTimeLabel.text=[NSString stringWithFormat:@"%@",format_time];
//    NSLog(@"定时器在运行");
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown<=0){
        
        [_countDownTimer invalidate];
        self.endTimeLabel.text = nil;
        _leftImage.image = [UIImage imageNamed:@"startingBackground"];
        _leftLabel.text = @"正在进行";
        
        JingJiaDetail_HeaderModel *model = self.firstModelArray[0];
        _threeSecondsCountDown = (model.onGoing - model.toBegin)/1000;
        
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(thirddCountDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
        //设置倒计时显示的时间
        NSString *str_day = [NSString stringWithFormat:@"%02ld",_threeSecondsCountDown/(3600*24)];
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_threeSecondsCountDown%(3600*24))/3600];//时
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_threeSecondsCountDown%3600)/60];//分
        NSString *str_second = [NSString stringWithFormat:@"%02ld",_threeSecondsCountDown%60];//秒
        NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
        NSLog(@"time:%@",format_time);
        self.endTimeLabel.text = [NSString stringWithFormat:@"%@",format_time];
        [[NSRunLoop mainRunLoop]addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
        [_countDownTimer fire];
    }
}
#pragma mark 正在进行倒计时
-(void)secondCountDownAction{
    
    //倒计时-1
    _twoSecondsCountDown--;
    NSString *str_day = [NSString stringWithFormat:@"%02ld",_twoSecondsCountDown/(3600*24)];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_twoSecondsCountDown%(3600*24))/3600];//时
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_twoSecondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_twoSecondsCountDown%60];
    NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
    //修改倒计时标签现实内容
    self.endTimeLabel.text=[NSString stringWithFormat:@"%@",format_time];
//    NSLog(@"定时器在运行");
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_twoSecondsCountDown<=0){
        self.endTimeLabel.text = nil;
        _leftImage.image = [UIImage imageNamed:@"kaiShiAndEndBackground"];
        _leftLabel.text = @"已结束";
        [_countDownTimer invalidate];
    }
}
-(void)thirddCountDownAction{
    _threeSecondsCountDown--;
    //设置倒计时显示的时间
    NSString *str_day = [NSString stringWithFormat:@"%02ld",_threeSecondsCountDown/(3600*24)];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(_threeSecondsCountDown%(3600*24))/3600];//时
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_threeSecondsCountDown%3600)/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld",_threeSecondsCountDown%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
    NSLog(@"time:%@",format_time);
    
    self.endTimeLabel.text = [NSString stringWithFormat:@"%@",format_time];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_threeSecondsCountDown<=0){
        self.endTimeLabel.text = nil;
        _leftImage.image = [UIImage imageNamed:@"kaiShiAndEndBackground"];
        _leftLabel.text = @"已结束";
        [_countDownTimer invalidate];
    }
}
#pragma mark 添加手势返回的时候关闭定时器
-(void)pop{
    [self.countDownTimer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popToPre{
    [self.countDownTimer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)actionAddPrice{
    
}
-(void)actionSendPrice{
    
}

#pragma mark - Delegate_Table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.allModelArray.count;
    if (section == 2) {
        return 5;
    }else if (section == 5){
        return 4;
    }
    else if (section == 7){
        return 10;
    }
    
    else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 60;
    }else if (indexPath.section ==1){
        return 210;
    }
    else if (indexPath.section ==2){
        return 44;
    }
    else if (indexPath.section ==3){
        return 220.0;
    }
    else if (indexPath.section ==4){
        return 150;
    }
    else if (indexPath.section ==5){
        return 44;
    }
    else if (indexPath.section ==6){
        return 150;
    }
    else if (indexPath.section ==7){
        return 44;
    }
    
    return 340;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 && self.isSpecialGroup) {
        return 44;
    }else{
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (section == 2 && self.isSpecialGroup) {
        view.backgroundColor = kColorNav;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMyPadding, 2, 40, 40)];
        imageView.image = [UIImage imageNamed:@"MyImage"];
        [view addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), 0, kScreen_Width - CGRectGetMaxX(imageView.frame), 44)];
        label.text = @"背景华夏建龙矿业科技有限公司";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        return view;
    }
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString * CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //        else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        //        {
        //            while ([cell.contentView.subviews lastObject] != nil) {
        //                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        //            }
        //        }
        [self configureCell:cell forIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == 1){
        static NSString * CellIdentifier = @"Cell";
        Bidding_TitleValueTowTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[Bidding_TitleValueTowTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        [self configureCell:cell forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELLL"];
        }
        if (indexPath.row == 0) {
            if (self.isSpecialGroup) {
                cell.textLabel.text = @"专场场次";
                cell.detailTextLabel.text = @"20场";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.textLabel.text = @"卖家名称";
                cell.detailTextLabel.text = @"承德京城矿业有限公司";
            }
//            [cell setTitleStr:@"卖家名称" valueStr:@"承德京城矿业有限公司"];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"会员属性";
            cell.detailTextLabel.text = @"企业个人均可";
//            [cell setTitleStr:@"会员属性" valueStr:@"企业个人均可"];
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"发布时间";
            cell.detailTextLabel.text = @"2018-01-22 15：36";
//            [cell setTitleStr:@"发布时间" valueStr:@"2018-01-22 15：36"];
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"开始时间";
            cell.detailTextLabel.text = @"2018-01-22 15：36";
//            [cell setTitleStr:@"开始时间" valueStr:@"2018-01-22 15：36"];
        }
        else{
            cell.textLabel.text = @"联系客服";
            cell.detailTextLabel.text = @"0315-3859900";
//            [cell setTitleStr:@"联系客服" valueStr:@"0315-3859900"];
        }
//        [cell.textLabel sizeToFit];
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        return cell;

    }else if (indexPath.section == 3){
        NSMutableArray *content = [[NSMutableArray alloc] init];
        for (int j = 0; j < 9; j ++) {
            ContentModel *contentModel = [[ContentModel alloc] init];
            contentModel.itemTitle = @"itemTitle";
            contentModel.typeString = @"游戏";
            contentModel.priceString = [NSString stringWithFormat:@"￥%.2f", (float)(arc4random() % 100 + 1)];
            [content addObject:contentModel];
        }
        HistoryModel *model = [[HistoryModel alloc] init];
        model.title = @"出价记录（11次）";
        model.cellType = arc4random() % 2 + 1;
        model.itemsArray = content;
            
        
        MyCT_PriceHistoryTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCT_PriceHistoryTCell"];
        if (!cell) {
            cell = [[MyCT_PriceHistoryTCell alloc] initWithEntity:model reuseIdentifier:@"MyCT_PriceHistoryTCell"];
        }
        cell.tableViewIndexPath = indexPath;
        //        cell.titleLabel.text = model.title;
        //        cell.entity = model;
        return cell;
    }else if (indexPath.section == 4){
        static NSString * CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        {
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
        imageView.image = [UIImage imageNamed:@"jjlcImage"];
        [cell.contentView addSubview:imageView];
        
        return cell;
    }
    else if (indexPath.section == 5){
        static NSString * CellIdentifier = @"CCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        {
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"竞价服务协议";
            cell.detailTextLabel.text = @"查看";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"拍卖规则";
            cell.detailTextLabel.text = @"查看";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"瑕疵免责声明";
            cell.detailTextLabel.text = @"查看";
        }else{
            cell.textLabel.text = @"出价记录";
            cell.detailTextLabel.text = @"查看";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (indexPath.section == 6){
        static NSString * CellIdentifier = @"qCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        {
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        label.text = @"竞价公告";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        [cell.contentView addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kScreen_Width, 120)];
        label1.numberOfLines = 0;
        label1.text = @"我是静阿发色 饿啊额色发送俺哥施工方的撒高大上俺哥俺三个俺三个是啊是给是给撒公司给俺哥 撒个是高仿萨芬是哥 撒个啊是噶噶撒个啊是的给俺三个啊恩给 饿啊给啊嘎斯给撒给送点给 安师大给安师大给撒旦给俺三个的俺三个啊给 给俺三个啊发安师大发恩发恩爱疯恩无法去恶搞 恩撒个粉安师大广发水电费啊水电费撒发安师大 啊 啊发萨芬撒发顺丰 啊是否啊发的撒发啊是的是发啊水电费 手打发啊是发大水发啊是发大水发啊发大水  啥的发 而非啊是否 爱的色放 啊胃 发给啊给 俺三个额外 竞价公告";
        [cell.contentView addSubview:label1];
        
        
        return cell;
    }
    else if (indexPath.section == 7){
        static NSString * CellIdentifier = @"qCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        {
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"产品编号";
            cell.detailTextLabel.text = @"查看";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"品名";
            cell.detailTextLabel.text = @"查看";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"品牌";
            cell.detailTextLabel.text = @"查看";
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = @"型号";
            cell.detailTextLabel.text = @"查看";
        }
        else if (indexPath.row == 4){
            cell.textLabel.text = @"规格";
            cell.detailTextLabel.text = @"查看";
        }
        else if (indexPath.row == 5){
            cell.textLabel.text = @"数量";
            cell.detailTextLabel.text = @"查看";
        }
        else if (indexPath.row == 6){
            cell.textLabel.text = @"工作时长";
            cell.detailTextLabel.text = @"查看";
        }
        else if (indexPath.row == 7){
            cell.textLabel.text = @"新旧程度";
            cell.detailTextLabel.text = @"查看";
        }
        else{
            cell.textLabel.text = @"所在区域";
            cell.detailTextLabel.text = @"查看";
        }
        return cell;
    }
    else{
        static NSString * CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        [self configureCell:cell forIndexPath:indexPath];
        return cell;
    }
    
//    }
}
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = [NSString stringWithFormat:@"我的竞价编号：%@",@"10000567"];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        label1.text = [NSString stringWithFormat:@"名称：%@",@"河北熙元科技有限公司"];
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = [UIColor blackColor];
        [view addSubview:label1];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.left.equalTo(view).offset(kMyPadding);
            make.right.equalTo(view).offset(-kMyPadding);
            make.height.mas_equalTo(30);
        }];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom);
            make.left.equalTo(view).offset(kMyPadding);
            make.right.equalTo(view).offset(-kMyPadding);
            make.height.mas_equalTo(30);
        }];
        
        [cell.contentView addSubview:view];
    }else if (indexPath.section == 1){


    }else if (indexPath.section == 2){

    }
}


#pragma mark oneCellBtnClickDelegate
-(void)pushVcWithBtnTag:(NSInteger)tag{
    NSLog(@"-----------%ld",tag);
    if (tag == 0) {
        xieYiViewController *vc = [[xieYiViewController alloc]init];
        vc.title = @"竞价服务协议";
        vc.string = @"一、为规范网络竞价行为，根据有关法律、法规特制定本《网络竞价服务协议》。\n二、参与网络竞价的竞买人须是具有完全民事行为能力的自然人、法人以及其他组织，并具备操作计算机的能力。我公司声明不提供统一的竞价场所和竞价工具。\n三、参加竞买人员凭个人身份证明或法人证照办理竞买手续、交付保证金，获得竞买账号，取得竞买资格。没有竞买账号参与竞买者报价无效。\n四、竞买人之间不得恶意串通，操纵竞投，违者依有关法律、法规承担责任。\n五、按照有关规定及“依物品现状进行竞价” 的国际惯例，我公司已在竞价开始前对竞价标的进行了超过两天的预展，并声明不承担瑕疵担保责任。竞买人应在预展期间认真查看了解竞价标的，仔细阅读本《网络竞价服务协议》。竞买人一旦参加竞投，即表示接受竞价标的之一切现状和本规则之全部条款，并对自己的竞投行为负法律责任，不得在成交后以不了解或未曾看货为理由反悔，一经竞价成交确认，委托人及我公司不因竞价标的的瑕疵或可能存在的瑕疵承担任何责任。\n六、本场网络竞价活动采取单品拍的竞价方式，“工平物资网”在线拍卖系统作为本场网络竞价活动指定的网络竞价平台，凡注册成功，申请参拍，并通过我公司资格审核，获得我公司所分配的竞买账号和密码且被激活的竞买人，均可登录聚拍网竞价大厅参与本场网络竞价活动。一台计算机终端设备只能登录一个竞买账号，我公司所分配的竞买账号仅本场竞价会有效。申请人可在缴纳竞买保证金后登陆系统，如可正常登陆，即已通过审核。冒充他人或以他人信息注册的，一经查实即取消其竞买资格并承担相应的法律责任。\n七、竞买人在网上竞得竞价标的成为买受人我公司为方便竞买人参加网络竞价活动，在网上发布与标的相关的图片及其资料仅供参考。竞买人不应仅依赖图片对标的的状况做出判断，竞买人进入本次网络竞价页面，即表明已完全了解标的之一切现状，同意遵守本《网络竞价服务协议》的规定和业务程序，并愿承担一切法律责任，未查验标的现状参加竞买者责任自负。我公司及委托人不承担网络竞价标的的任何瑕疵担保责任。\n竞买人成交后，应于标的成交之日起  两  个工作日内（含成交当日）到我公司指定地点签署相关移交协议并结清全部成交价款及服务费。\n八、未成交的竞买人交付的竞买保证金，自成交之日起（含成交当日） 5 个工作日内退还（不计利息），如竞买保证金退还需要支付手续费应由竞买人自行承担。\n九、委托人及我公司有权对标的的有关情况（包括但不限于起拍价、保留价、竞价阶梯、竞价时间、标的竞价的顺序、有关图像、文字资料）在标的未开始竞价之前进行修改和解释，竞买人应当予以充分理解并在竞价标的竞价过程中注意。买受人在成交后不得以竞价标的的有关情况在开拍前改变为理由反悔，一经成交确认，委托人及我公司不因此承担任何责任。\n十、竞价程序因委托方撤回委托，或因不可抗力等意外事件发生使网络竞价程序暂停或终止的，委托人及我公司不承担违约责任。\n十一、本场网络竞价活动特别约定事项：\n1、竞买人在竞价前应自行认真核实，查验标的信息，自行判断标的的现状是否符合其相关资料或描述。我公司不对标的数量、质量、种类、规格、实用性等情况作任何承诺，如竞买成功，买受人应自行承担全部责任。\n2、标的成交后，买受人自行与委托人协商办理成交标的移交等一切事宜。成交标的一经移交给买受人，所发生的丢失、损毁、事故等责任均由买受人承担。\n3、竞买人一旦参加竞投，即表示接受竞价标的之一切现状和本规则之全部条款，并对自己的竞投行为负法律责任，不得在成交后以不了解为理由反悔，一经竞价成交确认，委托人及本公司不因竞价标的的瑕疵或可能存在的瑕疵承担任何责任。\n4、我公司提供的标的目录仅供参考，标的以实物现状为准。标的成交一经确认，所发生的与标的有关的全部费用与责任由买受人承担。\n5、 单价竞拍，按实际数量结算。要求现场看货后再报价。 要求：1、由于所售物资均为废旧物资，委托人不对其质量、安全性、技术性能、完整性负责，仅以现场实物状态为准，无论竞买人将该废旧物资用于何种目的，委托人均不承担任何法律责任，由此产生一切的责任和后果由竞买人承担。 2、买受人在提取废旧物资时自行承担全部人工费、输费等运相关费用。\n十二、网上竞买风险声明：\n1、因注册信息不准确、资料提供不完善、竞买保证金交纳不及时，造成申请人用户名不能被审核通过，从而不能登录竞价大厅，我公司不承担任何责任。\n2、竞买人的竞买账号和密码一经转交给竞买人后，因泄露、丢失、遗忘登录密码而产生的一切后果，我公司不承担任何责任。\n3、由于互联网可能出现不稳定情况，不排除网络竞价发生故障（包括但不限于网络故障、电路故障、系统故障）以及被网络黑客恶意攻击，或因竞买人自身终端设备和网络异常等原因导致无法正常竞价的，我公司不承担任何责任。\n4、对于因不可抗力或本系统程序不能控制的因素导致服务中断、报价中断或其他缺陷，我公司不承担任何责任。\n\n竞买人确认：本人（公司）对上述条款已认真阅读、充分理解，并承诺完全遵守。\n注：我公司提供的标的目录、有关文字、图片信息仅供参考，竞买人自行了解标的的现状、数量、质量、实用性等情况。标的以实物的现状为准。标的成交一经确认，买受人不得以任何理由反悔，所发生的与成交标的有关的全部费用与责任由买受人自行承担，委托人及我公司不承担任何费用与责任。";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tag == 1) {
        
        X_GongGaoInfoViewController *vc = [[X_GongGaoInfoViewController alloc]init];
        if (self.gongGaoString) {
            vc.string = self.gongGaoString;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tag == 2) {
        xieYiViewController *vc = [[xieYiViewController alloc]init];
        vc.title = @"瑕疵免责声明";
        vc.string = @"1、转让标的为废旧物资，存在或可能存在瑕疵或缺陷，在性质上存在着部分或全部不能回收和无法实现收益的风险。\n2、在竞价拍卖前，拍卖人已向竞买人提供拍卖标的项目文件、资料，此为竞买成交后拍卖人所能向买受人移交的转让标的的全部文件、资料。买受人无权要求拍卖人在上述文件之外提供其他文件、资料，拍卖人也无义务向买受人提供上述文件、资料之外的文件、资料等。 \n 3、竞买人应依据委托人在拍卖前向竞买人提供的转让标的相关文件、资料，自行、独立、审慎地对拍卖标的进行分析和判断风险，自主决定参加本次拍卖竞价转让活动，并自愿独立承担参与本次拍卖竞价交易的风险。\n4、竞买人一经参与竞买，即视为其已经完全接受并知悉拍卖标的的所有风险、瑕疵，表明是竞买人在独立判断拍卖标的事实、法律上的有效性和商业价值后的自主交易，其愿意独自承担因其判断失误而可能遭受的一切损失或风险。\n5、竞买人一经参与本次拍卖竞价转让，无论拍卖竞价转让标的项下是否存在能够追究委托人及其前手权利人任何法律责任的权利，在本次竞买成交后，均视为买受人同意自拍卖竞价转让标的交付日起自动且全部放弃该等权利，买受人不得以任何方式向委托人及其前手权利人主张本条项下已放弃的全部权利，或要求前手权利人或委托人承担与此有关的任何法律责\n6、竞买人一经参与本次拍卖竞价转让，则其即放弃以重大误解、显失公平或其他任何理由主张变更、撤销、解除本次拍卖竞价转让或减损本次竞买效力的其他任何权利，竞买人不得以任何理由向委托人主张经济补偿或要求委托人承担任何法律责任。\n7、在本次竞买成交后，买受人应严格按照国家相关法律、法规、政策的规定，主张和行使\n8、本次拍卖竞价转让的标的，存在或可能存在因计算误差、不同统计口径、资产实际减损、未按规定核销和折旧等，从而导致买受人实际接收的废旧资产质量、数量等与本次竞买文件表述资料清单中所列不完全一致的情形。竞买人一经参与本次拍卖竞价转让，即视为竞买人已被告知并完全了解本次拍卖竞价转让标的的一切情况。\n9、在参加拍卖竞价前，竞买人已明确无误地知悉并完全了解上述揭示风险和竞拍条件，自愿承担由上述风险造成的一切损失或预期利益的不获得。\n10、参与本次拍卖竞价转让的竞拍前，竞买人有必要对全部拍卖文件进行审慎、全面的阅读并对有关资产进行实地考察，已经完全了解并接受拍卖标的的所有瑕疵、风险、缺陷及委托人所提出的特别约定条件等，竞买人有必要并审慎决定竞买意向。\n11、委托人不保证转让标的所对应的相关债务人（含担保债务人）、义务人名称及名称变更后的准确性，也不保证转让标的的表现形式仍是原有的资产形态。\n12、竞买人一经参与竞买，即表明竞买人已完全了解本次拍卖竞价转让标的的瑕疵情况，拍卖人已履行瑕疵告知义务，竞买人因参加竞买所产生的一切经济、法律责任由竞买人自行承担，与拍卖人、委托方无关。\n13、本瑕疵声明、与拍卖成交确认书、拍卖公告、拍卖规则等文件具有相同的法律效力，是本次拍卖活动的重要组成部分。";
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tag == 3) {
        
        xieYiViewController *vc = [[xieYiViewController alloc]init];
        vc.title = @"拍卖规则";
        vc.string = @"1. 保证金规则\n1)缴纳次数\n参加一笔拍卖交易，不管拍卖的价格和该宝贝想要竞拍的件数，都只需缴纳一次保证金。\n2)缴纳金额\n法院为每一款拍品单独设置了一口价保证金，在报名时，系统锁定的保证金金额为一口价保证金金额。\n3)缴纳方式\n在对拍品第一次确认出价竞拍前，您需要报名缴纳保证金，如您的支付宝账户中有足够的余额支付拍卖保证金，系统会自动锁定该笔款项，并在您的支付宝账户余额中显示为不可用余额，点此查看详细拍卖流程。\n4)锁定期限\n如果拍品拍卖成功，竞价领先者保证金将转化为部分拍卖款直接划扣给法院指定账户，其余竞价不成功者保证金在3天内释放。如果拍品拍卖不成功，则所有人保证金都将在3天内释放。\n2. 延时规则\n1)工平物资出价延时的概念\n出价延时是指，当标的物的竞拍时间只剩最后2分钟时，如果有竞买人出价竞拍，那么系统将会自动延长拍品的竞拍时间。\n2)工平物资出价延时的基本规则\n在设置了出价延时的拍品竞拍结束的前2分钟（以系统接受竞价的时间显示为准），如果有竞买人出价竞拍，那么该次拍卖时间在此次出价的时间的基础上自动延时5分钟，循环往复直到没有竞买人出价竞拍时，拍卖结束。\n3)工平物资出价延时举例说明\n比如：假设某件拍品的拍卖结束时间是8月8日22点整，如果在8月8日21点58分15秒，有竞买人出价，那么系统将拍卖结束时间自动延长至8月8日22点03分15秒；如果在22点03分有竞买人出价，那么系统将自动延时到22点08分……以此类推，直到最后两分钟没有新的竞买人出价，那么该拍品的竞拍结束。\n4)工平物资出价延时的效果\n出价延时给拍卖用户带来的便利包括以下几点： 1.将给到竞买人更加充分的参与竞拍的机会。 2.避免因为网络或者电脑原因导致的延迟而错失出价机会。3. 优先购买权人介绍Feijiu网的会员有优先购买权,如果处置方没有选择优先权，则无优先权购买人。4. 什么叫拍卖保留价\n1)拍卖保留价的定义\n拍卖保留价是处置方设置能够接受的拍品最低成交价，具体的数额并不公开显示，买家如想赢得拍卖，则必须出一个超过保留价、并且是所有出价者中最高的价格，也是传统拍卖中一项基本的功能。 在拍卖进行中，只要有一笔出价记录达到（或超过）保留价，则该次拍卖有效，在拍卖结束时，出价最高者为拍品买受人，将获得该拍品；在拍卖结束时，如果所有的出价记录都没有达到（或超过）保留价，则该次拍卖无效。\n2)拍卖保留价在商品页面的展示\n在拍卖还没有开始的时候，如果拍卖商品有保留价，则保留价的文案显示为“保留价：有”；如果拍卖商品没有保留价，则文案显示“保留价：无”。\n5. 什么是拍卖评估价\n评估价格是指依据一定的评估方法，客观合理价格所做的估计,它以市场交易价格为基础。\n6. 什么是重新拍卖\n参重新拍卖是指拍卖成交后，发现有下列情形的，处置方可以决定重新拍卖。\n1)买受人未支付价款致使拍卖目的难以实现的；\n2)竞买人之间恶意串通的；\n3)其他违反有关法律规定应当重新拍卖的。\n7. 拍卖成交规则\n有很多竞买人，在看到自己喜欢的拍品后，决定参与拍卖，但忙活了一阵子，最后没拍成，拍品显示流拍，那现在为大家梳理一下司法拍卖成交规则，\na.至少2人报名。\nb.至少1人出价。\nc.必须高于或者等于法院设定的保留价，反之，流拍。\n8. 什么是标的物\n标的物是指当事人双方权利义务指向的对象。\n9. 什么是流拍\n“流拍”是指在拍卖中，由于未达到系统设置的条件，造成的拍卖交易失败。";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
