//
//  MyJingJiaListViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/12/30.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "MyJingJiaListViewController.h"
#import "DanChangJingJiaListModel.h"
#import "DanChangJingJiaListTableViewCell.h"
#import "ChuJiaRecordViewController.h"
#import "JingPaiViewController.h"
#import "JingjiaJieGuoViewController.h"
#import "JingJiaDetailViewController.h"
#import "X_JingJiaDetailViewController.h"

#import "XRChengJiaoDetailViewController.h"
#import "BiddingDetailViewController.h"

#import "BiddingModel.h"
#import "ConfirmAgreementViewController.h"
#import "PayForProductViewController.h"
#import "Api_SendSMSCode.h"
#import "Api_updateHasGoods.h"
#import "MyBottomBoxView.h"

@interface MyJingJiaListViewController()<UITableViewDelegate, UITableViewDataSource, MyJingJiaListTableViewCellBtnClickedDelegate, JingPaiViewControllerBackRefreshDelegate, BiddingListViewControllerBackRefreshDelegate, UITextFieldDelegate>
@property(strong, nonatomic)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(copy, nonatomic)NSString *serverTime;
@property(copy, nonatomic)NSString *mobil;
@property(copy, nonatomic)NSString *cpId;
@property(strong, nonatomic)MyBottomBoxView *myBottomBoxView;


@property(nonatomic,assign)__block int page;

@property(strong, nonatomic)UIButton *mobileCodeBtn;
@property(strong, nonatomic)UITextField *mobileCodeField;
@property(strong, nonatomic)UIButton *sendRequestBtn;

@end

