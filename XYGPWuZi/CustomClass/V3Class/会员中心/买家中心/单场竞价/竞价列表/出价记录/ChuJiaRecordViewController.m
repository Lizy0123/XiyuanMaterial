//
//  ChuJiaRecordViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/12/25.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "ChuJiaRecordViewController.h"
#import "ChhuJiaJiLuTCell.h"
#import "ChuJiaJiLuModel.h"

@interface ChuJiaRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIView *headerView;
@end

@implementation ChuJiaRecordViewController
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出价记录";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTableView];
    [self requestData];
}

#pragma mark - UI
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.rowHeight = [ChhuJiaJiLuTCell cellHeight];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;

    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
    __weak typeof(self)weakSelf = self;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}
#pragma mark headView
-(void)setUpHeadView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    self.myTableView.tableHeaderView = self.headerView;
    
    if (self.dataArray) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, 10, S_W-2*kMyPadding, 20)];
        label.text = [NSString stringWithFormat:@"出价记录（%ld次)",self.dataArray.count];
        [headerView addSubview:label];
    }
  
}
#pragma mark - Action
#pragma mark 请求数据
-(void)requestData{
    
    NSLog(@"tsid是-----%@---",self.tsId);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.tsId forKey:@"id"];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetTradeSiteProcessList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"----记录---%@",responseObject);
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.dataArray removeAllObjects];
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            NSArray *array = (NSArray *)responseObject[@"object"];
            [weakSelf.dataArray addObjectsFromArray:(NSMutableArray *)[[[RecordDetailModel arrayOfModelsFromDictionaries:array error:nil] reverseObjectEnumerator] allObjects]];
        }
        [weakSelf.myTableView reloadData];
        [self setUpHeadView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.myTableView.mj_header endRefreshing];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChhuJiaJiLuTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ChhuJiaJiLuTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    RecordDetailModel *model = self.dataArray[indexPath.row];
    cell.recordDetailM = model;

    return cell;
}

@end
