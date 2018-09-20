//
//  AddBiddingTradeSiteViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "AddBiddingTradeSiteViewController.h"
#import "AddBiddingProductTCell.h"
#import "ProductDetailViewController.h"
#import "AddBiddingTradeSiteNextStepViewController.h"
#import "TitleValueMoreTCell.h"
#import "TitleTextFieldTCell.h"
#import "BRPickerView.h"
#import "AddBiddingModel.h"

@interface AddBiddingTradeSiteViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@end

@implementation AddBiddingTradeSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isEdit?@"修改拼盘":@"拼盘竞价";

    if (!self.addBiddingM) {
        self.addBiddingM = [AddBiddingModel new];
    }
    
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

    [tableView registerClass:[AddBiddingProductTCell class] forCellReuseIdentifier:kCellIdentifier_AddBiddingProductTCell];
    [tableView registerClass:[TitleValueMoreTCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueMoreTCell];
    [tableView registerClass:[TitleTextFieldTCell class] forCellReuseIdentifier:kCellIdentifier_TitleTextFieldTCell];

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
    
    UIButton *button = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"下一步" andFrame:CGRectMake(16, 0, kScreen_Width-32, 44) target:self action:@selector(goToNextStep)];
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kViewAtBottomHeight));
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
}



#pragma mark - Action
-(void)goToNextStep{
    if ([kStringToken length]) {
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
        self.addBiddingM.tradeProducts = self.productListArray;
        AddBiddingTradeSiteNextStepViewController *vc = [AddBiddingTradeSiteNextStepViewController new];
        vc.isEdit = self.isEdit;
        vc.addBiddingM = self.addBiddingM;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:^{
        }];
    }
}
-(void)popToSuperView{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.productListArray.count;
    }else{
        return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [AddBiddingProductTCell cellHeight];
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
        label.text = @"拼盘产品信息";
        if (!self.isEdit) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(kScreen_Width - kMyPadding - 90, 2.5, 90, 30)];
            [btn setBorderColor:[UIColor blackColor]];
            btn.clipsToBounds = YES;
            [btn setCornerRadius:5];
            
            [btn setTitle:@"  继续添加" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"pluse"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn addTarget:self action:@selector(popToSuperView) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:btn];
        }
    }else{
        label.text = @"拼盘场次信息";
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEdit) {
        return NO;
    }else{
        return YES;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    
    //删除数据，和删除动画
    [self.productListArray removeObjectAtIndex:indexPath.row];
    [NSObject archiverWithSomeThing:self.productListArray someName:kTradeSiteCache];

    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
}






-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AddBiddingProductTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_AddBiddingProductTCell forIndexPath:indexPath];
        cell.productM = [self.productListArray objectAtIndex:indexPath.row];
        return cell;
    }else{
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
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MyProductModel *model = [self.productListArray objectAtIndex:indexPath.row];
        ProductDetailViewController *vc = [ProductDetailViewController new];
        vc.hidBottomView = YES;
        vc.piId = model.piId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
