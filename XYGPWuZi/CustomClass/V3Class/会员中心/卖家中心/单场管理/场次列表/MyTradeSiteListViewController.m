//
//  MyTradeSiteListViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyTradeSiteListViewController.h"
#import "MyTradeSiteListTCell.h"
#import "AddBiddingModel.h"
#import "AddBiddingSingleViewController.h"
#import "AddBiddingTradeSiteViewController.h"

#import "TradeSiteResultViewController.h"
#import "ChuJiaJiLuViewController.h"
#import "JingJiaDetailViewController.h"
#import "X_JingJiaDetailViewController.h"

@interface MyTradeSiteListViewController ()<UITableViewDelegate, UITableViewDataSource, MyTradeSiteListTCellDelegate>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;

@property (nonatomic,assign)__block int page;

@end

static NSString * const cellIdentifier = @"cellIdentifier";


@implementation MyTradeSiteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    [self configMyTableView];
    [self serveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = NO;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];

    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
    __weak typeof(self)weakSelf = self;
    self.myTableView.mj_header  = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf serveData];
        
    }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf serveData];
    }];
}

#pragma mark - Action
-(void)serveData{
    if (!self.dataSourceArray) {
        self.dataSourceArray = [NSMutableArray new];
    }
    NSString *page = [NSString stringWithFormat:@"%d",self.page];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:page forKey:@"pageNum"];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    [dict setObject:[self configProcessStatus] forKey:@"tsProcess"];

    __weak typeof(self)weakself = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetTradeSiteList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据：%@",responseObject);
        [weakself.myTableView.mj_header endRefreshing];
        [weakself.myTableView.mj_footer endRefreshing];

        if (weakself.page == 1) {
            [weakself.dataSourceArray removeAllObjects];
        }
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            NSArray *array = responseObject[@"object"];
            if (array.count== 0) {
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.dataSourceArray addObjectsFromArray:[AddBiddingModel arrayOfModelsFromDictionaries:array error:nil]];
            }
        }

        [weakself.myTableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself.myTableView.mj_header endRefreshing];
        [weakself.myTableView.mj_footer endRefreshing];

    }];
}

