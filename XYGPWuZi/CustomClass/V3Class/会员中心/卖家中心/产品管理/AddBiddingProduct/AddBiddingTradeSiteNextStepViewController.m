//
//  AddBiddingTradeSiteNextStepViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/5.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "AddBiddingTradeSiteNextStepViewController.h"
#import "MyProductListViewController.h"
#import "TitleValueTCell.h"
#import "TitleTextFieldTCell.h"

#import "BRPickerView.h"
#import "MyStepper.h"
#import "MyProductModel.h"

@interface AddBiddingTradeSiteNextStepViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(assign, nonatomic)__block int page;
@property(assign, nonatomic) NSIndexPath *selIndex0;//拼盘方式
@property(assign, nonatomic) NSIndexPath *selIndex1;//计价方式

@property(nonatomic, strong) MyStepper *numberStepper;

@end

@implementation AddBiddingTradeSiteNextStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isEdit?@"修改拼盘":@"拼盘竞价";
    if (self.isEdit) {
        _selIndex0 = [NSIndexPath indexPathForRow:[self.addBiddingM.tsTradeType integerValue] inSection:0];
        _selIndex1 = [NSIndexPath indexPathForRow:[self.addBiddingM.tsJjfs integerValue] inSection:1];
    }
    MyStepper *stepper = [[MyStepper alloc] initWithFrame:CGRectMake(100, 7, 120, 30)];
    [stepper setBorderColor:kColorNav];
    [stepper setTextColor:kColorNav];
    [stepper setButtonTextColor:kColorNav forState:UIControlStateNormal];
    self.numberStepper = stepper;
    
    [self configMyTableView];
    [self configBottomView];
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
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;
    
    
    [tableView registerClass:[TitleTextFieldTCell class] forCellReuseIdentifier:kCellIdentifier_TitleTextFieldTCell];
    [tableView registerClass:[TitleValueTCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueTCell];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
}
-(void)configBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor clearColor];
    NSString *titleStr = @"生成场次";
    if (self.isEdit) {
        titleStr = @"修改场次";
    }
    UIButton *button = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:titleStr andFrame:CGRectMake(16, 0, kScreen_Width-32, 44) target:self action:@selector(actionCreateTradeSite)];
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kViewAtBottomHeight));
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
}
-(void)actionCreateTradeSite{
    if (![NSObject isString:self.addBiddingM.tsTradeType]) {
        [NSObject ToastShowStr:@"请勾选拼盘方式"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsJjfs]) {
        [NSObject ToastShowStr:@"请勾选计价方式"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsMinPrice]) {
        [NSObject ToastShowStr:@"请填写起始价格"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsAddPrice]) {
        [NSObject ToastShowStr:@"请填写加价幅度"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsProtectPrice]) {
        [NSObject ToastShowStr:@"请填写最低出售价"];
        return;
    }
    
    self.addBiddingM.token = [UserManager readUserInfo].token;
    self.addBiddingM.tsSiteType = @"1";

//    __weak typeof(self)weakself = self;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.isEdit&&[NSObject isString:self.addBiddingM.tsId]) {
        [dic setObject:self.addBiddingM.tsId forKey:@"tsId"];
    }
    [dic setObject:self.addBiddingM.token forKey:@"token"];
    [dic setObject:self.addBiddingM.tsSiteType forKey:@"tsSiteType"];
    [dic setObject:self.addBiddingM.tsName forKey:@"tsName"];
    [dic setObject:self.addBiddingM.tsNoticeDate forKey:@"tsNoticeDate"];
//    [dic setObject:self.addBiddingM.tsTradeDate forKey:@"tsTradeDate"];
    [dic setObject:self.addBiddingM.tsStartTime forKey:@"tsStartTime"];
    [dic setObject:self.addBiddingM.tsEndTime forKey:@"tsEndTime"];
    
    [dic setObject:self.addBiddingM.tsTradeType forKey:@"tsTradeType"];
    [dic setObject:self.addBiddingM.tsJjfs forKey:@"tsJjfs"];
    [dic setObject:self.addBiddingM.tsMinPrice forKey:@"tsMinPrice"];
    [dic setObject:self.addBiddingM.tsAddPrice forKey:@"tsAddPrice"];
    [dic setObject:self.addBiddingM.tsProtectPrice forKey:@"tsProtectPrice"];
    
    NSMutableArray *array = [NSMutableArray new];
    for (MyProductModel *model in self.addBiddingM.tradeProducts) {
        if ([NSObject isString:model.piId] && [NSObject isString:model.piNumber]) {
            [array addObject:@{@"piId":model.piId,@"piNumber":model.piNumber}];
        }
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [dic setObject:jsonString forKey:@"productsJson"];

    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_SaveOrUpdateTradeSite] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据：%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            [NSObject archiverWithSomeThing:[NSMutableArray new] someName:kTradeSiteCache];

            NSString *str = @"场次生成成功！";
            if (self.isEdit) {
                str = @"场次修改成功！";
            }
            [NSObject ToastShowStr:str];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *str = @"场次生成失败！";
        if (self.isEdit) {
            str = @"场次修改失败！";
        }
        [NSObject ToastShowStr:str];
    }];
}




