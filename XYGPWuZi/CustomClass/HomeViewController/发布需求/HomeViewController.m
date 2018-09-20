//
//  HomeViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/5.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
//搜索框
#import "SearchBarView.h"

//产品分类
#import "ProductCategoryViewController.h"
//产品列表页
#import "XMainProductListTableViewController.h"
#import "TradeNoticeTCell.h"
#import "TradeNoticeModel.h"

//竞价详情页
#import "BiddingDetail_ViewController.h"
#import "X_JingJiaDetailViewController.h"
//求购信息
#import "XianZhiQiuGouViewController.h"
//竞价公告
#import "GongGaoListViewController.h"
//闲置物资
#import "XianZhiQiuGouViewController.h"
/*********************************/
//轮播图
#import "SDCycleScrollView.h"
#import "SearchViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SearchBarViewDelegate>
//tableView
@property(nonatomic,strong)UITableView * tableView;
//表头视图
@property(nonatomic,strong)UIView * headerView;
//数据数组
@property(nonatomic,strong)NSMutableArray *dataArray;
//轮播图
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
//记录注销的次数
@property(nonatomic,assign)int logoutNum;

@end

@implementation HomeViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //创建tabble的头部
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100+0.4*S_W+10)];
    self.headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_headerView];
    /*
     0.3125*SCREEN_WIDTH
     以320为基础  比例为100:320  就是0.3215倍的屏幕宽 广告位宽度150:320 = 0.46875
     */

    //创建tableview
    [self setupTableView];
    //创建头部广告位和所有按钮
    [self setupHeadView];
    //设置导航上控件
    [self setNavigationSubViews];
    //创建搜索框
    [self addSearchBar];
    //请求数据
    [self serveData];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NSObject serveCategory];

}
#pragma mark - UI

#pragma mark 创建头部广告位和所有按钮
-(void)setupHeadView{
    //轮播图
    _cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0,S_W, 0.4 *S_W)];
    _cycleScrollView.infiniteLoop = YES;
    _cycleScrollView.backgroundColor=[UIColor lightGrayColor];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.autoScrollTimeInterval = 4.0; // 轮播时间间隔，默认1.0秒，可自定义
    [_headerView addSubview:_cycleScrollView];

    //下边按钮bgm
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.4 *S_W, S_W, 100)];
    btnView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:btnView];
    
    //按钮间距
    NSInteger space = (S_W - 60 * 5)/10;

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(space, 10, 60, 80);
    [button1 addTarget:self action:@selector(goToJiaoyiyugao) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:button1];

    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 50)];
    image1.layer.cornerRadius = 10;
    image1.clipsToBounds = YES;
    image1.image = [UIImage imageNamed:@"jiaoyiyugao"];
    [button1 addSubview:image1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60 , 20)];
    label1.text = @"交易预告";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor =[UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [button1 addSubview:label1];
    
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(space*3+60, 10, 60, 80);
    [button2 addTarget:self action:@selector(goToXzwz) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:button2];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 50)];
    image2.layer.cornerRadius = 10;
    image2.clipsToBounds = YES;
    image2.image = [UIImage imageNamed:@"xianzhiwuzi"];
    [button2 addSubview:image2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60 , 20)];
    label2.text = @"闲置物资";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor =[UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [button2 addSubview:label2];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(space*5+60*2, 10, 60, 80);
    [button3 addTarget:self action:@selector(goToQiugou) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:button3];
    
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 50)];
    image3.layer.cornerRadius = 10;
    image3.clipsToBounds = YES;
    image3.image = [UIImage imageNamed:@"qiugouxinxi"];
    [button3 addSubview:image3];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60 , 20)];
    label3.text = @"求购信息";
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor =[UIColor blackColor];
    label3.textAlignment = NSTextAlignmentCenter;
    [button3 addSubview:label3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(space*7+60*3, 10, 60, 80);
    button4.tag = 123033;
    [button4 addTarget:self action:@selector(goToCjal:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:button4];
    
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 50)];
    image4.layer.cornerRadius = 10;
    image4.clipsToBounds = YES;
    image4.image = [UIImage imageNamed:@"chengjiaoanli"];
    [button4 addSubview:image4];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60 , 20)];
    label4.text = @"成交案例";
    label4.font = [UIFont systemFontOfSize:13];
    label4.textColor =[UIColor blackColor];
    label4.textAlignment = NSTextAlignmentCenter;
    [button4 addSubview:label4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(space*9+60*4, 10, 60, 80);
    [button5 addTarget:self action:@selector(goToFenlei) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:button5];
    
    UIImageView *image5 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 50)];
    image5.layer.cornerRadius = 10;
    image5.clipsToBounds = YES;
    image5.image = [UIImage imageNamed:@"chanpinfenlei"];
    [button5 addSubview:image5];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60 , 20)];
    label5.text = @"产品分类";
    label5.font = [UIFont systemFontOfSize:13];
    label5.textColor =[UIColor blackColor];
    label5.textAlignment = NSTextAlignmentCenter;
    [button5 addSubview:label5];
}
#pragma mark 设置导航上的控件
-(void)setNavigationSubViews{
    //设置nav左侧图片
    UIView *shareNavleftView = [[UIView alloc] init];
    shareNavleftView.frame = CGRectMake(0, 0.0, 80, 30);
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"leftLogo"];
    img.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    img.frame = shareNavleftView.frame;
    [shareNavleftView addSubview:img];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:shareNavleftView];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -5;
    UIBarButtonItem * spaceItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem2.width = 15;
    //将BarButtonItem都返回给NavigationItem
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftItem,spaceItem2];
}
#pragma mark 创建搜索框
-(void)addSearchBar{
    //将搜索条放在一个UIView上
    SearchBarView *searchView = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 7, S_W-90-30, 30)];
    searchView.delegate=self;
    self.navigationItem.titleView = searchView;
}

