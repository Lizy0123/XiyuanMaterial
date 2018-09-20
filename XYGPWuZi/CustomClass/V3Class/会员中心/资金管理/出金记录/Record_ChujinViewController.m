//
//  Record_ChujinViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/11.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Record_ChujinViewController.h"
#import "ChuJiaJiLuModel.h"
#import "ChhuJiaJiLuTCell.h"
#import "Api_FindUserBankInfo.h"

@interface Record_ChujinViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)int page;


@end

@implementation Record_ChujinViewController
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] init];
    }
    return _dataSourceArray;
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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"出金记录"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)actionSearchKeyWordBtn{
    
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
        return CGFLOAT_MIN;
    }else{
        return CGFLOAT_MIN;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
//    if (section == 0) {
//        view.frame = CGRectMake(0, 0, kScreen_Width, [self tableView:tableView heightForHeaderInSection:section]);
//        UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreen_Width, [self tableView:tableView heightForHeaderInSection:section])];
//        labe.text = [NSString stringWithFormat:@"收入总额：%@  支出总额：%@",@"￥500.00",@"￥300.00"];
//        [view addSubview:labe];
//    }
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChhuJiaJiLuTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordTCell"];
    if (cell == nil) {
        cell = [[ChhuJiaJiLuTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecordTCell"];
    }
    Model_dm *dmM = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    RecordJiaoyiModel *model = [[RecordJiaoyiModel alloc]init];
    model.tspMoney = dmM.dmMoney;
    model.tspBuyTime = dmM.dmDatetime;
    NSString *str = @"";
    if ([dmM.dmStatus isEqualToString:@"1"]) {
        str = @"待审核";
    }else if ([dmM.dmStatus isEqualToString:@"2"]){
        str = @"通过";
    }else if ([dmM.dmStatus isEqualToString:@"3"]){
        str = @"未通过";
    }
    model.bidNo = [NSString stringWithFormat:@"%@(%@)",str,[NSObject isString:dmM.dmRefuseReason]?dmM.dmRefuseReason:@"暂无"];
    cell.recordJiaoyiM = model;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    XianZhiGongYingModel *model = self.dataSourceArray[indexPath.row];
    //    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    //    vc.piId = model.piId;
    //    if ([model.userId isEqualToString:[UserManager readUserInfo].codeId]) {
    //        vc.hidBottomView = YES;
    //    }else{
    //        vc.hidBottomView = NO;
    //    }
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end
