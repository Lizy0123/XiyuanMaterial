//
//  MyHomeViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/6/30.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyHomeViewController.h"

#import "ProductCategoryViewController.h"//产品分类
#import "SearchViewController.h"//搜索
#import "SGAdvertScrollView.h"//上下滚动的消息

#import "BiddingView_special.h"//专场竞价
#import "BiddingView_single.h"//单场竞价
#import "BiddingView_group.h"//集团专场
#import "XRCarouselView.h"
#import "CarouselModel.h"
#import "Product_TransverseView.h"
#import "CTCell.h"//闲置的横向cell

#import "JiaoYiYuGaoViewController.h"//交易预告
#import "XianZhiQiuGouViewController.h"//闲置求购

#import "ChengJiaoAnLiView_TwoImg.h"
#import "ChengJiaoAnLiViewController.h"
#import "XRChengJiaoDetailViewController.h"
#import "Api_ChengJiaoAnLi.h"//成交案例

#import "RuZhuQiYeViewController.h"//入驻企业
#import "GongPingGongGaoViewController.h"//公平公告
#import "MyBiddingListViewController.h"//竞价专区（专场竞价和单场竞价）
#import "JiTuanZhuanChangViewController.h"//集团专场
#import "XianZhiGongYingViewController.h"//闲置供应
#import "JingJiaDetailViewController.h"//单场竞价
#import "BiddingDetailViewController.h"//单场竞价

@interface MyHomeViewController ()<UITableViewDataSource, UITableViewDelegate, SGAdvertScrollViewDelegate, ProductView_TwoImgDelegate>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *zhuanchangjiangjiaDataSourceArray;
@property(strong, nonatomic)NSMutableArray *successCaseDataSourceArray;


@property(strong, nonatomic)XRCarouselView *myCarouselView;
@property(strong, nonatomic)CarouselModel *carouselM;
@property(strong, nonatomic)NSMutableArray *carouselArray;
@property(strong, nonatomic)SGAdvertScrollView *myMessageScrollView;

@end