#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }
    else{
        return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, kScreen_Width - kMyPadding *2, 35)];
    label.font = [UIFont systemFontOfSize:14];

    [headerView addSubview:label];
    if (section == 0) {
        label.text = @"拼盘方式（单选）";
    }else if (section == 1){
        label.text = @"计价方式（单选）";
    }else if (section == 2){
        label.text = @"拼盘资源属性";
    }
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellId = @"cellid";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"单价报盘";

        }else{
            cell.textLabel.text = @"总价报盘";
        }
        if (_selIndex0 == indexPath) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellId = @"cellid";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"重量计价";
            
        }else{
            cell.textLabel.text = @"数量计价";
        }
        if (_selIndex1 == indexPath) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    else{
        __weak typeof(self) weakSelf = self;
        if (indexPath.row == 0) {
            TitleValueTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValueTCell forIndexPath:indexPath];
            [cell setTitleStr:@"交易方式" valueStr:@"公开增加"];
            return cell;
            
        }else if (indexPath.row == 1){
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];

            [cell setTitleStr:@"起始价格" valueStr:self.addBiddingM.tsMinPrice placeHolder:@"￥0.00"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addBiddingM.tsMinPrice = text;
            };
            return cell;
            
        }else if (indexPath.row == 2){
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
            [cell setTitleStr:@"加价幅度" valueStr:self.addBiddingM.tsAddPrice placeHolder:@"￥0.00"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addBiddingM.tsAddPrice = text;
            };
            return cell;
            
        }else if (indexPath.row == 3){
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
            
            [cell setTitleStr:@"最低出售价" valueStr:self.addBiddingM.tsProtectPrice placeHolder:@"￥0.00"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addBiddingM.tsProtectPrice = text;
            };
            return cell;
        }
//        else if (indexPath.row == 3){
//            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
//
//            [cell setTitleStr:@"交易数量" valueStr:self.unitStr];
//            cell.tapAcitonBlock = ^{
//                NSArray *dataSources = @[@"吨",@"箱",@"桶",@"件",@"套",@"批",@"辆",@"条",@"块",@"部",@"架",@"个",@"根",@"包",@"米",@"立方米",@"平方米",@"台"];
//                [BRStringPickerView showStringPickerWithTitle:@"交易数量" dataSource:dataSources defaultSelValue:@"吨" isAutoSelect:YES resultBlock:^(id selectValue) {
//                    weakSelf.unitStr = selectValue;
//                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                }];
//            };
//
//            // plain
//            self.numberStepper.valueChangedCallback = ^(MyStepper *stepper, float count) {
//                NSLog(@"返回的数字%@",@(count));
//                stepper.countTextField.text = [NSString stringWithFormat:@"%.0f", count];
//            };
//            [self.numberStepper setup];
//            [cell addSubview:self.numberStepper];
//
//            return cell;
//
//        }
        else{
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];

            return cell;
            
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        //之前选中的，取消选择
        UITableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex0];
        celled.accessoryType = UITableViewCellAccessoryNone;
        //记录当前选中的位置索引
        _selIndex0 = indexPath;
        
        //当前选择的打勾
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.addBiddingM.tsTradeType = [NSString stringWithFormat:@"%ld",indexPath.row];
    }else if (indexPath.section == 1){
        //之前选中的，取消选择
        UITableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex1];
        celled.accessoryType = UITableViewCellAccessoryNone;
        //记录当前选中的位置索引
        _selIndex1 = indexPath;
        //当前选择的打勾
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.addBiddingM.tsJjfs = [NSString stringWithFormat:@"%ld",indexPath.row];

    }
}
@end
