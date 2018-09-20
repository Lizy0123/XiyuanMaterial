//
//  TradeSiteListViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/21.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//
#define kClearAllBtnWidth 50
#define kTableViewHeight (44*5 + 80)

#import "TradeSiteListViewController.h"
#import "UIViewController+KNSemiModal.h"

#import "TradeSiteTCell.h"

@interface TradeSiteListViewController ()<UITableViewDelegate, UITableViewDataSource, TradeSiteTCellDelegate>
@property(strong, nonatomic)UITableView *myTableView;
@end


static NSString * const cellIdentifier = @"cellIdentifier";
@implementation TradeSiteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMyTableView];
    [self configBottomView];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configHeaderView];
    [self.myTableView reloadData];
}
#pragma mark - UI
-(void)configMyTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor =[UIColor whiteColor];
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableFooterView = [UIView new];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(kTableViewHeight);
    }];
    self.myTableView = tableView;
}
-(void)configHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height - kTableViewHeight - 49, kScreen_Width, 49)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, kScreen_Width - 32 - kClearAllBtnWidth, 49)];
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
-(void)configBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor =[UIColor clearColor];

    UIButton *btn = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"生成拼盘" andFrame:CGRectMake(16, 0, kScreen_Width-32, 44) target:self action:@selector(actionCreateTradeSite:)];
    [bottomView addSubview:btn];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kViewAtBottomHeight));
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];

}
#pragma mark - Action
-(void)actionClearAll:(id)sender{
//    NSLog(@"点击清除按钮");
    [self.dataSourceArray removeAllObjects];
    [NSObject archiverWithSomeThing:self.dataSourceArray someName:kTradeSiteCache];
    [self.myTableView reloadData];
    [self dismissSemiModalViewWithCompletion:^{
        [self.parentVC hidBottomView];
        self.parentVC.tradeSiteListArray = [NSObject unarchiverWithName:kTradeSiteCache];
    }];
}
-(void)actionCreateTradeSite:(id)sender{
//    NSLog(@"生成拼盘");
    self.block(self.dataSourceArray);
    [self dismissSemiModalViewWithCompletion:^{
    }];
}



#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TradeSiteTCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TradeSiteTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.model = [self.dataSourceArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - Delegate
-(void)delProductWithCell:(TradeSiteTCell *)cell{
    NSIndexPath *index = [self.myTableView indexPathForCell:cell];
    [self.dataSourceArray removeObjectAtIndex:index.row];
    [self.parentVC.tradeSiteListArray removeObjectAtIndex:index.row];
    [NSObject archiverWithSomeThing:self.dataSourceArray someName:kTradeSiteCache];
    if (self.dataSourceArray.count == 0) {
        [self actionClearAll:nil];
    }else{
        [self.myTableView reloadData];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissSemiModalView];
}
@end
