//
//  JiTuanZhuanChangDetailViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/3/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "JiTuanZhuanChangDetailViewController.h"
#import "MyBiddingListViewController.h"

#import "ZJScrollPageView.h"

@interface JiTuanZhuanChangDetailViewController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

//<UITableViewDelegate, UITableViewDataSource>
//@property(strong, nonatomic)UITableView *myTableView;
//@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@end

@implementation JiTuanZhuanChangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专场内容";
    
    [self.view addSubview:[self configHeaderView]];
    
//    [self.view addSubview:self.myTableView];
//    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view);
//        make.bottom.right.left.equalTo(self.view);
//    }];
//    self.dataSourceArray = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
    
    self.titles = @[@"竞价公告",@"闲置供应"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.gradualChangeTitleColor = YES;
    style.autoAdjustTitlesWidth = YES;
    style.normalTitleColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    style.selectedTitleColor = kColorMain;
    style.scrollLineColor = kColorMain;
    style.titleFont = [UIFont boldSystemFontOfSize:15];
    style.segmentHeight = 30;
    style.showLine = YES;
    style.showImage = NO;
    
    style.scrollTitle = YES;
    /// 显示图片 (在显示图片的时候只有下划线的效果可以开启, 其他的'遮盖','渐变',效果会被内部关闭)
    style.imagePosition = TitleImagePositionTop;
    style.autoAdjustTitlesWidth = YES;
    style.adjustTitleWhenBeginDrag = YES;
    // 渐变
    style.gradualChangeTitleColor = YES;
    style.scrollLineColor = [UIColor colorWithRed:235.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.normalTitleColor = [UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0];
    //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.selectedTitleColor = kColorMain;
    
    // 初始化
    _scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - kSafeAreaTopHeight) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.scrollPageView setSelectedIndex:self.selectedPage animated:NO];
    
    [self.view addSubview:_scrollPageView];
    
}


#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}
- (MyBiddingListViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(MyBiddingListViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    MyBiddingListViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = [[MyBiddingListViewController alloc] init];
    }
    if (index == 0) {
        childVc.title = @"专场竞价";
    }else if (index == 1){
        childVc.title = @"单场竞价";
    }
    return childVc;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(UIView *)configHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 120)];
    headerView.backgroundColor = [UIColor whiteColor];
//    self.myTableView.tableHeaderView = headerView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"MyImage"];
    imageView.cornerRadius = 50;
    imageView.clipsToBounds = YES;
    [headerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(headerView);
        make.size.mas_equalTo((CGSize){100, 100});
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"北京华夏建龙矿业科技有限公司";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_top).offset(kMyPadding);
        make.left.mas_equalTo(imageView.mas_right).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *DanweiNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    DanweiNumLabel.text = [NSString stringWithFormat:@"所属成员单位共%@家",@"29"];
    DanweiNumLabel.font = [UIFont systemFontOfSize:12];
    
    [headerView addSubview:DanweiNumLabel];
    [DanweiNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.left.mas_equalTo(imageView.mas_right).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(20);
    }];
    
    
    UILabel *ChangciNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    ChangciNumLabel.text = [NSString stringWithFormat:@"进行场次：%@ 场        闲置物资：%@ 种",@"20",@"17"];
    ChangciNumLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:ChangciNumLabel];
    [ChangciNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DanweiNumLabel.mas_bottom);
        make.left.mas_equalTo(imageView.mas_right).offset(kMyPadding);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *JituanLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    JituanLabel.text = [NSString stringWithFormat:@"集团用户%@",@""];
    JituanLabel.cornerRadius = 10;
    JituanLabel.clipsToBounds = YES;
    JituanLabel.backgroundColor = UIColor.orangeColor;
    JituanLabel.textColor = UIColor.whiteColor;
    JituanLabel.font = [UIFont systemFontOfSize:13];
    JituanLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:JituanLabel];
    [JituanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.right.equalTo(headerView).offset(-kMyPadding);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView.mas_bottom);
        make.left.mas_equalTo(headerView.mas_left).offset(0);
        make.right.equalTo(headerView).offset(0);
        make.height.mas_equalTo(10);
    }];
    return headerView;
}



#pragma mark - Delegate_Table
//-(UITableView *)myTableView{
//    if (!_myTableView) {
//        _myTableView = ({
//            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
//            tableView.delegate = self;
//            tableView.dataSource = self;
//            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            tableView.estimatedSectionHeaderHeight = 0;
//            tableView.estimatedSectionFooterHeight = 0;
//
//            tableView;
//        });
//    }return _myTableView;
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataSourceArray.count;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 200;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//        return 60;
//}
//
///*
// -backView
// -backView-leftBackimgView
// -backView-leftBackimgView-label
// -backView-moreBtn
// */
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *backView = [UIView new];
//    backView.backgroundColor = self.myTableView.backgroundColor;
//
//    UILabel *label = [UILabel new];
//    label.font = [UIFont boldSystemFontOfSize:17];
//    label.textColor = [UIColor blackColor];
//    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    label.layer.masksToBounds = YES;
//    [backView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(backView).insets(UIEdgeInsetsMake(4, 15, 4, 15));
//    }];
//    label.text = @"竞价场次";
//    return backView;
//}
//
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
//    {
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
//    [self configureCell:cell forIndexPath:indexPath];
//    return cell;
//}
//
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSNumber *badgeNumber = @(indexPath.row + 1);
////    self.navigationItem.title = [NSString stringWithFormat:@"首页(%@)", badgeNumber];
////    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", badgeNumber]];
//    [self configSelect:tableView forIndexPath:indexPath];
//}
//
//
//
//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
////            ProductView_SingleImg *view = [[ProductView_SingleImg alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
////            view.productM = [[ProductModel alloc] init];
////            [cell.contentView addSubview:view];
//    }else if (indexPath.section == 1){
//
////        ProductView_CollectionImg *view = [[ProductView_CollectionImg alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
////        view.productM = [[ProductModel alloc] init];
////        [cell.contentView addSubview:view];
//    }else{
//
////        ProductView_PortraitImg *view = [[ProductView_PortraitImg alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
////        view.productM = [[ProductModel alloc] init];
////        [cell.contentView addSubview:view];
//    }
//}
//
//-(void)configSelect:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
//    JingJiaDetailViewController *vc = [JingJiaDetailViewController new];
//    vc.tnId = @"40288086611ca2fa01611ccc4e750007";
//    [self.navigationController pushViewController:vc animated:YES];
//}

@end
