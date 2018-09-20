//
//  JingJiaListViewController.m
//  XYGPWuZi
//
//  Created by apple on 2017/12/21.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "JingJiaListViewController.h"
#import "X_JJTableViewCell.h"
#import "X_JingJiaGongGaoModel.h"
#import "X_JingJiaDetailViewController.h"

@interface JingJiaListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;
//列表页码
@property(nonatomic,assign)int page;
//数据数组
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)MBProgressHUD *hud;
@end

@implementation JingJiaListViewController
-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self setupUI];
    [self requestData];

}
#pragma mark - UI
-(void)setupUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectZero];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.rowHeight = [X_JJTableViewCell cellHeight];
    [self.view addSubview:self.myTable];
    [self clearExtraLine:self.myTable];

    _myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(newData)];
    _myTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
 
    if (self.navigationController.viewControllers.count > 1) {
        self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
        [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kSafeAreaTopHeight);
        }];
    }else{
        self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.myTable setTableFooterView:view];
}
#pragma mark 请求数据
-(void)requestData{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urll = [requestUrlHeader stringByAppendingString:jingJiaGongGao];
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.page];
    NSString *pageSize = @"15";
    NSString *status = @"0";
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:pageNum forKey:@"pageNum"];
    [dict setObject:pageSize forKey:@"pageSize"];
    [dict setObject:status forKey:@"status"];
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urll parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.hud hide:YES];
        [weakSelf.myTable.mj_header endRefreshing];
        [weakSelf.myTable.mj_footer endRefreshing];
        if (weakSelf.page ==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        NSArray *dataArray = (NSArray*)responseObject[@"object"];
        if (dataArray.count == 0) {
            [weakSelf.myTable.mj_footer endRefreshingWithNoMoreData];
        }else{
            for (int i = 0; i<dataArray.count; i++) {
                X_JingJiaGongGaoModel *model = [[X_JingJiaGongGaoModel alloc]init];
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
            
        }
       
        [weakSelf.myTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.hud hide:YES];
        [weakSelf.myTable.mj_header endRefreshing];
        [weakSelf.myTable.mj_footer endRefreshing];
    }];   
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    X_JJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (!cell) {
        cell = [[X_JJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    X_JingJiaGongGaoModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    X_JingJiaGongGaoModel *model = self.dataArray[indexPath.row];
    X_JingJiaDetailViewController *vc = [[X_JingJiaDetailViewController alloc]init];
    vc.tnId = model.tnId;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