#pragma mark - Action
#pragma mark 请求数据,竞价公告
-(void)serveData{
    __weak typeof(self)weakSelf = self;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"6" forKey:@"pageSize"];
    [dict setObject:@"0" forKey:@"status"];
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_TradeNoticeList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.dataArray removeAllObjects];
        NSArray *dataArray = (NSArray*)responseObject[@"object"];
        
        for (int i = 0; i<dataArray.count; i++) {
            TradeNoticeModel *model = [[TradeNoticeModel alloc]init];
            // 2.0
            model.tnId = dataArray[i][@"tnId"];
            model.tnTitle = dataArray[i][@"tnTitle"];
            model.tnDeposit = dataArray[i][@"tnDeposit"];
            model.tnNum = dataArray[i][@"tnNum"];
            model.tnUnits = dataArray[i][@"tnUnits"];
            model.tnType = dataArray[i][@"tnType"];
            model.tnPic = dataArray[i][@"tnPic"];
            model.tsStatus = dataArray[i][@"tsStatus"];
            model.tsStartTime = dataArray[i][@"tsStartTime"];
            model.tsEndTime = dataArray[i][@"tsEndTime"];
            model.tsName = dataArray[i][@"tsName"];
            model.tsTradeNo = dataArray[i][@"tsTradeNo"];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //加载轮播图
        NSMutableArray *imageUrl = [[NSMutableArray alloc]init];
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:@"xy/ad/show.json"] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"首页轮播图信息--%@",responseObject);
            for (NSDictionary *dict in responseObject[@"object"]) {
                NSString *str = dict[@"detailAddress"];
                NSString *imageUrlStr = [myCDNUrl stringByAppendingString:str];
                [imageUrl addObject:imageUrlStr];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.cycleScrollView.imageURLStringsGroup = imageUrl;
                //[weakSelf.tableView reloadData];
            });
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    });
}

#pragma mark 交易预告
-(void)goToJiaoyiyugao{
    GongGaoListViewController *vc = [[GongGaoListViewController alloc]init];
    //vc.canGoBack = YES;
    vc.selectedPage = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 闲置物资
-(void)goToXzwz{
    XianZhiQiuGouViewController *vc = [[XianZhiQiuGouViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 求购信息
-(void)goToQiugou{
    XianZhiQiuGouViewController *vc = [[XianZhiQiuGouViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 成交案例
-(void)goToCjal:(UIButton *)sender{
    GongGaoListViewController *vc = [[GongGaoListViewController alloc]init];
    //vc.canGoBack = YES;
    if (sender.tag == 123033) {
        vc.selectedPage = 2;
    }else{
        vc.selectedPage = 0;
    }
   [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 产品分类
-(void)goToFenlei{
    ProductCategoryViewController *vc = [[ProductCategoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - tableView dataSoure/delegate
-(void)setupTableView{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, S_H-50) style:UITableViewStyleGrouped];
    //    if (S_H == 812) {
    //        tableView.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-64-50-34);
    //    }
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableHeaderView = self.headerView;
    tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = YES;
    //self.tableView.bouncesZoom = NO;
    tableView.rowHeight = [TradeNoticeTCell cellHeight];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        [self serveData];
        
    }];
    
    //适配tableview
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //下划线左对齐
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * iden = @"cellOne";
    TradeNoticeTCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[TradeNoticeTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden ];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TradeNoticeModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, kScreen_Width, 30);
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TradeNoticeModel *model = self.dataArray[indexPath.row];
//    BiddingDetail_ViewController *vc = [[BiddingDetail_ViewController alloc]init];
//    vc.tnId = model.tnId;
//    [self.navigationController pushViewController:vc animated:YES];
    X_JingJiaDetailViewController *vc = [[X_JingJiaDetailViewController alloc]init];
    vc.tnId = model.tnId;
    [self.navigationController pushViewController:vc animated:YES];
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section{
    return 40;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *chuizi = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.5, 25, 25)];
    chuizi.image  = [UIImage imageNamed:@"chuizi"];
    [headerView addSubview:chuizi];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 120, 30)];
    titleLabel.text = @"竞价公告";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithRed:0 / 255.0 green:153 / 255.0 blue:102/ 255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    

    UIButton *morebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame = CGRectMake(S_W-90, 10, 80, 20);
    morebutton.tag = 123034;
    [morebutton addTarget:self action:@selector(goToCjal:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:morebutton];
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    moreLabel.textColor = [UIColor colorWithRed:0 / 255.0 green:153 / 255.0 blue:102/ 255.0 alpha:1];
    moreLabel.textAlignment = NSTextAlignmentRight;
    moreLabel.font = [UIFont systemFontOfSize:13];
    moreLabel.text = @"查看更多";
    [morebutton addSubview:moreLabel];
    UIImageView *moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(64, 0, 12, 20)];
    moreImage.image = [UIImage imageNamed:@"ico_zhixiang"];
    [morebutton addSubview:moreImage];
    return headerView;
}

#pragma mark - SearchBarViewDelegate Method
- (void)searchBarSearchButtonClicked:(SearchBarView *)searchBarView {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:searchVC];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:nav animated:YES completion:nil];

    //[self.navigationController presentViewController:searchVC animated:YES completion:nil];
//    [self.navigationController pushViewController:searchVC animated:YES];
}
@end