@implementation MyHomeViewController
#pragma mark - 配置tableViewHeaderView，轮播图，消息轮播
-(UIView *)tableHeaderView{
    CGFloat kCarousHeight = 100;
    CGFloat kMessageViewHeight = 40;
    CGFloat kBtnViewHeight = 60;
    CGFloat kBtnViewWidth = (kScreen_Width - kMyPadding *2)/4;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kCarousHeight+kSafeAreaTopHeight + kMessageViewHeight + kBtnViewHeight)];
    view.backgroundColor = [UIColor whiteColor];
    {//轮播图
        if (!self.myCarouselView) {
            XRCarouselView *carousView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCarousHeight+kSafeAreaTopHeight)];
            carousView.placeholderImage = [UIImage imageNamed:@"MyImage"];
            carousView.time = 4;
            carousView.contentMode = UIViewContentModeScaleAspectFill;
            carousView.pagePosition = PositionBottomCenter;
            [carousView setDescribeTextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] bgColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
            [view addSubview:carousView];
            self.myCarouselView = carousView;
        }
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        for (CarouselModel *model in self.carouselArray) {
            [arr addObject:model.imageUrl];
        }
        self.myCarouselView.imageArray = @[@"MyImage",@"MyImage",@"MyImage",@"MyImage",@"MyImage"];
        __weak typeof(self)weakSelf = self;
        self.myCarouselView.imageClickBlock = ^(NSInteger index) {
            //            [BaseViewController goToLoginVC];
            
            if (weakSelf.carouselArray.count>0) {
                CarouselModel *model= [weakSelf.carouselArray objectAtIndex:index];
            }
        };
    }
    {
        UIView *btnView = [[UIView alloc] initWithFrame:(CGRect){0,kCarousHeight+kSafeAreaTopHeight,kScreen_Width,kBtnViewHeight}];
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(actionTopBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 0;
//            [btn setBackgroundImage:[UIImage imageWithColor:UIColor.redColor] forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){kBtnViewHeight/2,kBtnViewHeight/2}] forState:UIControlStateNormal];
            [btn setTitle:@"交易预告" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setFrame:(CGRect){kMyPadding,0,kBtnViewWidth,kBtnViewHeight}];
            [btn layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
            [btnView addSubview:btn];
            [view addSubview:btnView];
        }
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(actionTopBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1;
//            [btn setBackgroundImage:[UIImage imageWithColor:UIColor.blueColor] forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){kBtnViewHeight/2,kBtnViewHeight/2}] forState:UIControlStateNormal];
            [btn setTitle:@"闲置求购" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setFrame:(CGRect){kMyPadding+kBtnViewWidth,0,kBtnViewWidth,kBtnViewHeight}];
            [btn layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
            [btnView addSubview:btn];
            [view addSubview:btnView];
        }
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(actionTopBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2;
//            [btn setBackgroundImage:[UIImage imageWithColor:UIColor.yellowColor] forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){kBtnViewHeight/2,kBtnViewHeight/2}] forState:UIControlStateNormal];
            [btn setTitle:@"公平公告" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setFrame:(CGRect){kMyPadding+kBtnViewWidth*2,0,kBtnViewWidth,kBtnViewHeight}];
            [btn layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
            [btnView addSubview:btn];
            [view addSubview:btnView];
        }
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(actionTopBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 3;
//            [btn setBackgroundImage:[UIImage imageWithColor:UIColor.greenColor] forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){kBtnViewHeight/2,kBtnViewHeight/2}] forState:UIControlStateNormal];
            [btn setTitle:@"入住企业" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setFrame:(CGRect){kMyPadding+kBtnViewWidth*3,0,kBtnViewWidth,kBtnViewHeight}];
            [btn layoutButtonWithEdgeInsetsStyle:kbtnEdgeInsetsStyleTop imageTitleSpace:kMyPadding];
            [btnView addSubview:btn];
            [view addSubview:btnView];
        }
    }
    {//消息
        CGFloat kTop = kCarousHeight+kSafeAreaTopHeight +kBtnViewHeight;
        //背底View
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, kTop, kScreen_Width, kMessageViewHeight)];
        backView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [view addSubview:backView];
        //背底上面的白色View
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, kScreen_Width, kMessageViewHeight-1)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:whiteView];
        
        //消息图片
        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kMyPadding/2, kMyPadding/2, kMessageViewHeight, kMessageViewHeight-kMyPadding)];
        headImgView.contentMode = UIViewContentModeScaleAspectFit;
        headImgView.image = [[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){30,30}];
        [whiteView addSubview:headImgView];
        //图片右边细线
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgView.frame)+2, 2 , 1, kMessageViewHeight - 4)];
        linView.backgroundColor = [UIColor lightGrayColor];
        [whiteView addSubview:linView];
        
        //轮播显示的scrollView
        NSArray *topTitleArr = @[@"【交易预告】这里是工平闲置的消息展示"];
        SGAdvertScrollView *scrollView = [[SGAdvertScrollView alloc] initWithFrame:(CGRect){CGRectGetMaxX(linView.frame) +2, 1, kScreen_Width - kMyPadding-CGRectGetMaxX(linView.frame) -2, kMessageViewHeight-1}];
        
        scrollView.advertScrollViewStyle = SGAdvertScrollViewStyleNormal;
        scrollView.titles = topTitleArr;
        scrollView.delegate = self;
        scrollView.scrollTimeInterval = 5;
        scrollView.titleColor = [[UIColor blackColor] colorWithAlphaComponent:1];
        scrollView.textAlignment = NSTextAlignmentLeft;
        scrollView.backgroundColor = UIColor.whiteColor;
        [whiteView addSubview:scrollView];
        self.myMessageScrollView = scrollView;
    }
    return view;
}
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index{
}
-(void)actionTopBtn:(UIButton *)sender{
    if (sender.tag == 0) {
        JiaoYiYuGaoViewController *vc = [JiaoYiYuGaoViewController new];
        vc.title = @"交易预告";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1){
        XianZhiQiuGouViewController *vc = [XianZhiQiuGouViewController new];
        vc.title = @"闲置求购";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 2){
        GongPingGongGaoViewController *vc = [GongPingGongGaoViewController new];
        vc.title = @"公平公告";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 3){
        RuZhuQiYeViewController *vc = [RuZhuQiYeViewController new];
        vc.title = @"入驻企业";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSMutableArray *)successCaseDataSourceArray{
    if (!_successCaseDataSourceArray) {
        _successCaseDataSourceArray = [NSMutableArray new];
    }return _successCaseDataSourceArray;
}
-(void)serveData{
    Model_ChengJiaoAnLi *successM = [Model_ChengJiaoAnLi new];
    successM.status = @"1";
    successM.pageNum = @"1";
    successM.pageSize = @"4";
    
    Api_ChengJiaoAnLi *api = [[Api_ChengJiaoAnLi alloc] initWithSuccessModel:successM];
//    api.animatingText = @"0123正在加载数据，请稍候";
//    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject[@"code"] intValue] == 200) {
            [self.successCaseDataSourceArray removeAllObjects];
            [self.successCaseDataSourceArray addObjectsFromArray:[Model_ChengJiaoAnLi arrayOfModelsFromDictionaries:request.responseJSONObject[@"object"] error:nil]];
        }
        [self.myTableView reloadData];
//        NSLog(@"%@",self.successCaseDataSourceArray);
        NSLog(@"succeed");
        NSLog(@"response:%@",request.response);
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failed");
        NSLog(@"response:%@",request.response);
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    }];
}



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    // 设置导航栏标题和返回按钮颜色
//    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){30,30}] style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemLeft)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){30,30}] style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationItemRight)];
    self.navigationItem.rightBarButtonItem = rightBarButton;

