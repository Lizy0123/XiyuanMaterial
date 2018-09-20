//
//  ChengJiaoAnLiViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/19.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "ChengJiaoAnLiViewController.h"
#import "ChengJiaoAnLiModel.h"
#import "ChengJiaoAnLiTCell.h"
#import "XRChengJiaoDetailViewController.h"

#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterRegionModel.h"
#import "CommonItemModel.h"
#import "AddressModel.h"
#import "PriceRangeModel.h"
#import "SideSlipCommonTableViewCell.h"

@interface ChengJiaoAnLiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
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
//筛选界面
@property (strong, nonatomic) ZYSideSlipFilterController *filterController;
@end

@implementation ChengJiaoAnLiViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemRight)];
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backItemImage_hl"] style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemRight)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    //导航以下是(0,0)
    self.page = 1;
    _tnCreTime = @"";
    _tnModtime = @"";
    _classOne = @"";
    _tsSiteType = @"";
    _tnUserType = @"";
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self serveData];
    [self setupFiltView];
}
-(void)actionNavigationItemRight{
    [_filterController show];
    
    //    //发送通知
    //    NSDictionary *dict = @{@"key":@"value"};
    //    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"kStrShowFilter" object:nil userInfo:dict]];
    
    //    SearchViewController *searchVC = [[SearchViewController alloc] init];
    //    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:searchVC];
    //    nav.navigationBar.tintColor = [UIColor whiteColor];
    //    [self presentViewController:nav animated:YES completion:nil];
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
            _tnUserType = @"";
        }
    }commitBlock:^(NSArray *dataList) {
        
        //Common Region
        ZYSideSlipFilterRegionModel *firstRegionModel = dataList[0];
        if (firstRegionModel.selectedItemList.count == 0) {
            _tsType = @"";
        }else{
            for (CommonItemModel *commonModel in firstRegionModel.selectedItemList) {
                _tnUserType = commonModel.itemId;
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
        weakSelf.page = 1;
        [weakSelf serveData];
    }];
    _filterController.animationDuration = .3f;
    _filterController.sideSlipLeading = 0.15*[UIScreen mainScreen].bounds.size.width;
    _filterController.dataList = [self packageDataList];
}
#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"买方资格" selectionType:BrandTableViewCellSelectionTypeSingle]];
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
    
    if ([keyword isEqualToString:@"买方资格"]) {
        model.itemList = @[[self createItemModelWithTitle:@"企业" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"个人" itemId:@"1" selected:NO]
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
    model.regionTitle = @"成交时间";
    return model;
}
#pragma mark 筛选
-(void)shaixuan{
    NSLog(@"筛选按钮点击");
    [_filterController show];
}

#pragma mark - Action
#pragma mark 请求数据
-(void)serveData{
    
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.mode = MBProgressHUDModeIndeterminate;
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.page];
    NSString *pageSize = @"15";
    NSString *status = @"1";
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:pageNum forKey:@"pageNum"];
    [dict setObject:pageSize forKey:@"pageSize"];
    [dict setObject:status forKey:@"status"];
    [dict setObject:_tnCreTime forKey:@"tnCreTime"];
    [dict setObject:_tnModtime forKey:@"tnModtime"];
    [dict setObject:_classOne forKey:@"classOne"];
    [dict setObject:_tsSiteType forKey:@"tsSiteType"];
    [dict setObject:_tnUserType forKey:@"tnUserType"];
    NSLog(@"成交案例参数---%@",dict);
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_TradeNoticeList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
        //[hud hide:YES];
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            if (weakSelf.page == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            NSArray *array = (NSArray *)responseObject[@"object"];
            if (array.count== 0) {
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.dataArray addObjectsFromArray:[ChengJiaoAnLiModel arrayOfModelsFromDictionaries:array error:nil]];
            }
        }
        [weakSelf.myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
    }];
}
#pragma mark - TableView
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.sectionIndexBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.showsVerticalScrollIndicator = NO;
            tableView.allowsMultipleSelectionDuringEditing = YES;
            
            tableView.rowHeight = [ChengJiaoAnLiTCell cellHeight];
            tableView.tableFooterView = [[UIView alloc]init];
            
            //            tableView.tableHeaderView = [self tableHeader];
            //            tableView.tableFooterView = [self tableFooterView];
            //        [tableView registerClass:[CountryCodeCell class] forCellReuseIdentifier:kCellIdentifier_CountryCodeCell];
            
            __weak typeof(self)weakSelf = self;
            tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                weakSelf.page = 1;
                [weakSelf serveData];
            }];
            tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                weakSelf.page ++;
                [weakSelf serveData];
            }];
            
            
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight+60, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            tableView;
        });
    }return _myTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChengJiaoAnLiTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ChengJiaoAnLiTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = self.dataArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChengJiaoAnLiModel *model = self.dataArray[indexPath.row];
    XRChengJiaoDetailViewController *vc = [[XRChengJiaoDetailViewController alloc]init];
    vc.tnId = model.tnId;
    if (model.tsName) {
        vc.navigationItem.title = model.tsName;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
//    topView.backgroundColor = [UIColor whiteColor];
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom-0.5, topView.width, 0.5)];
//    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [topView addSubview:line];
//
//
//    UIButton *conditionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    conditionBtn.frame = CGRectMake(S_W-30-40, 10, 40, 20);
//    [conditionBtn setTitle:@"筛选" forState:UIControlStateNormal];
//    [conditionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    conditionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [topView addSubview:conditionBtn];
//
//    [conditionBtn addTarget:self action:@selector(shaixuan) forControlEvents:UIControlEventTouchUpInside];
//
//    return topView;
//
//}
@end
