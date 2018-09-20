//
//  Record_JiaoyiLiushuiViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/14.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Record_JiaoyiLiushuiViewController.h"
//Filter
#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterConfig.h"
//#import "ZYSideSlipFilterRegionModel.h"
#import "CommonItemModel.h"
#import "AddressModel.h"
#import "PriceRangeModel.h"
#import "SideSlipCommonTableViewCell.h"
#import "ChhuJiaJiLuTCell.h"
#import "Api_tradingRecordList.h"
#import "Record_JiaoyiliushuiDetailViewController.h"


@interface Record_JiaoyiLiushuiViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataSourceArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)int page;
@property (nonatomic, strong) UITextField *textField;
#pragma mark - Filter
@property (strong, nonatomic) ZYSideSlipFilterController *filterController;
@property(strong, nonatomic)Model_TradingRecord *tradingRecordM;
@property(strong, nonatomic)Model_RecordResponse *recordResponseM;

@end

@implementation Record_JiaoyiLiushuiViewController

-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] init];
    }
    return _dataSourceArray;
}
-(Model_TradingRecord *)tradingRecordM{
    if (!_tradingRecordM) {
        _tradingRecordM = [[Model_TradingRecord alloc] init];
//        _tradingRecordM.trType = @"1";
        _tradingRecordM.page = @"1";
        _tradingRecordM.limit = @"1000";
    }return _tradingRecordM;
}
-(Model_RecordResponse *)recordResponseM{
    if (!_recordResponseM) {
        _recordResponseM = [Model_RecordResponse new];
    }return _recordResponseM;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
    }return _tableView;
}

-(void)resetData{
    self.tradingRecordM = nil;
//    [self serveData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"交易流水"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetData) name:FILTER_NOTIFICATION_NAME_DID_RESET_DATA object:nil];

    
    UIBarButtonItem *nextStepBtn = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(actionFilter)];
    self.navigationItem.rightBarButtonItem = nextStepBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self configFilter];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self serveData];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)serveData{
    Api_tradingRecordList *api = [[Api_tradingRecordList alloc] initWithTradingRecordM:self.tradingRecordM];
    api.animatingText = @"正在获取数据...";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject[@"code"] integerValue] == 0) {
             self.recordResponseM = [[Model_RecordResponse alloc] initWithDictionary:request.responseJSONObject[@"object"] error:nil];
            self.dataSourceArray = [NSMutableArray arrayWithArray:self.recordResponseM.jsonList];
            [self.tableView reloadData];
        }
        
        NSLog(@"succeed");
        
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    }];
}




//configFilter
#pragma mark - Filter
-(void)configFilter{
    self.filterController = [[ZYSideSlipFilterController alloc]
                             initWithSponsor:self
                                 resetBlock:^(NSArray *dataList) {
                                     for (ZYSideSlipFilterRegionModel *model in dataList) {
                                         //selectedStatus
                                         for (CommonItemModel *itemModel in model.itemList) {
                                             [itemModel setSelected:NO];
                                         }
                                         //selectedItem
                                         model.selectedItemList = nil;
                                     }
                                 }
                             commitBlock:^(NSArray *dataList) {
                                 //发生时间
                                 ZYSideSlipFilterRegionModel *priceRegionModel = dataList[0];
                                 PriceRangeModel *priceRangeModel = [priceRegionModel.customDict objectForKey:PRICE_RANGE_MODEL];
                                 NSMutableString *priceRangeString = [NSMutableString stringWithString:@"\n发生时间: "];
                                 if (priceRangeModel) {
                                     [priceRangeString appendFormat:@"%@ - %@", priceRangeModel.firstTime, priceRangeModel.secondTime];
                                 }
                                 NSLog(@"发生时间%@", priceRangeString);
                                 if ([NSObject isString:priceRangeModel.firstTime]) {
                                     self.tradingRecordM.begin = [NSString stringWithFormat:@"%@%@",priceRangeModel.firstTime,@" 00:00:00"];
                                 }else{
                                     self.tradingRecordM.begin = priceRangeModel.firstTime;
                                 }
                                 if ([NSObject isString:priceRangeModel.secondTime]) {
                                     self.tradingRecordM.end = [NSString stringWithFormat:@"%@%@",priceRangeModel.secondTime,@" 00:00:00"];
                                 }else{
                                     self.tradingRecordM.end = priceRangeModel.secondTime;
                                 }
                                 
                                 //业务类型
                                 NSMutableString *commonRegionString = [NSMutableString string];
//                                 for (int i = 1; i < dataList.count; i ++) {
                                     ZYSideSlipFilterRegionModel *commonRegionModel = dataList[1];
                                     [commonRegionString appendFormat:@"\n%@:", commonRegionModel.regionTitle];
                                     NSMutableArray *commonItemSelectedArray = [NSMutableArray array];
                                     for (CommonItemModel *itemModel in commonRegionModel.itemList) {
                                         if (itemModel.selected) {
                                             [commonItemSelectedArray addObject:[NSString stringWithFormat:@"%@-%@", itemModel.itemId, itemModel.itemName]];
                                             self.tradingRecordM.trType = itemModel.itemId;

                                         }
                                     }
                                     [commonRegionString appendString:[commonItemSelectedArray componentsJoinedByString:@", "]];
//                                 }
                                 NSLog(@"业务类型%@", commonRegionString);
                                 
                                 //关键字
                                 ZYSideSlipFilterRegionModel *serviceRegionModel = dataList[2];
                                 PriceRangeModel *prceRangeModel = [serviceRegionModel.customDict objectForKey:PRICE_RANGE_MODEL];
                                 NSLog(@"关键字%@", prceRangeModel.keyWord);
                                 self.tradingRecordM.trObj = prceRangeModel.keyWord;
                                 [self serveData];
                                 [self.filterController dismiss];
                                 }];
    _filterController.animationDuration = .3f;
    _filterController.sideSlipLeading = 0.15*[UIScreen mainScreen].bounds.size.width;
    _filterController.dataList = [self packageDataList];
}
#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self timeFilterRegionModel]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"业务类型" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self keywordFilterRegionModel]];
    return [dataArray mutableCopy];
}