//    MyTitleView *titleView = [[MyTitleView alloc] initWithFrame:self.navigationItem.titleView.frame];
//    titleView.backgroundColor = UIColor.purpleColor;
//    titleView.intrinsicContentSize = CGSizeMake(200, 40);
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){kScreen_Width,30}]];
//    [imageView setFrame:titleView.frame];
//    titleView.clipsToBounds = YES;
//    [titleView addSubview:imageView];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[[UIImage imageWithColor:kMyImageColor] scaleImageWithSize:(CGSize){kScreen_Width,30}]];
    
    NSLog(@"%f",self.navigationItem.titleView.frame.size.width);
    
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView.tableHeaderView = [self tableHeaderView];
    
}
-(void)actionNavigationItemLeft{
    [self.navigationController pushViewController:[ProductCategoryViewController new] animated:YES];
}
-(void)actionNavigationItemRight{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:searchVC];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self serveData];
}
#pragma mark - TableView
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.sectionIndexBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.showsVerticalScrollIndicator = NO;
            tableView.allowsMultipleSelectionDuringEditing = YES;
            
            //            tableView.tableHeaderView = [self tableHeader];
            //            tableView.tableFooterView = [self tableFooterView];
            //        [tableView registerClass:[CountryCodeCell class] forCellReuseIdentifier:kCellIdentifier_CountryCodeCell];
            
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight+60, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            tableView;
        });
    }return _myTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 2;
    }
    if (section == 6) {
        return ceil(self.successCaseDataSourceArray.count/2.0);;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [BiddingView_special cellHeight];
    }else if (indexPath.section == 1){
        return [BiddingView_single cellHeight];
    }else if (indexPath.section == 2){
        return [BiddingView_iCarouselGroup cellHeight];
    }else if (indexPath.section == 6){
        return [ChengJiaoAnLiView_TwoImg cellHeight];
    }
    else{
        return [CTCell cellHeight];
    }
