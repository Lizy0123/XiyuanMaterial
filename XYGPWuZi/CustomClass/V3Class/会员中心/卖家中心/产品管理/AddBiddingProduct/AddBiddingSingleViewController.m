//
//  AddBiddingSingleViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "AddBiddingSingleViewController.h"

#import "AddBiddingTradeSiteNextStepViewController.h"
#import "TitleValueMoreTCell.h"
#import "TitleValueTCell.h"
#import "TitleTextFieldTCell.h"
#import "BRPickerView.h"
#import "MyStepper.h"

@interface AddBiddingSingleViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(assign, nonatomic)__block int page;
@property(nonatomic, strong) MyStepper *numberStepper;

@end

@implementation AddBiddingSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isEdit?@"修改竞价":@"单品竞价";

    if (!self.addBiddingM) {
        self.addBiddingM = [AddBiddingModel new];
        self.addBiddingM.tsNum = self.myProductM.piNumber;
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

#pragma mark - UI
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
    
    
    [tableView registerClass:[TitleValueMoreTCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueMoreTCell];
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
    
    UIButton *button = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"生成场次" andFrame:CGRectMake(16, 0, kScreen_Width-32, 44) target:self action:@selector(actionCreateTradeSite)];
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kViewAtBottomHeight));
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
}
-(void)actionCreateTradeSite{
    if (([NSObject compareDateStr:self.addBiddingM.tsStartTime withDateStr:self.addBiddingM.tsEndTime]<0)) {
        [NSObject ToastShowStr:@"竞价结束时间不能早于竞价开始时间！"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsName]) {
        [NSObject ToastShowStr:@"请填写场次名称"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsNoticeDate]) {
        [NSObject ToastShowStr:@"请填写公告日期"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsStartTime]) {
        [NSObject ToastShowStr:@"请填写竞价开始时间"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsEndTime]) {
        [NSObject ToastShowStr:@"请填写竞价结束时间"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsMinPrice]) {
        [NSObject ToastShowStr:@"请填写起始价格"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsProtectPrice]) {
        [NSObject ToastShowStr:@"请填写最低出售价"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsAddPrice]) {
        [NSObject ToastShowStr:@"请填写加价幅度"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsNum]) {
        [NSObject ToastShowStr:@"请填写加交易数量"];
        return;
    }
    if (!([self.addBiddingM.tsNum integerValue] >0)) {
        [NSObject ToastShowStr:@"交易数量必须大于0"];
        return;
    }
    if (![NSObject isString:self.addBiddingM.tsUnits]) {
        self.addBiddingM.tsUnits = @"件";
    }
    
    
    
    self.addBiddingM.token = [UserManager readUserInfo].token;
    self.addBiddingM.tsSiteType = @"0";
    self.addBiddingM.tsTradeType = @"1";
    //    __weak typeof(self)weakself = self;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.addBiddingM.token forKey:@"token"];
    [dic setObject:self.addBiddingM.tsSiteType forKey:@"tsSiteType"];
    [dic setObject:self.addBiddingM.tsTradeType forKey:@"tsTradeType"];
    [dic setObject:self.addBiddingM.tsName forKey:@"tsName"];
    [dic setObject:self.addBiddingM.tsNoticeDate forKey:@"tsNoticeDate"];
    [dic setObject:self.addBiddingM.tsStartTime forKey:@"tsStartTime"];
    [dic setObject:self.addBiddingM.tsEndTime forKey:@"tsEndTime"];
    [dic setObject:self.addBiddingM.tsMinPrice forKey:@"tsMinPrice"];
    [dic setObject:self.addBiddingM.tsProtectPrice forKey:@"tsProtectPrice"];
    [dic setObject:self.addBiddingM.tsAddPrice forKey:@"tsAddPrice"];
    [dic setObject:self.addBiddingM.tsUnits forKey:@"tsUnits"];

    NSMutableArray *array = [NSMutableArray new];
    if ([NSObject isString:self.myProductM.piId] &&[NSObject isString:self.addBiddingM.tsNum]) {
        [array addObject:@{@"piId":self.myProductM.piId,@"piNumber":self.addBiddingM.tsNum}];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [dic setObject:jsonString forKey:@"productsJson"];
    
    
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_SaveOrUpdateTradeSite] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据：%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            [NSObject ToastShowStr:@"场次生成成功！"];
        }else{
            [NSObject ToastShowStr:@"场次生成失败！"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject ToastShowStr:@"场次生成失败！"];
    }];
}



