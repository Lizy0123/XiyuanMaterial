//
//  XRChengJiaoAnLiViewController.m
//  XYGPWuZi
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "XRChengJiaoAnLiViewController.h"
#import "XRChengJiaoModel.h"
#import "XRChengJiaoTableViewCell.h"
#import "XRChengJiaoDetailViewController.h"

@interface XRChengJiaoAnLiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int page;

@end

@implementation XRChengJiaoAnLiViewController

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.page = 1;
    [self buildUI];
    [self serveData];
}
#pragma mark - UI
-(void)buildUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = [XRChengJiaoTableViewCell cellHeight];
    __weak typeof(self)weakSelf = self;
    tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf serveData];
    }];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf serveData];
    }];
    [self.view addSubview:tableView];
   
    if (self.navigationController.viewControllers.count > 1) {
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kSafeAreaTopHeight);
        }];
    }else{
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-kSafeAreaTopHeight-kTabBarHeight);
        }];
    }
    self.myTableView = tableView;
}
#pragma mark - 请求数据
-(void)serveData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    NSString *urll = [requestUrlHeader stringByAppendingString:jingJiaGongGao];
    NSString *pageNum = [NSString stringWithFormat:@"%d",self.page];
    NSString *pageSize = @"15";
    NSString *status = @"1";
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:pageNum forKey:@"pageNum"];
    [dict setObject:pageSize forKey:@"pageSize"];
    [dict setObject:status forKey:@"status"];
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urll parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
        
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            if (weakSelf.page == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            NSArray *array = (NSArray *)responseObject[@"object"];
            if (array.count == 0) {
                [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                for (NSDictionary *temp in array) {
                    XRChengJiaoModel *model = [XRChengJiaoModel analysisWithDic:temp];
                    [weakSelf.dataArray addObject:model];
                }
            }
        }
        [weakSelf.myTableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
    }];
}
#pragma mark - delegate/DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XRChengJiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[XRChengJiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = self.dataArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XRChengJiaoModel *model = self.dataArray[indexPath.row];
    XRChengJiaoDetailViewController *vc = [[XRChengJiaoDetailViewController alloc]init];
    vc.tnId = model.tnId;
    if (model.tsName) {
        vc.navigationItem.title = model.tsName;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
