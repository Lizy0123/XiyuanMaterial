//
//  MyBiddingViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyBiddingViewController.h"
#import "MyBiddingListViewController.h"
#import "ProductCategoryViewController.h"
#import "SearchViewController.h"


#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterRegionModel.h"
#import "CommonItemModel.h"
#import "AddressModel.h"
#import "PriceRangeModel.h"
#import "SideSlipCommonTableViewCell.h"

@interface MyBiddingViewController ()
/*分段控制器的下标标识符*/
@property (nonatomic,assign) NSInteger *page;
@property(strong, nonatomic)MyBiddingListViewController *myInfoVC;
@property(strong, nonatomic)MyBiddingListViewController *myAddressVC;
@property(strong, nonatomic)NSDictionary *filterDic;
//筛选界面
@property (strong, nonatomic) ZYSideSlipFilterController *filterController;

@end

@implementation MyBiddingViewController
-(void)configFilter{
    __weak typeof(self)weakSelf = self;
    self.filterController = [[ZYSideSlipFilterController alloc] initWithSponsor:self resetBlock:^(NSArray *dataList) {
        for (ZYSideSlipFilterRegionModel *model in dataList) {
            //selectedStatus
            for (CommonItemModel *itemModel in model.itemList) {
                [itemModel setSelected:NO];
            }

            NSDictionary *dict = @{@"key":@"清空筛选"};
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kStrShowFilter object:nil userInfo:dict]];
            
            //selectedItem
            model.selectedItemList = nil;
            //            _tnCreTime = @"";
            //            _tnModtime = @"";
            //            _classOne = @"";
            //            _tsSiteType = @"";
            //            _tsType = @"";
        }
    }commitBlock:^(NSArray *dataList) {
        NSDictionary *dic = @{
                              @"产品分类":@"产品分类内容",
                              @"竞价时间":@"竞价时间内容",
                              @"场次状态":@"场次状态内容",
                              @"关键字":@"关键字内容",
                              };
        NSDictionary *dict = @{@"key":dic};
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kStrShowFilter object:nil userInfo:dict]];
        
        //Common Region
        ZYSideSlipFilterRegionModel *firstRegionModel = dataList[0];
        if (firstRegionModel.selectedItemList.count == 0) {
            //            _tsType = @"";
        }else{
            for (CommonItemModel *commonModel in firstRegionModel.selectedItemList) {
                //                _tsType = commonModel.itemId;
            }
        }
        ZYSideSlipFilterRegionModel *secondRegionModel = dataList[1];
        if (secondRegionModel.selectedItemList == 0) {
            //            _classOne = @"";
        }else{
            for (CommonItemModel *commonModel in secondRegionModel.selectedItemList) {
                //                _classOne = commonModel.itemId;
            }
        }
        ZYSideSlipFilterRegionModel *thirdRegionModel = dataList[3];
        if (thirdRegionModel.selectedItemList.count == 0) {
            //            _tsSiteType = @"";
        }else{
            for (CommonItemModel *commonModel in thirdRegionModel.selectedItemList) {
                //                _tsSiteType = commonModel.itemId;
            }
        }
        
        //时间区间
        ZYSideSlipFilterRegionModel *priceRegionModel = dataList[2];
        PriceRangeModel *priceRangeModel = [priceRegionModel.customDict objectForKey:PRICE_RANGE_MODEL];
        if (priceRangeModel) {
            if (priceRangeModel.firstTime) {
                //                _tnCreTime = priceRangeModel.firstTime;
            }
            if (priceRangeModel.secondTime) {
                //                _tnModtime = priceRangeModel.secondTime;
            }
        }
        //消失
        [weakSelf.filterController dismiss];
        //        _page = 1;
        //        [weakSelf requestData];
    }];
    _filterController.animationDuration = .3f;
    _filterController.sideSlipLeading = 0.15*[UIScreen mainScreen].bounds.size.width;
    _filterController.dataList = [self packageDataList];
}
#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"产品分类(可选)" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"场次状态(可选)" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"关键字(可选)" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self priceFilterRegionModel]];
    return [dataArray mutableCopy];
}

