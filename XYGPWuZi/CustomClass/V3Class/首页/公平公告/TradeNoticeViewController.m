//
//  TradeNoticeViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/12/21.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "TradeNoticeViewController.h"
#import "TradeNoticeTCell.h"
#import "TradeNoticeModel.h"
#import "JingJiaDetailViewController.h"
#import "X_JingJiaDetailViewController.h"


#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterRegionModel.h"
#import "CommonItemModel.h"
#import "AddressModel.h"
#import "PriceRangeModel.h"
#import "SideSlipCommonTableViewCell.h"

@interface TradeNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;
//列表页码
@property(nonatomic,assign)int page;
//请求数据
//0 公告列表 1成交案例列表
@property (nonatomic,copy)NSString *status;
//开始时间
@property (nonatomic,copy)NSString *tnCreTime;
//结束时间
@property (nonatomic,copy)NSString *tnModtime;
//类别ID
@property (nonatomic,copy)NSString *classOne;
//买方资格 0 只限企业 1 只限个人 2全部
@property (nonatomic,copy)NSString *tnUserType;
//0不定向竞价1定向竞价
@property (nonatomic,copy)NSString *tsJoinType;
//0单品 1拼盘
@property (nonatomic,copy)NSString *tsSiteType;
//0 正在进行 1 即将开始
@property (nonatomic,copy)NSString *tsType;
//数据数组
@property(nonatomic,strong)NSMutableArray *dataSourceArray;
//hud
@property (nonatomic,strong)MBProgressHUD *hud;
//筛选界面
@property (strong, nonatomic) ZYSideSlipFilterController *filterController;
@end

@implementation TradeNoticeViewController
-(NSMutableArray *)dataSourceArray{
    
    if (_dataSourceArray == nil) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _tnCreTime = @"";
    _tnModtime = @"";
    _classOne = @"";
    _tsSiteType = @"";
    _tsType = @"";
    
    [self setupFiltView];
    [self setupTableView];
    [self requestData];

}
-(void)setupFiltView{
    __weak typeof(self)weakSelf = self;
    self.filterController = [[ZYSideSlipFilterController alloc] initWithSponsor:self resetBlock:^(NSArray *dataList) {
        for (ZYSideSlipFilterRegionModel *model in dataList) {
            //selectedStatus
            for (CommonItemModel *itemModel in model.itemList) {
                [itemModel setSelected:NO];
            }
            //selectedItem
            model.selectedItemList = nil;
            _tnCreTime = @"";
            _tnModtime = @"";
            _classOne = @"";
            _tsSiteType = @"";
            _tsType = @"";
        }
    }commitBlock:^(NSArray *dataList) {
        
        //Common Region
        ZYSideSlipFilterRegionModel *firstRegionModel = dataList[0];
        if (firstRegionModel.selectedItemList.count == 0) {
            _tsType = @"";
        }else{
            for (CommonItemModel *commonModel in firstRegionModel.selectedItemList) {
                _tsType = commonModel.itemId;
            }
        }
        ZYSideSlipFilterRegionModel *secondRegionModel = dataList[1];
        if (secondRegionModel.selectedItemList == 0) {
            _classOne = @"";
        }else{
            for (CommonItemModel *commonModel in secondRegionModel.selectedItemList) {
                _classOne = commonModel.itemId;
            }
        }
        ZYSideSlipFilterRegionModel *thirdRegionModel = dataList[3];
        if (thirdRegionModel.selectedItemList.count == 0) {
            _tsSiteType = @"";
        }else{
            for (CommonItemModel *commonModel in thirdRegionModel.selectedItemList) {
                _tsSiteType = commonModel.itemId;
            }
        }
      
        //时间区间
        ZYSideSlipFilterRegionModel *priceRegionModel = dataList[2];
        PriceRangeModel *priceRangeModel = [priceRegionModel.customDict objectForKey:PRICE_RANGE_MODEL];
        if (priceRangeModel) {
            if (priceRangeModel.firstTime) {
                _tnCreTime = priceRangeModel.firstTime;
            }
            if (priceRangeModel.secondTime) {
                _tnModtime = priceRangeModel.secondTime;
            }
        }
        //消失
        [weakSelf.filterController dismiss];
        _page = 1;
        [weakSelf requestData];
    }];
    _filterController.animationDuration = .3f;
    _filterController.sideSlipLeading = 0.15*[UIScreen mainScreen].bounds.size.width;
    _filterController.dataList = [self packageDataList];
}
#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"场次状态" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"产品类别" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self priceFilterRegionModel]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"场次类型" selectionType:BrandTableViewCellSelectionTypeSingle]];
    return [dataArray mutableCopy];
}