//    return 44;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"专场竞价";
    }
    else if (section == 1){
        return @"单场竞价";
    }
    else if (section == 2){
        return @"集团专场";
    }
    else if (section == 3){
        return @"闲置供应 - 废材料";
    }
    else if (section == 4){
        return @"闲置供应 - 闲废设备";
    }
    else if (section == 5){
        return @"闲置供应 - 闲置备品备件";
    }
    else{
        return @"成交案例";
    }
}
//设置组头和组尾部的颜色
-(void)actionMore:(UIButton *)sender{
    if (sender.tag == 0) {
        NSLog(@"000");
        MyBiddingListViewController *vc = [MyBiddingListViewController new];
        vc.title = @"专场竞价";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 1) {
        NSLog(@"111");
        MyBiddingListViewController *vc = [MyBiddingListViewController new];
        vc.title = @"单场竞价";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 2) {
        NSLog(@"222");
        JiTuanZhuanChangViewController *vc = [JiTuanZhuanChangViewController new];
        vc.title = @"集团专场";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 3) {
        NSLog(@"333");
        XianZhiGongYingViewController *vc = [XianZhiGongYingViewController new];
        vc.title = @"闲置供应-废材料";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 4) {
        NSLog(@"444");
        XianZhiGongYingViewController *vc = [XianZhiGongYingViewController new];
        vc.title = @"闲置供应-闲废设备";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 5) {
        NSLog(@"555");
        XianZhiGongYingViewController *vc = [XianZhiGongYingViewController new];
        vc.title = @"闲置供应-闲置备品备件";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 6) {
        NSLog(@"666");
        ChengJiaoAnLiViewController *vc = [ChengJiaoAnLiViewController new];
        vc.title = @"成交案例";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"common_icon_arrow"] forState:UIControlStateNormal];
    [btn setTag:section];
    [btn addTarget:self action:@selector(actionMore:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:(CGRect){kScreen_Width - kMyPadding - 50,0,50,[self tableView:tableView heightForHeaderInSection:section]}];
    [btn layoutButtonWithEdgeInsetsStyle:kBtnEdgeInsetsStyleRight imageTitleSpace:3];
    [view addSubview:btn];
//    view.tintColor = UIColor.whiteColor;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
//    view.tintColor = UIColor.whiteColor;
    // 设置section字体颜色
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    [header.textLabel setTextColor:UIColor.redColor];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3||indexPath.section == 4||indexPath.section == 5) {
        static NSString *CellIdentifier = @"CTCell";
        //[NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]]
        CTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
            BiddingModel *model = [BiddingModel new];
            cell.dataSourceArray = [NSMutableArray arrayWithObjects:model, model, model, model, model, nil];
//            SpecialModel * specialM = [self.dataSourceArray objectAtIndex:indexPath.section];
//            [cell setBackgroundColor:UIColor.groupTableViewBackgroundColor];
//            [cell setDelegate:self];
//            cell.tag = indexPath.section;
//            cell.specialM = specialM;
        
        return cell;
    }else{
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
    
}
#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self configSelect:tableView forIndexPath:indexPath];
}
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BiddingView_special *view = [[BiddingView_special alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [BiddingView_special cellHeight])];
        view.biddingM = [BiddingModel new];
        [cell.contentView addSubview:view];
    }
    else if (indexPath.section == 1){
        BiddingView_single *view = [[BiddingView_single alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [BiddingView_single cellHeight])];
        view.biddingM = [BiddingModel new];
        [cell.contentView addSubview:view];
    }
    else if (indexPath.section == 2){
        BiddingView_iCarouselGroup *view = [[BiddingView_iCarouselGroup alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [BiddingView_iCarouselGroup cellHeight])];
        view.items = [NSMutableArray arrayWithObjects:[BiddingModel new],[BiddingModel new],[BiddingModel new],[BiddingModel new],[BiddingModel new],[BiddingModel new],[BiddingModel new],[BiddingModel new],[BiddingModel new],[BiddingModel new], nil];
        __weak typeof(self) weakSelf = self;
        view.selectedBlock = ^(NSInteger index) {
//            SpecialViewController *vc = [SpecialViewController new];
//            vc.title = @"专场";
//            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [cell.contentView addSubview:view];
//        view.biddingM = [BiddingModel new];
    }
    else if (indexPath.section == 3){
        Product_TransverseView *view = [[Product_TransverseView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [Product_TransverseView cellHeight])];
        [cell.contentView addSubview:view];
    }
    else{
        ChengJiaoAnLiView_TwoImg *view = [[ChengJiaoAnLiView_TwoImg alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [ChengJiaoAnLiView_TwoImg cellHeight])];
        view.delegate = self;
        [view configProductWithArr:self.successCaseDataSourceArray indexPath:indexPath];
        [cell.contentView addSubview:view];
    }
}
-(void)productView_TwoImg:(ChengJiaoAnLiView_TwoImg *)productView_TwoImg didSelectProduct:(Model_ChengJiaoAnLi *)productM{
    XRChengJiaoDetailViewController*vc = [[XRChengJiaoDetailViewController alloc] init];
    vc.tnId = productM.tnId;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"dianjila");
}
-(void)configSelect:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 6) {
        ChengJiaoAnLiViewController *vc = [[ChengJiaoAnLiViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        JingJiaDetailViewController *vc = [[JingJiaDetailViewController alloc] init];
        //ToDo:0123
        vc.tnId = @"8a88888a5b9ec843015badddab640189";
        [self.navigationController pushViewController:vc animated:YES];
    }
//    if (self.pager != nil) {
//        [self.pager removeObserver:self forKeyPath:@"segmentTopInset"];
//        self.pager = nil;
//    }
//
//    ShopDetailListViewController *vc0 = [[ShopDetailListViewController alloc] init];
//    vc0.categoryType = kCollectionType_PersonalSection;
//    ShopDetailListViewController *vc1 = [[ShopDetailListViewController alloc] init];
//    vc1.categoryType = kCollectionType_Product;
//    ShopDetailListViewController *vc2 = [[ShopDetailListViewController alloc] init];
//    vc2.categoryType = kCollectionType_Barter;
//
//    ShopDetailSegmentPageController *pager = [[ShopDetailSegmentPageController alloc] init];
//    [pager setViewControllers:@[vc0,vc1,vc2]];
//    pager.segmentMiniTopInset = 64;
//    if (@available(iOS 11.0, *)) {
//        pager.segmentMiniTopInset = 84;
//    }
//    pager.headerHeight = 200;
//    pager.freezenHeaderWhenReachMaxHeaderHeight = YES;
//
//    self.pager = pager;
//    [self.pager addObserver:self forKeyPath:@"segmentTopInset" options:NSKeyValueObservingOptionNew context:NULL];
//    [self.navigationController pushViewController:self.pager animated:YES];
    
    
    //    ShopDetailViewController *vc = [ShopDetailViewController new];
    //    vc.title = @"店铺详情";
    ////    vc.productM = [ProductModel new];
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end