#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, kScreen_Width - kMyPadding *2, 35)];
    label.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:label];
    if (section == 0) {
        label.text = @"单品场次信息";
    }else{
        label.text = @"单品资源属性";
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
        TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        if (indexPath.row == 0) {
            [cell setTitleStr:@"场次名称" valueStr:self.addBiddingM.tsName placeHolder:@"必填"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addBiddingM.tsName = text;
            };
            return cell;
            
        }else if (indexPath.row == 1){
            if (self.addBiddingM.tsNoticeDate.length>10) {
                self.addBiddingM.tsNoticeDate = [self.addBiddingM.tsNoticeDate substringToIndex:10];
            }
            [cell setTitleStr:@"公告日期" valueStr:self.addBiddingM.tsNoticeDate placeHolder:@"请选择日期"];
            cell.tapAcitonBlock = ^{
                [BRDatePickerView showDatePickerWithTitle:@"公告日" dateType:UIDatePickerModeDate defaultSelValue:self.addBiddingM.tsNoticeDate minDateStr:[NSObject currentDateString] maxDateStr:nil isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                    weakSelf.addBiddingM.tsNoticeDate = selectValue;
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            };
            return cell;
            
        }else if (indexPath.row == 2){
            [cell setTitleStr:@"竞价开始时间" valueStr:self.addBiddingM.tsStartTime placeHolder:@"请选择时间"];
            cell.tapAcitonBlock = ^{
                [BRDatePickerView showDatePickerWithTitle:@"竞价开始时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:self.addBiddingM.tsStartTime minDateStr:[NSObject currentDateString] maxDateStr:nil isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                    weakSelf.addBiddingM.tsStartTime = selectValue;
                    
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            };
            return cell;
            
        }else if (indexPath.row == 3){
            [cell setTitleStr:@"竞价结束时间" valueStr:self.addBiddingM.tsEndTime placeHolder:@"请选择时间"];
            cell.tapAcitonBlock = ^{
                if (weakSelf.addBiddingM.tsStartTime) {
                    if (self.isEdit) {
                        [BRDatePickerView showDatePickerWithTitle:@"竞价结束时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:self.addBiddingM.tsEndTime minDateStr:[NSObject currentDateString] maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                            weakSelf.addBiddingM.tsEndTime = selectValue;
                            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        }];
                    }else{
                        [BRDatePickerView showDatePickerWithTitle:@"竞价结束时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:self.addBiddingM.tsEndTime minDateStr:weakSelf.addBiddingM.tsStartTime maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                            weakSelf.addBiddingM.tsEndTime = selectValue;
                            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        }];
                    }
                }else{
                    [NSObject ToastShowStr:@"请先选择竞价开始时间！"];
                }
            };
            return cell;
        }else{
            return cell;
        }
        return cell;
    }else{
        __weak typeof(self) weakSelf = self;
        if (indexPath.row == 0) {
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
            
            [cell setTitleStr:@"起始价格" valueStr:self.addBiddingM.tsMinPrice placeHolder:@"￥0.00"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addBiddingM.tsMinPrice = text;
            };
            return cell;
        }else if (indexPath.row == 1){
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
            
            [cell setTitleStr:@"最低出售价" valueStr:self.addBiddingM.tsProtectPrice placeHolder:@"￥0.00"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addBiddingM.tsProtectPrice = text;
                
            };
            return cell;
            
        }else if (indexPath.row == 2){
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
            
            [cell setTitleStr:@"加价幅度" valueStr:self.addBiddingM.tsAddPrice placeHolder:@"￥0.00"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addBiddingM.tsAddPrice = text;
                
            };
            return cell;
            
        }
//        else if (indexPath.row == 3){
//            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
//
//            [cell setTitleStr:@"总价格" valueStr:self.addBiddingM.tsCountPrice placeHolder:@"￥0.00"];
//            cell.endEditBlock = ^(NSString *text) {
//                weakSelf.addBiddingM.tsCountPrice = text;
//            };
//
//            return cell;
//        }
        else if (indexPath.row == 3){
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
            
            [cell setTitleStr:@"交易数量" valueStr:self.addBiddingM.tsUnits placeHolder:@"件"];
            cell.tapAcitonBlock = ^{
                NSArray *dataSources = @[@"件",@"箱",@"桶",@"吨",@"套",@"批",@"辆",@"条",@"块",@"部",@"架",@"个",@"根",@"包",@"米",@"立方米",@"平方米",@"台"];
                [BRStringPickerView showStringPickerWithTitle:@"交易数量" dataSource:dataSources defaultSelValue:@"件" isAutoSelect:YES resultBlock:^(id selectValue) {
                    weakSelf.addBiddingM.tsUnits = selectValue;
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            };
            
            self.numberStepper.value = [self.addBiddingM.tsNum floatValue];
            self.numberStepper.hidesDecrementWhenMinimum = YES;
            self.numberStepper.hidesIncrementWhenMaximum = YES;


            // plain
            self.numberStepper.valueChangedCallback = ^(MyStepper *stepper, float count) {
                NSLog(@"返回的数字%@",@(count));
                stepper.countTextField.text = weakSelf.addBiddingM.tsNum = [NSString stringWithFormat:@"%.0f", count];
            };
            [self.numberStepper setup];
            [cell addSubview:self.numberStepper];
            
            return cell;
        }else{
            TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
            return cell;
        }
    }
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//
//        }else if (indexPath.row == 1){
//
//        }else if (indexPath.row == 2){
//
//        }else if (indexPath.row == 3){
//
//        }else if (indexPath.row == 4){
//
//        }
//    }else{
//        if (indexPath.row == 0) {
//
//        }else if (indexPath.row == 1){
//
//        }else if (indexPath.row == 2){
//
//        }else if (indexPath.row == 3){
//
//        }else if (indexPath.row == 4){
//
//        }
//    }
//}
@end