@implementation MyJingJiaListViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
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
    _page = 1;
    [self configMyTableView];
    [self requestDataWithStatus:self.myJingJiaListStatus];
}
#pragma mark - UI
-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = NO;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
    tableView.rowHeight = [DanChangJingJiaListTableViewCell cellHightWithListStatus:self.myJingJiaListStatus];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
    __weak typeof(self)weakSelf = self;
    self.myTableView.mj_header  = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestDataWithStatus:weakSelf.myJingJiaListStatus];
    }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestDataWithStatus:weakSelf.myJingJiaListStatus];
    }];
}
#pragma mark - Action
#pragma mark 请求数据
-(void)requestDataWithStatus:(kMyJingJingListStatus)MyJingJingListStatus{
    
    //pageNum：页码（默认1）|pageSize：显示的条数（默认5）|token（登录token）|tsSiteType(场次类型 0：单场 1：拼盘)|tsJoinType (参与方式 1：定向竞价 0：不定向竞价)|tsProcess (流程 0：已报名    1：已参加     2：竞价中     3：待支付    4：待提货    5：竞价完成     6:竞价失败)|pName 场次名称或者产品的名称
    //pageNum：页码（默认1）|pageSize：显示的条数（默认5）|token（登录token）
    NSString *pageSize = @"15";
    NSString *pageNumber = [NSString stringWithFormat:@"%d",self.page];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:pageSize forKey:@"pageSize"];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    [dict setObject:pageNumber forKey:@"pageNum"];
    NSString *tsProcess = @"";
    switch (MyJingJingListStatus) {
        case kMyJingJingListStatusYiBaoMing:
        {
            tsProcess = @"0";
        }
            break;
        case kMyJingJingListStatusYiCanJia:
        {
            tsProcess = @"1";
        }
            break;
        case kMyJingJingListStatusStarted:
        {
            tsProcess = @"2";
        }
            break;
        case kMyJingJingListStatusWaitingTopay:
        {
            tsProcess = @"3";
        }
            break;
        case kMyJingJingListStatusAlreadyPay:
        {
            tsProcess = @"4";
        }
            break;
        case kMyJingJingListStatusSuccess:
        {
            tsProcess = @"5";
        }
            break;
        case kMyJingJingListStatusFaild:
        {
            tsProcess = @"6";
        }
            break;
        default:
            break;
    }
    [dict setObject:tsProcess forKey:@"tsProcess"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color = [UIColor grayColor];
    __weak typeof(self)weakSelf = self;
    NSLog(@"%@%@",myBaseUrl,kPath_GetBidList);
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetBidList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
        NSLog(@"-状态%@--返回的结果-%@",tsProcess,responseObject);
        if (weakSelf.page == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
//            if ([responseObject[@"object"] containsValueForKey:@"serverTime"]) {
                self.serverTime = responseObject[@"object"][@"serverTime"];
            self.mobil = responseObject[@"object"][@"mobil"];
            
//            }
//            if ([responseObject[@"object"] containsValueForKey:@"list"]) {
                NSArray *data = (NSArray *)responseObject[@"object"][@"list"];
                if (data.count==0) {
                    [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.dataArray addObjectsFromArray:[DanChangJingJiaListModel arrayOfModelsFromDictionaries:data error:nil]];
                }
//            }
        }
        [weakSelf.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
    }];
    
    
}
#pragma mark 进入出价页面
-(void)goToDetailVcWithTsId:(NSString *)tsId{
    
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
//        NSString *userName = responseObject[@"object"][@"userName"];
//        NSString *title = responseObject[@"object"][@"tnTitle"];
//        NSInteger endTime = [responseObject[@"object"][@"endTime"]integerValue];
//        NSString *minPrice = responseObject[@"object"][@"tsMinPrice"];
//        NSString *maxPrice = responseObject[@"object"][@"maxPrice"];
//        NSString *addPrice = responseObject[@"object"][@"tsAddPrice"];
//        NSString *buyTime = responseObject[@"object"][@"buyTime"];
//        NSString *tsName = responseObject[@"object"][@"tsName"];
//        NSString *companyName = responseObject[@"object"][@"companyName"];
//        NSString *bianHao = responseObject[@"object"][@"tsTradeNo"];
//        NSString *qyType = responseObject[@"object"][@"type"];
//        NSString *overTime = responseObject[@"object"][@"tsEndTime"];
//
//        NSLog(@"sssssssssssss----%@",overTime);
//
//        JingPaiViewController *vc = [[JingPaiViewController alloc]initWithTitle:title tsName:tsName tsMinPrice:minPrice tsAddPrice:addPrice bianHao:bianHao userName:userName companyName:companyName qiYeType:qyType maxPrice:maxPrice buyTime:buyTime endTime:endTime overTime:overTime andtsId:tsId];
//        vc.backDelegate = weakSelf;
//        vc.dictParma = dict;
//        vc.biddingM = biddingM;
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        BiddingDetailViewController *vc = [BiddingDetailViewController new];
        vc.biddingM = biddingM;
        vc.companyName = biddingM.companyName;
        vc.backDelegate = self;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hudd hide:YES];
    }];
}
#pragma mark - JingPaiViewControllerBackRefreshDelegate
-(void)backRefresh{
    
    self.page = 1;
    [self requestDataWithStatus:self.myJingJiaListStatus];
}
#pragma mark UITableViewDelegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DanChangJingJiaListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DanChangJingJiaListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.serverTime = self.serverTime;
    cell.myJingJiaListStatus = self.myJingJiaListStatus;
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (self.myJingJiaListStatus) {
        case kMyJingJingListStatusYiBaoMing:
        {
            DanChangJingJiaListModel *model = self.dataArray[indexPath.row];
            [self goToJingJiaDetailViewControllerWithModel:model];
            
        }
            break;
        case kMyJingJingListStatusYiCanJia:
        {
            DanChangJingJiaListModel *model = self.dataArray[indexPath.row];
            [self goToJingJiaDetailViewControllerWithModel:model];
        }
            break;
        case kMyJingJingListStatusStarted:
        {
            DanChangJingJiaListModel *model = self.dataArray[indexPath.row];
            [self goToDetailVcWithTsId:model.tsId];
        }
            break;
        case kMyJingJingListStatusWaitingTopay:
        {
            DanChangJingJiaListModel *model = self.dataArray[indexPath.row];
            [self goToChengJiaoDetailViewControllerWithModel:model];
        }
            break;
        case kMyJingJingListStatusAlreadyPay:
        {
            DanChangJingJiaListModel *model = self.dataArray[indexPath.row];
            [self goToChengJiaoDetailViewControllerWithModel:model];
        }
            break;
        case kMyJingJingListStatusSuccess:
        {
            DanChangJingJiaListModel *model = self.dataArray[indexPath.row];
            [self goToChengJiaoDetailViewControllerWithModel:model];
        }
            break;
        case kMyJingJingListStatusFaild:
        {
            
        }
            break;
        default:
            break;
    }
}
#pragma mark 跳转到竞价详情页
-(void)goToJingJiaDetailViewControllerWithModel:(DanChangJingJiaListModel *)model{
//    JingJiaDetailViewController *vc = [[JingJiaDetailViewController alloc]init];
//    vc.tnId = model.tnId;
//    vc.isShowBottomView = NO;
//    [self.navigationController pushViewController:vc animated:YES];
    X_JingJiaDetailViewController *vc = [[X_JingJiaDetailViewController alloc]init];
    vc.tnId = model.tnId;
    vc.isShowBottomView = NO;
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 跳转成交案例页
-(void)goToChengJiaoDetailViewControllerWithModel:(DanChangJingJiaListModel *)model{
    XRChengJiaoDetailViewController *vc = [[XRChengJiaoDetailViewController alloc]init];
    vc.tnId = model.tnId;
    if (model.tsName) {
        vc.navigationItem.title = model.tsName;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark MyJingJiaListTableViewCellBtnClickedDelegate
-(void)clickBtn:(UIButton *)btn onCell:(DanChangJingJiaListTableViewCell *)cell{
    if (cell.myJingJiaListStatus == kMyJingJingListStatusYiBaoMing) {
        
    }
    switch (cell.myJingJiaListStatus) {
        case kMyJingJingListStatusYiBaoMing:{
            if (btn.tag == 2) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"看货申请" message:@"请致电客服热线 0315-3859900申请看货，平台通过审核后将第一时间以电话或短信通知您看货时间及看货地址，请耐心等待！" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击确认");
                }]];
                [self.view.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            }else{
                ConfirmAgreementViewController *vc = [ConfirmAgreementViewController new];
                vc.tsId = cell.model.tsId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case kMyJingJingListStatusYiCanJia:{
            
        }
            break;
        case kMyJingJingListStatusStarted:{
            //出价记录
            if (btn.tag == 1) {
                ChuJiaRecordViewController *vc = [[ChuJiaRecordViewController alloc] init];
                vc.tsId = cell.model.tsId;
                [self.navigationController pushViewController:vc animated:YES];
            }
            //出价操作
            if (btn.tag == 2) {
                [self goToDetailVcWithTsId:cell.model.tsId];
            }
        }
            break;
        case kMyJingJingListStatusWaitingTopay:{
            if (btn.tag == 1) {
                PayForProductViewController *vc = [[PayForProductViewController alloc] init];
                vc.cpId = cell.model.cpId;
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (btn.tag == 2) {
                NSLog(@"成交结果");
                JingjiaJieGuoViewController *vc = [[JingjiaJieGuoViewController alloc]init];
                vc.tsId = cell.model.tsId;
                vc.type = @"0";
                vc.zhiFuZhuangTai = @"待支付";
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case kMyJingJingListStatusAlreadyPay:{
            if (btn.tag == 1) {
                self.cpId = cell.model.cpId;
                [self configBottomBoxView_payForOnline];
            }
            if (btn.tag == 2) {
                NSLog(@"成交结果");
                JingjiaJieGuoViewController *vc = [[JingjiaJieGuoViewController alloc]init];
                vc.tsId = cell.model.tsId;
                vc.type = @"0";
                vc.zhiFuZhuangTai = @"已支付";
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case kMyJingJingListStatusSuccess:{
            if (btn.tag == 2) {
                NSLog(@"成交结果");
                JingjiaJieGuoViewController *vc = [[JingjiaJieGuoViewController alloc]init];
                vc.tsId = cell.model.tsId;
                vc.type = @"0";
                vc.zhiFuZhuangTai = @"已支付";
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case kMyJingJingListStatusFaild:
        {
            
        }
            break;
        default:
            break;
    }
}






-(void)actionSendRequestBtn{
    if (![NSObject isString:self.mobileCodeField.text]) {
        [NSObject ToastShowStr:@"请输入验证码"];
        return;
    }
    Api_updateHasGoods *api = [[Api_updateHasGoods alloc] initWithCpId:self.cpId phoneCode:self.mobileCodeField.text];
    api.animatingText = @"正在请求数据...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if ([request.responseJSONObject[@"success"] integerValue] == 1) {
            [NSObject ToastShowStr:@"提交成功！"];
            [self.myBottomBoxView closeBottomBoxView];
            
        }else if ([request.responseJSONObject[@"success"] integerValue] == 0){
            NSString *str = request.responseJSONObject[@"message"];
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
    }];
}


-(void)actionMobileCode{
    Api_SendSMSCode *api = [[Api_SendSMSCode alloc] initWithMobile:self.mobil type:@"7"];
    api.animatingText = @"正在发送验证码...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
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
-(void)configBottomBoxView_payForOnline{
    MyBottomBoxView *boxView = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.6)];
    boxView.showInfoBtn = NO;
    self.myBottomBoxView = boxView;
    [self.view.window addSubview:boxView];
    
    [boxView initWithTitle:@"提货确认" titleArray:nil detailArray:nil imageArray:nil];
    CGFloat scrollViewContentHeight = 0;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50)];
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;

        label.text = @"⚠︎您正在进行确认提货操作，请确认标的物已全部提到！";
        [boxView.scrollView addSubview:label];
        scrollViewContentHeight +=50;
    }
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50)];
        label.textColor = kColorNav;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        
        NSMutableString * num = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",self.mobil]];
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
    
    boxView.clickBlock = ^(UIView *itemView) {

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

@end
