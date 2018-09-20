//
//  OrderListViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/21.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//
#define kClearAllBtnWidth 50
#define kHeaderViewPoint kScreen_Height/2

#import "OrderListViewController.h"
#import "UIViewController+KNSemiModal.h"

@interface OrderListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@end


static NSString * const cellIdentifier = @"cellIdentifier";
@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];

    [self configMyTableView];
    [self configHeaderView];

}

-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = NO;
    tableView.backgroundColor =[UIColor redColor];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(kScreen_Height - (kHeaderViewPoint - 50));
    }];
    self.myTableView = tableView;
}
-(void)configHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeaderViewPoint, kScreen_Width, 50)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, kScreen_Width - 32 - kClearAllBtnWidth, 50)];
    firstLabel.text = [NSString stringWithFormat:@"拼盘产品明细(共%lu)种产品",(unsigned long)self.dataSourceArray.count];
    firstLabel.textColor = [UIColor blackColor];
    firstLabel.font = [UIFont boldSystemFontOfSize:13];
    [headerView addSubview:firstLabel];
    
    UIButton *clearAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearAllBtn setTitle:@"清空" forState:UIControlStateNormal];
    [clearAllBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [clearAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearAllBtn addTarget:self action:@selector(actionClearAll:) forControlEvents:UIControlEventTouchUpInside];
    [clearAllBtn.layer setCornerRadius:5];
    clearAllBtn.clipsToBounds = YES;
    clearAllBtn.borderWidth = 1;
    clearAllBtn.borderColor = [UIColor blackColor];
    [headerView addSubview:clearAllBtn];
    [clearAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kClearAllBtnWidth, 30));
        make.right.equalTo(headerView).offset(-kMyPadding);
    }];
    [self.view addSubview:headerView];
}

#pragma mark - Action
-(void)actionClearAll:(id)sender{
    NSLog(@"点击了清除按钮");
}




#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.myProductAuditStatus = self.myProductAuditStatus;
//    cell.productM = self.dataSourceArray[indexPath.row];
//    cell.delegate = self;
    
    return cell;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissSemiModalView];

}
@end