- (ZYSideSlipFilterRegionModel *)commonFilterRegionModelWithKeyword:(NSString *)keyword selectionType:(CommonTableViewCellSelectionType)selectionType {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipCommonTableViewCell";
    model.regionTitle = keyword;
    model.customDict = @{REGION_SELECTION_TYPE:@(selectionType)};
    

//    if ([keyword isEqualToString:@"产品分类(可选)"]) {
//        //查询类别id
//        __weak typeof(self)weakSelf = self;
//        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetFirstListId] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            //            [weakSelf.hud hide:YES];
//            NSLog(@"查询的类别id结果是---%@",responseObject);
//            int codeStr = [responseObject[@"code"]intValue];
//            if (codeStr == 200) {
//                NSArray *array = responseObject[@"object"];
//                if (array.count > 0) {
//                    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
//                    for (NSDictionary *temp in array) {
//                        NSString *categoryName = (NSString*)temp[@"categoryName"];
//                        NSString *proCategoryId = (NSString *)temp[@"proCategoryId"];
//                        [dataArray addObject:[weakSelf createItemModelWithTitle:categoryName itemId:proCategoryId selected:NO]];
//                        if (dataArray.count == array.count) {
//                            //请求成功再弹出筛选界面
//                            model.itemList = dataArray;
//                            [weakSelf.filterController reloadData];
//
//                        }
//                    }
//                }
//
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            //            [weakSelf.hud hide:YES];
//        }];
//
//    }
    if ([keyword isEqualToString:@"产品分类(可选)"]) {
        model.itemList = @[
                           [self createItemModelWithTitle:@"工程设备" itemId:@"0" selected:[self.filterDic objectForKey:@"产品分类"]],
                           [self createItemModelWithTitle:@"冶金设备" itemId:@"1" selected:NO],
                           [self createItemModelWithTitle:@"电气设备" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"提升设备" itemId:@"1" selected:NO],
                           [self createItemModelWithTitle:@"安防设备" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"除尘通风" itemId:@"1" selected:NO],
                           [self createItemModelWithTitle:@"输送设备" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"给料设备" itemId:@"1" selected:NO],
                           [self createItemModelWithTitle:@"动力设备" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"办公设备" itemId:@"1" selected:NO],
                           [self createItemModelWithTitle:@"勘探设备" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"采掘设备" itemId:@"1" selected:NO],
                           [self createItemModelWithTitle:@"选矿设备" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"其它设备" itemId:@"1" selected:NO],
//                           [self createItemModelWithTitle:@"输送设备" itemId:@"0" selected:NO],
//                           [self createItemModelWithTitle:@"给料设备" itemId:@"1" selected:NO],
                           
                           
                           ];
    }
    if ([keyword isEqualToString:@"场次状态(可选)"]) {
        model.itemList = @[[self createItemModelWithTitle:@"正在进行" itemId:@"0" selected:NO],
                           [self createItemModelWithTitle:@"即将开始" itemId:@"1" selected:NO]
                           ];
    }
    if ([keyword isEqualToString:@"关键字(可选)"]) {
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
    model.regionTitle = @"竞价时间(可选)";
    return model;
}
#pragma mark -----

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"竞价专区";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showFilter:) name:kStrSaveFilterDic object:nil];
    
     [self configFilter];
    
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backItemImage_hl"] style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemLeft)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemRight)];
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backItemImage_hl"] style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemRight)];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    
    
    //分段控制器
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"单场竞价",@"专场竞价"]];
    segment.frame = CGRectMake(0, 0, 60, 30);
    segment.tintColor = UIColor.whiteColor;
    segment.selectedSegmentIndex = 0;
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    [segment addTarget:self action:@selector(segmentChangePage:) forControlEvents:UIControlEventValueChanged];
    //    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = segment;
    
    
    //创建控制器的对象
    _myInfoVC = [[MyBiddingListViewController alloc] init];
    _myInfoVC.titleStr = @"单场竞价";
    _myInfoVC.isShowFilter = NO;
    _myInfoVC.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    _myAddressVC = [[MyBiddingListViewController alloc] init];
    _myAddressVC.titleStr = @"专场竞价";
    _myAddressVC.isShowFilter = NO;
    _myAddressVC.view.backgroundColor = UIColor.groupTableViewBackgroundColor;

    [self.view addSubview:_myInfoVC.view];    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kStrSaveFilterDic object:self];
}
//实现监听方法
-(void)showFilter:(NSNotification *)notification{
    NSString *loadPathStr = notification.userInfo[@"key"];
    NSLog(@"filter had show! %@", loadPathStr);
    if ([notification.userInfo[@"key"] isKindOfClass:[NSDictionary class]]) {
        NSLog(@"有筛选的数据");
        self.filterDic = notification.userInfo[@"key"];
    }else{
        NSLog(@"这里并没有什么有用的筛选数据");
    }
}


-(void)actionNavigationItemLeft{
    [self.navigationController pushViewController:[ProductCategoryViewController new] animated:YES];

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
-(void)segmentChangePage :(UISegmentedControl *)sec;{
    NSInteger index = sec.selectedSegmentIndex;
    if (index == 0) {
        //第一个界面
        [self.view addSubview:_myInfoVC.view];
        [_myAddressVC.view removeFromSuperview];
    }else{

        [self.view addSubview:_myAddressVC.view];
        [_myInfoVC.view removeFromSuperview];
    }
}

@end
