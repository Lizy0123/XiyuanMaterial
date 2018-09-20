//
//  ChuJiaJiLuViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "ChuJiaJiLuViewController.h"
#import "TitleValueTCell.h"
#import "ChuJiaJiLuModel.h"
#import "ChhuJiaJiLuTCell.h"

@interface ChuJiaJiLuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceTarray;
@property(strong, nonatomic)ChuJiaJiLuModel *recordM;
@end

@implementation ChuJiaJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"出价记录"];
    [self configMyTableView];
    [self serveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
    [tableView registerClass:[TitleValueTCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueTCell];
    [tableView registerClass:[ChhuJiaJiLuTCell class] forCellReuseIdentifier:kCellIdentifier_RecordTCell];
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
}

#pragma mark - Action
-(void)serveData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.addBiddingM.tsId forKey:@"id"];
    [dict setObject:[UserManager readUserInfo].token forKey:@"token"];
    [dict setObject:@"0" forKey:@"type"];//0：我的场次出价过程，获取我的场次出价过程请传0值）
    
    __weak typeof(self)weakself = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetTradeSiteProcessList] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据：%@",responseObject);
        self.recordM = [[ChuJiaJiLuModel alloc] initWithDictionary:responseObject[@"object"] error:nil];
        self.dataSourceTarray = [NSMutableArray arrayWithArray:self.recordM.processList];
        [weakself.myTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;

    }else{
        return self.dataSourceTarray.count;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return [ChhuJiaJiLuTCell cellHeight];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return 30;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (section == 1) {
        UILabel *labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, (kScreen_Width - kMyPadding *2)/2 , 30)];
        labelLeft.textAlignment = NSTextAlignmentCenter;
        labelLeft.text = @"出价方";
        labelLeft.font = [UIFont systemFontOfSize:13];
        [headerView addSubview:labelLeft];
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake((kScreen_Width - kMyPadding *2)/2 , 0, 0.5, 30)];
        linView.backgroundColor = [UIColor lightGrayColor];
        [labelLeft addSubview:linView];
        
        UILabel *labelRight = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width/2 , 5, (kScreen_Width - kMyPadding *2)/2 +30, 20)];
        labelRight.textAlignment = NSTextAlignmentCenter;
        labelRight.text = @"出价金额（元）";
        labelRight.font = [UIFont systemFontOfSize:13];
        [headerView addSubview:labelRight];
        return headerView;

    }else{
        return nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TitleValueTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValueTCell forIndexPath:indexPath];

        if (indexPath.row == 0) {
            [cell setTitleStr:@"场次编号" valueStr:self.recordM.tsTradeNo];
            
        }else if (indexPath.row == 1){
            [cell setTitleStr:@"起拍价" valueStr:[NSObject moneyStyle:self.recordM.tsMinPrice]];
            
        }
        return cell;

    }else{
        ChhuJiaJiLuTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_RecordTCell];
        RecordDetailModel *model = [self.dataSourceTarray objectAtIndex:indexPath.row];
        cell.recordDetailM = model;
        return cell;
    }
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
