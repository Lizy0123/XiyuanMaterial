//
//  DanChangGuanLiViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "DanChangGuanLiViewController.h"
#import "MyTradeSiteListViewController.h"

@interface DanChangGuanLiViewController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation DanChangGuanLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"单场管理";
    
    self.titles = @[@"待发布",@"已发布",@"竞价中",@"待收款",@"待提货",@"竞价成功",@"竞价失败"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.gradualChangeTitleColor = YES;
    style.autoAdjustTitlesWidth = YES;
    style.normalTitleColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    style.selectedTitleColor = kColorNav;
    style.scrollLineColor = kColorNav;
    style.titleFont = [UIFont boldSystemFontOfSize:13];
    style.segmentHeight = 30;
    
    // 初始化
    _scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - kSafeAreaTopHeight) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.scrollPageView setSelectedIndex:self.selectedPage animated:NO];
    
    [self.view addSubview:_scrollPageView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (MyTradeSiteListViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(MyTradeSiteListViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    MyTradeSiteListViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = [[MyTradeSiteListViewController alloc] init];
    }
    if (index == 0) {
        childVc.myTradeSiteStatus = kMyTradeSiteStatus_WaitPublic;
    }else if (index == 1){
        childVc.myTradeSiteStatus = kMyTradeSiteStatus_PublicSuccess;
    }else if (index == 2){
        childVc.myTradeSiteStatus = kMyTradeSiteStatus_BiddingNow;
    }else if (index == 3){
        childVc.myTradeSiteStatus = kMyTradeSiteStatus_WaitReciveMoney;
    }else if (index == 4){
        childVc.myTradeSiteStatus = kMyTradeSiteStatus_WaitReciveProduct;
    }else if (index == 5){
        childVc.myTradeSiteStatus = kMyTradeSiteStatus_BiddingSuccess;
    }else if (index == 6){
        childVc.myTradeSiteStatus = kMyTradeSiteStatus_Failure;
    }
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}
@end
