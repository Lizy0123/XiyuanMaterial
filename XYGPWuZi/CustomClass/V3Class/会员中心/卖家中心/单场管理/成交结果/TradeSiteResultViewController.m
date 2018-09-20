//
//  TradeSiteResultViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "TradeSiteResultViewController.h"
#import "TitleValueTCell.h"
#import "MyResultModel.h"

@interface TradeSiteResultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)MyResultModel *tradeSiteM;

@end

@implementation TradeSiteResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"成交结果"];
    [self configMyTableView];
    [self serveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
    [tableView registerClass:[TitleValueTCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueTCell];

    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
}

#pragma mark - Action
-(void)serveData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.addBiddingM.tsId forKey:@"tsId"];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    [dict setObject:@"2" forKey:@"type"];//(0查询我的竞价成交结果1查询支付货款界面信息2我的场次成交结果)

    __weak typeof(self)weakself = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetTradeSiteDetailInBidList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据：%@",responseObject);
        self.tradeSiteM = [[MyResultModel alloc] initWithDictionary:responseObject[@"object"] error:nil];
        [weakself.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, kScreen_Width - kMyPadding *2, 30)];
//    [headerView addSubview:label];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleValueTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValueTCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setTitleStr:@"场次名称" valueStr:self.tradeSiteM.tsName];

        }else if (indexPath.row == 1){
            [cell setTitleStr:@"场次编号" valueStr:self.tradeSiteM.tsTradeNo];

        }else if (indexPath.row == 2){
            [cell setTitleStr:@"起拍价" valueStr:[NSObject moneyStyle:self.tradeSiteM.tsMinPrice]];

        }else if (indexPath.row == 3){
            [cell setTitleStr:@"出价次数" valueStr:[NSString stringWithFormat:@"%@次",self.tradeSiteM.bidCount]];

        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [cell setTitleStr:@"竞得方" valueStr:self.tradeSiteM.buyUsername];
            
        }else if (indexPath.row == 1){
            [cell setTitleStr:@"成交金额" valueStr:[NSObject moneyStyle:self.tradeSiteM.tsEndPrice]];
            
        }else if (indexPath.row == 2){
            [cell setTitleStr:@"竞得时间" valueStr:self.tradeSiteM.buyTime];
            
        }else if (indexPath.row == 3){
            [cell setTitleStr:@"支付状态" valueStr:@"已支付"];
            
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //    MyProductModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    //    ProductDetailViewController *vc = [ProductDetailViewController new];
    //    vc.hidBottomView = YES;
    //
    //    vc.piId = model.piId;
    //    [self.navigationController pushViewController:vc animated:YES];
}
@end