- (ZYSideSlipFilterRegionModel *)commonFilterRegionModelWithKeyword:(NSString *)keyword selectionType:(CommonTableViewCellSelectionType)selectionType {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipCommonTableViewCell";
    model.regionTitle = keyword;
    model.customDict = @{REGION_SELECTION_TYPE:@(selectionType)};
    model.itemList = @[[self createItemModelWithTitle:[NSString stringWithFormat:@"%@支付保证金", @""] itemId:@"1" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@返还保证金", @""] itemId:@"2" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@支付货款", @""] itemId:@"3" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@支付服务费", @""] itemId:@"6" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@出金", @""] itemId:@"4" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@入金", @""] itemId:@"5" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@竞拍收款", @""] itemId:@"7" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@赔付保证金", @""] itemId:@"8" selected:NO],
//                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@竞拍收款", @""] itemId:@"7" selected:NO],
//                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@赔付保证金", @""] itemId:@"8" selected:NO],
                       
                       ];
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


- (ZYSideSlipFilterRegionModel *)timeFilterRegionModel {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipTimeTableViewCell";
    model.regionTitle = @"发生时间";
    return model;
}


- (ZYSideSlipFilterRegionModel *)keywordFilterRegionModel {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipPriceTableViewCell";
    return model;
}

//configFilter
-(void)actionSearchKeyWordBtn{
    
}
-(void)actionFilter{
    [_filterController show];
}










#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return self.dataSourceArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFLOAT_MIN;
    }else{
        return [ChhuJiaJiLuTCell cellHeight];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else{
        return CGFLOAT_MIN;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    if (section == 0) {
        view.frame = CGRectMake(0, 0, kScreen_Width, [self tableView:tableView heightForHeaderInSection:section]);
        UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreen_Width, [self tableView:tableView heightForHeaderInSection:section])];
        labe.text = [NSString stringWithFormat:@"收入总额：%@  支出总额：%@",[NSObject moneyStyle:self.recordResponseM.getMoney],[NSObject moneyStyle:self.recordResponseM.payMoney]];
        [view addSubview:labe];
    }
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChhuJiaJiLuTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordTCell"];
    if (cell == nil) {
        cell = [[ChhuJiaJiLuTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecordTCell"];
    }
    RecordJiaoyiModel *model = [[RecordJiaoyiModel alloc]init];
    Model_TradingRecord *tradingRecordM = [self.dataSourceArray objectAtIndex:indexPath.row];
    model.bidNo = tradingRecordM.trType;
    model.tspMoney = tradingRecordM.trMoney;
    model.tspBuyTime = tradingRecordM.tradTime;

    cell.recordJiaoyiM = model;
    //    cell.model = self.dataSourceArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Model_TradingRecord *tradingRecordM = [self.dataSourceArray objectAtIndex:indexPath.row];
    Record_JiaoyiliushuiDetailViewController *vc = [[Record_JiaoyiliushuiDetailViewController alloc] init];
    vc.tradingRecordM = tradingRecordM;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
