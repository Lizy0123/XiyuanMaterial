//
//  ChengJiaoRecordViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/12/27.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "ChengJiaoRecordViewController.h"
#import "ChengJiaoRecordTableViewCell.h"
#import "ChhuJiaJiLuTCell.h"

@interface ChengJiaoRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;
@property(nonatomic,strong)UIView *headerView;
@end

@implementation ChengJiaoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出价记录";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTableView];
    
}

#pragma mark - UI
-(void)createTableView{
    self.myTable = [[UITableView alloc]initWithFrame:CGRectZero];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc]init];
    self.myTable.contentInset = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight, 0);
    self.myTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.myTable.rowHeight = [ChengJiaoRecordTableViewCell cellHeight];
    [self.view addSubview:self.myTable];
    [self setUpHeadView];
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
}
#pragma mark headView
-(void)setUpHeadView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    self.myTable.tableHeaderView = self.headerView;
    
    if (self.dataArray) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, 10, S_W-2*kMyPadding, 20)];
        label.text = [NSString stringWithFormat:@"出价记录（%ld次)",(long)self.dataArray.count];
        [headerView addSubview:label];
    }
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChengJiaoRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ChengJiaoRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell showDataWithDic:(NSMutableDictionary *)self.dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
