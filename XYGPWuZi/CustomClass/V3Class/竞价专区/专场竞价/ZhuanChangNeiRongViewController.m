//
//  ZhuanChangNeiRongViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "ZhuanChangNeiRongViewController.h"
#import "JingJiaDetailViewController.h"
#import "BiddingView_single.h"



@interface ZhuanChangNeiRongViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;

@end

@implementation ZhuanChangNeiRongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专场内容";

    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.right.left.equalTo(self.view);
    }];


    [self configHeaderView];


    self.dataSourceArray = [[NSMutableArray alloc] initWithObjects:@"",
                            @"", @"", nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(void)configHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width+120)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.myTableView.tableHeaderView = headerView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"MyImage"];
    [headerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headerView);
        make.height.mas_equalTo(kScreen_Width);
    }];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"我是竞价专场标题";
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
    }];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.text = [NSString stringWithFormat:@"卖家名称：%@",@"谁谁谁"];
    
    [headerView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(25);
    }];
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.text = [NSString stringWithFormat:@"专场开始时间：%@",@"2017-03-22 11：05"];
    
    [headerView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    moneyLabel.text = [NSString stringWithFormat:@"专场保证金额：%@",@"￥180.00-￥1800.00"];
    
    [headerView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom);
        make.left.equalTo(headerView).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(25);
    }];
}



#pragma mark - Delegate_Table
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            
            tableView;
        });
    }return _myTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [BiddingView_single  cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

/*
 -backView
 -backView-leftBackimgView
 -backView-leftBackimgView-label
 -backView-moreBtn
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [UIView new];
    backView.backgroundColor = self.myTableView.backgroundColor;
    
    UILabel *label = [UILabel new];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.layer.masksToBounds = YES;
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backView).insets(UIEdgeInsetsMake(4, 15, 4, 15));
    }];
    label.text = @"竞价场次";
    return backView;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber *badgeNumber = @(indexPath.row + 1);
    //    self.navigationItem.title = [NSString stringWithFormat:@"首页(%@)", badgeNumber];
    //    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", badgeNumber]];
    [self configSelect:tableView forIndexPath:indexPath];
}



- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    BiddingView_single *view = [[BiddingView_single alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [BiddingView_single  cellHeight])];
    view.biddingM = [BiddingModel new];
    [cell.contentView addSubview:view];
    
    if (indexPath.section == 0) {
        //            ProductView_SingleImg *view = [[ProductView_SingleImg alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
        //            view.productM = [[ProductModel alloc] init];
        //            [cell.contentView addSubview:view];
    }else if (indexPath.section == 1){
        
        //        ProductView_CollectionImg *view = [[ProductView_CollectionImg alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
        //        view.productM = [[ProductModel alloc] init];
        //        [cell.contentView addSubview:view];
    }else{
        
        //        ProductView_PortraitImg *view = [[ProductView_PortraitImg alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
        //        view.productM = [[ProductModel alloc] init];
        //        [cell.contentView addSubview:view];
    }
}

-(void)configSelect:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
    JingJiaDetailViewController *vc = [JingJiaDetailViewController new];
    //ToDo:0123
    vc.tnId = @"40288086611ca2fa01611ccc4e750007";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