- (ZYSideSlipFilterRegionModel *)commonFilterRegionModelWithKeyword:(NSString *)keyword selectionType:(CommonTableViewCellSelectionType)selectionType {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipCommonTableViewCell";
    model.regionTitle = keyword;
    model.customDict = @{REGION_SELECTION_TYPE:@(selectionType)};
    
    if ([keyword isEqualToString:@"场次状态"]) {
        model.itemList = @[[self createItemModelWithTitle:@"正在进行" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"即将开始" itemId:@"1" selected:NO]
                           ];
    }
    if ([keyword isEqualToString:@"产品类别"]) {
        //查询类别id
        __weak typeof(self)weakSelf = self;
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetFirstListId] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [weakSelf.hud hide:YES];
            NSLog(@"查询的类别id结果是---%@",responseObject);
            int codeStr = [responseObject[@"code"]intValue];
            if (codeStr == 200) {
                NSArray *array = responseObject[@"object"];
                if (array.count > 0) {
                    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                    for (NSDictionary *temp in array) {
                        NSString *categoryName = (NSString*)temp[@"categoryName"];
                        NSString *proCategoryId = (NSString *)temp[@"proCategoryId"];
                        [dataArray addObject:[weakSelf createItemModelWithTitle:categoryName itemId:proCategoryId selected:NO]];
                        if (dataArray.count == array.count) {
                            //请求成功再弹出筛选界面
                            model.itemList = dataArray;
                            [weakSelf.filterController reloadData];

                        }
                    }
                }
               
                            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [weakSelf.hud hide:YES];
        }];
        
    }
    if ([keyword isEqualToString:@"场次类型"]) {
        model.itemList = @[[self createItemModelWithTitle:@"拼盘" itemId:@"1" selected:NO],
                           [self createItemModelWithTitle:@"单品" itemId:@"0" selected:NO]
                           ];
    }
    return model;
}
- (CommonItemModel *)createItemModelWithTitle:(NSString *)itemTitle
                                       itemId:(NSString *)itemId
                                     selected:(BOOL)selected {
    CommonItemModel *model = [[CommonItemModel alloc] init];
    model.itemId = itemId;
    model.itemName = itemTitle;
    model.selected = selected;
    return model;
}
- (ZYSideSlipFilterRegionModel *)priceFilterRegionModel {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipTimeTableViewCell";
    model.regionTitle = @"竞价开始时间";
    return model;
}
#pragma mark 筛选
-(void)shaixuan{
    NSLog(@"筛选按钮点击");
    [_filterController show];
}


#pragma mark - UI
-(void)setupTableView{
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    //self.myTableView.tableHeaderView = [self setupHeaderView];
    self.myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = [TradeNoticeTCell cellHeight];
    [self.view addSubview:self.myTableView];
    [self clearExtraLine:self.myTableView];

    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(newData)];
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
    if (self.navigationController.viewControllers.count > 1) {
        self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
        [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kSafeAreaTopHeight);
        }];
    }else{
        self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kSafeAreaTopHeight-kTabBarHeight);
        }];
    }
    
}
#pragma mark - Action
#pragma mark 下拉刷新
-(void)newData{
    self.page = 1;
    [self requestData];
}
#pragma mark 上拉加载
-(void)moreData{
    self.page ++;
    [self requestData];
}
#pragma mark 去掉多余的线
-(void)clearExtraLine:(UITableView *)tableView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.myTableView setTableFooterView:view];
}
#pragma mark 请求数据
-(void)requestData{
    
    //_hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.page];
    NSString *pageSize = @"15";
    NSString *status = @"0";
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:pageNum forKey:@"pageNum"];
    [dict setObject:pageSize forKey:@"pageSize"];
    [dict setObject:status forKey:@"status"];
    [dict setObject:_tnCreTime forKey:@"tnCreTime"];
    [dict setObject:_tnModtime forKey:@"tnModtime"];
    [dict setObject:_classOne forKey:@"classOne"];
    [dict setObject:_tsSiteType forKey:@"tsSiteType"];
    [dict setObject:_tsType forKey:@"tsType"];
    
    NSLog(@"---参数----\n%@",dict);
    
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 8.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:[myBaseUrl stringByAppendingString:kPath_TradeNoticeList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[weakSelf.hud hide:YES];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
        
        if (weakSelf.page ==1) {
            [weakSelf.dataSourceArray removeAllObjects];
            
        }
        NSArray *array = (NSArray *)responseObject[@"object"];
        if (array.count== 0) {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.dataSourceArray addObjectsFromArray:[TradeNoticeModel arrayOfModelsFromDictionaries:array error:nil]];
        }
        [weakSelf.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         //[weakSelf.hud hide:YES];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradeNoticeTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (!cell) {
        
        cell = [[TradeNoticeTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    TradeNoticeModel *model = self.dataSourceArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TradeNoticeModel *model = self.dataSourceArray[indexPath.row];
//    JingJiaDetailViewController *vc = [[JingJiaDetailViewController alloc]init];
//    vc.tnId = model.tnId;
//    [self.navigationController pushViewController:vc animated:YES];
    X_JingJiaDetailViewController *vc = [[X_JingJiaDetailViewController alloc]init];
    vc.tnId = model.tnId;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom-0.5, topView.width, 0.5)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [topView addSubview:line];
    
    
    UIButton *conditionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    conditionBtn.frame = CGRectMake(S_W-30-40, 10, 40, 20);
    [conditionBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [conditionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    conditionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:conditionBtn];
    
    [conditionBtn addTarget:self action:@selector(shaixuan) forControlEvents:UIControlEventTouchUpInside];
    
    return topView;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
@end
