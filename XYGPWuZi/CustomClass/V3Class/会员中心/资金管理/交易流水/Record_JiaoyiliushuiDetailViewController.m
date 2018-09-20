//
//  Record_JiaoyiliushuiDetailViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/7.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Record_JiaoyiliushuiDetailViewController.h"

@interface Record_JiaoyiliushuiDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation Record_JiaoyiliushuiDetailViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsMultipleSelectionDuringEditing = YES;

        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
        _tableView.contentInset = insets;
        _tableView.scrollIndicatorInsets = insets;
        
    }return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"流水详情"];
    //添加TableView
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height = [self tableView:tableView heightForFooterInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ProductTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0) {
        if ([NSObject isString:self.tradingRecordM.trMoney]) {
            if (self.tradingRecordM.trMoney.integerValue <0) {
                cell.imageView.image = [UIImage imageNamed:@"moneyOut"];
            }else{
                cell.imageView.image = [UIImage imageNamed:@"moneyIn"];
            }
        }
        cell.imageView.layer.cornerRadius = 5;
        cell.imageView.clipsToBounds = YES;
        cell.textLabel.text = [NSString stringWithFormat:@"%@    %@",self.tradingRecordM.trType,[NSObject moneyStyle:self.tradingRecordM.trMoney]];
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"交易流水号";
            cell.detailTextLabel.text = self.tradingRecordM.jylsh;
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"发生时间";
            cell.detailTextLabel.text = self.tradingRecordM.tradTime;
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"场次名称";
            cell.detailTextLabel.text = self.tradingRecordM.tsName;
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"场次编号";
            cell.detailTextLabel.text = self.tradingRecordM.tsNob;
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"交易方";
            cell.detailTextLabel.text = self.tradingRecordM.trObj;
        }
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }
    else{
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
@end
