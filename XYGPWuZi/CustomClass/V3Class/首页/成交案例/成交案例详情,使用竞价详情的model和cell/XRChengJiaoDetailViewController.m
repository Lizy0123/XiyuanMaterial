//
//  XRChengJiaoDetailViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/20.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRChengJiaoDetailViewController.h"
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
#import "ChengJiaoRecordViewController.h"

#import "SDCycleScrollView.h"
#import "ChuJiaRecordViewController.h"

@interface XRChengJiaoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,oneCellBtnClickDelegate,UINavigationControllerDelegate>
//tableView
@property(nonatomic,strong)UITableView * tableView;

//第一个条的数据模型数组
@property(nonatomic,strong)NSMutableArray *firstModelArray;
//所有数据模型的数组
@property(nonatomic,strong)NSMutableArray *allModelArray;
//出价记录数组
@property(nonatomic,strong)NSMutableArray *recordArray;
//竞价公告srting
@property(nonatomic,copy)NSString *gongGaoString;
//所有图片数组
@property(nonatomic,strong)NSMutableArray *allPictureArray;
//轮播图
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(copy, nonatomic)NSString *tsId;
@end

@implementation XRChengJiaoDetailViewController
-(NSMutableArray *)firstModelArray
{
    if (!_firstModelArray) {
        
        _firstModelArray = [[NSMutableArray alloc]init];
    }
    return  _firstModelArray;
}
-(NSMutableArray *)allModelArray
{
    if (!_allModelArray) {
        
        _allModelArray = [[NSMutableArray alloc]init];
    }
    return  _allModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加左划返回手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(popToPre)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizer];
    
    
    [self setupTableView];
    [self requestData];
    
}
-(void)popToPre{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 创建tableView
-(void)setupTableView{
    
    
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    self.tableView.showsVerticalScrollIndicator = YES;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allModelArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        X_JJDetailOneTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
        if (!oneCell) {
            
            oneCell = [[X_JJDetailOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oneCell"];
            
        }
        oneCell.cellType = detailOneCellTypeChengJiaoAnLiCell;
        oneCell.delegatee = self;
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        X_JJDetailOneCellModel *model = self.allModelArray[0];
        oneCell.model = model;
        return oneCell;
    }
    else if (indexPath.row ==1){
        X_JJDetailTwoTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        if (!twoCell) {
            twoCell = [[X_JJDetailTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"twoCell"];
            
        }
        twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        X_JJDetailTwoCellModel *model = self.allModelArray[1];
        
        twoCell.model = model;
        return twoCell;
    }
    else if (indexPath.row ==2){
        X_JJDetailThreeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!threeCell) {
            threeCell = [[X_JJDetailThreeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        X_JJDetailThreeCellModel *model = self.allModelArray[2];
        threeCell.model = model;
        return threeCell;
    }
    else{
        X_JJDetailFourTableViewCell *fourCell = [tableView dequeueReusableCellWithIdentifier:@"fourCell"];
        if (!fourCell) {
            fourCell = [[X_JJDetailFourTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fourCell"];
        }
        fourCell.selectionStyle = UITableViewCellSelectionStyleNone;
        X_JJDetailFourCellModel *model = self.allModelArray[indexPath.row];
        fourCell.model = model;
        return fourCell;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        return 485+40+40+(S_W/5);
    }else if (indexPath.row ==1){
        return 190;
    }
    else if (indexPath.row ==2){
        return 310;
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
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc]init];
    return footView;
    
}
#pragma mark 请求数据
-(void)requestData{
    
    if (!_recordArray) {
        _recordArray = [[NSMutableArray alloc]init];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.color = [UIColor lightGrayColor];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.tnId forKey:@"tnId"];
    
    NSLog(@"%@",dict);
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_TradeNoticeDetail] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hide:YES];
        NSLog(@"------%@",responseObject);
        weakSelf.tsId = responseObject[@"object"][@"tsId"];
        weakSelf.gongGaoString = responseObject[@"object"][@"tnContent"];
        weakSelf.recordArray = responseObject[@"object"][@"processList"];
        
        JingJiaDetail_HeaderModel *amodel = [[JingJiaDetail_HeaderModel alloc]init];
        //isEnd：是否结束（0、否 1、是）
        amodel.isEnd = responseObject[@"object"][@"isEnd"];
        amodel.toBegin = [responseObject[@"object"][@"toBegin"] integerValue];
        amodel.onGoing = [responseObject[@"object"][@"onGoing"]integerValue];
        
        NSLog(@"网络请求的-tobegin-%@---ongoing-%@----isend-%@",responseObject[@"object"][@"toBegin"],responseObject[@"object"][@"onGoing"],amodel.isEnd);
        
        [weakSelf.firstModelArray addObject:amodel];
      
        
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
                        
                        NSString *completePicUrl = [myCDNUrl stringByAppendingString:picUrl];
                        [weakSelf.allPictureArray addObject:completePicUrl];
                    }
                }
                NSLog(@"所有的图片url----%@",weakSelf.allPictureArray);
                //轮播图
                _cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0,S_W, 0.45 *S_W)];
                _cycleScrollView.autoScroll = NO;
                _cycleScrollView.infiniteLoop = NO;
                //_cycleScrollView.backgroundColor=[UIColor lightGrayColor];
                //_cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
                //_cycleScrollView.autoScrollTimeInterval = 4.0; // 轮播时间间隔，默认1.0秒，可自定义
                
                _cycleScrollView.imageURLStringsGroup = weakSelf.allPictureArray;
                weakSelf.tableView.tableHeaderView = _cycleScrollView;
            }
        }
        /*
         *在Main Dispatch Queue中执行Block
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /*
             *只能在主线程中执行的处理
             */
            NSLog(@" 当前线程  %@",[NSThread currentThread]);
            
            [weakSelf.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - oneCellBtnClickDelegate
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
    if (tag == 4) {
        ChuJiaRecordViewController *vc = [[ChuJiaRecordViewController alloc]init];
        vc.tsId = self.tsId;
        [self.navigationController pushViewController:vc animated:YES];
//        ChengJiaoRecordViewController *vc = [[ChengJiaoRecordViewController alloc]init];
//        vc.dataArray = self.recordArray;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}





@end