-(void)serveBiddingMWithAddBiddingM:(AddBiddingModel *)addBiddingM withViewController:(UIViewController *)vc{
    [NSObject HUDActivityShowStr:nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    [dict setObject:addBiddingM.tsId forKey:@"tsId"];
    
    __weak typeof(self)weakself = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_FindTradeSiteForUpdate] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NSObject HUDActivityHide];
        int codeStr = [responseObject[@"code"]intValue];
        if (codeStr == 200) {
            NSDictionary *dic = responseObject[@"object"];
            NSLog(@"内容：%@",dic);
            AddBiddingModel *model = [[AddBiddingModel alloc] initWithDictionary:dic error:nil];
            if ([addBiddingM.tsSiteType isEqualToString:@"0"]) {
                ((AddBiddingSingleViewController *)vc).addBiddingM = model;
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if ([addBiddingM.tsSiteType isEqualToString:@"1"]){
                ((AddBiddingTradeSiteViewController *)vc).addBiddingM = model;
                ((AddBiddingTradeSiteViewController *)vc).productListArray = [NSMutableArray arrayWithArray:model.productList];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject HUDActivityHide];
        [NSObject ToastShowStr:@"加载数据失败！"];
    }];
}
-(void)serveDelTradeSite:(AddBiddingModel *)addBiddingM{
    [NSObject HUDActivityShowStr:nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    [dict setObject:addBiddingM.tsId forKey:@"tsId"];
    
    __weak typeof(self)weakself = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_DeleteTradeSite] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NSObject HUDActivityHide];

        if ([responseObject[@"code"]intValue] == 200) {
            [NSObject ToastShowStr:@"删除成功！"];
            [weakself.dataSourceArray removeObject:addBiddingM];
            [weakself.myTableView reloadData];
        }else{
            [NSObject ToastShowStr:@"删除失败！"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject HUDActivityHide];
    }];
}
-(NSString *)configProcessStatus{
    NSString *tsProcess = @"";
    if (self.myTradeSiteStatus ==kMyTradeSiteStatus_WaitPublic) {
        tsProcess = @"0";
    }
    else if (self.myTradeSiteStatus ==kMyTradeSiteStatus_PublicSuccess){
        tsProcess = @"1";
    }
    else if (self.myTradeSiteStatus ==kMyTradeSiteStatus_BiddingNow){
        tsProcess = @"2";
    }
    else if (self.myTradeSiteStatus ==kMyTradeSiteStatus_WaitReciveMoney){
        tsProcess = @"3";
    }
    else if (self.myTradeSiteStatus ==kMyTradeSiteStatus_WaitReciveProduct){
        tsProcess = @"4";
    }
    else if (self.myTradeSiteStatus ==kMyTradeSiteStatus_BiddingSuccess){
        tsProcess = @"5";
    }
    else if (self.myTradeSiteStatus ==kMyTradeSiteStatus_Failure){
        tsProcess = @"6";
    }
    else{
        tsProcess = @"1";
    }
    return tsProcess;
}
-(void)btnOnCell:(MyTradeSiteListTCell *)cell tag:(NSInteger)tag{
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    AddBiddingModel *addBiddingM = [self.dataSourceArray objectAtIndex:indexPath.row];

    switch (cell.myTradeSiteStatus) {
        case kMyTradeSiteStatus_WaitPublic:
        {
            if (tag == 101232) {//编辑
                //编辑
                if ([addBiddingM.tsSiteType isEqualToString:@"0"]) {
                    //单品竞价
                    AddBiddingSingleViewController *vc = [AddBiddingSingleViewController new];
                    vc.isEdit = YES;
                    [self serveBiddingMWithAddBiddingM:addBiddingM withViewController:vc];
                }else if ([addBiddingM.tsSiteType isEqualToString:@"1"]){
                    //拼盘竞价
                    AddBiddingTradeSiteViewController *vc = [AddBiddingTradeSiteViewController new];
                    vc.isEdit = YES;
                    [self serveBiddingMWithAddBiddingM:addBiddingM withViewController:vc];

                }
            }else if (tag == 101230){//删除
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"删除确认" message:@"确定删除吗？删除后不可恢复" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { [self serveDelTradeSite:addBiddingM]; }];
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {  }];
                
                [alert addAction:defaultAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
            break;
        case kMyTradeSiteStatus_PublicSuccess:
        {//暂无按钮
            
        }
            break;
        case kMyTradeSiteStatus_BiddingNow:
        {
            if (tag == 101232) {//编辑
                
            }else if (tag == 101233){//left
                
            }else if (tag == 101234){//right
                //查看出价
                [self goToBiddingRecordVC:addBiddingM];

            }
        }
            break;
        case kMyTradeSiteStatus_WaitReciveMoney:
        {
            if (tag == 101232) {//编辑
                
            }else if (tag == 101233){//left
                //查看出价
                [self goToBiddingRecordVC:addBiddingM];

            }else if (tag == 101234){//right
                //成交结果
                [self goToTradeSiteResultVC:addBiddingM];

            }
        }
            break;
        case kMyTradeSiteStatus_WaitReciveProduct:
        {
            if (tag == 101232) {//编辑
                
            }else if (tag == 101233){//left
                //查看出价
                [self goToBiddingRecordVC:addBiddingM];
            }else if (tag == 101234){//right
                //成交结果
                [self goToTradeSiteResultVC:addBiddingM];

            }
        }
            break;
        case kMyTradeSiteStatus_BiddingSuccess:
        {
            if (tag == 101232) {//编辑
                
            }else if (tag == 101233){//left
                
            }else if (tag == 101234){//right
                //成交结果
                [self goToTradeSiteResultVC:addBiddingM];

            }
        }
            break;
        case kMyTradeSiteStatus_Failure:
        {
            if (tag == 101232) {//编辑
                
            }else if (tag == 101233){//left
                
            }else if (tag == 101234){//right
                //成交结果
                [self goToTradeSiteResultVC:addBiddingM];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)goToTradeSiteResultVC:(AddBiddingModel *)addBiddingM{
    TradeSiteResultViewController *vc = [TradeSiteResultViewController new];
    vc.addBiddingM = addBiddingM;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goToBiddingRecordVC:(AddBiddingModel *)addBiddingM{
    ChuJiaJiLuViewController *vc = [ChuJiaJiLuViewController new];
    vc.addBiddingM = addBiddingM;
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myTradeSiteStatus ==kMyTradeSiteStatus_PublicSuccess){
        return [MyTradeSiteListTCell cellHeight] -30;
    }
    else if (self.myTradeSiteStatus ==kMyTradeSiteStatus_Failure){
        return [MyTradeSiteListTCell cellHeight] -30;
    }
    else{
        return [MyTradeSiteListTCell cellHeight];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTradeSiteListTCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MyTradeSiteListTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.myTradeSiteStatus = self.myTradeSiteStatus;
    cell.biddingProductM = self.dataSourceArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddBiddingModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];

    if ([NSObject isString:model.tnId]) {
//        JingJiaDetailViewController *vc = [JingJiaDetailViewController new];
//        vc.isShowBottomView = NO;
//        vc.tnId = model.tnId;
//        [self.navigationController pushViewController:vc animated:YES];
        X_JingJiaDetailViewController *vc = [[X_JingJiaDetailViewController alloc]init];
        vc.tnId = model.tnId;
        vc.isShowBottomView = NO;

        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
