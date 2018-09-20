//
//  DanChangJingJiaViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "DanChangJingJiaViewController.h"
#import "MyJingJiaListViewController.h"
@interface DanChangJingJiaViewController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;


@end

@implementation DanChangJingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"单场竞价";
    
    self.titles = @[@"已报名",@"已参加",@"竞价中",@"待支付",@"待提货",@"竞价完成",@"竞价失败"];;
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
#pragma mark - AJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (MyJingJiaListViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(MyJingJiaListViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    MyJingJiaListViewController<ZJScrollPageViewChildVcDelegate> *vc = reuseViewController;
    if (!vc) {
        vc = [[MyJingJiaListViewController alloc]init];
    }
    if (index == 0) {
        vc.myJingJiaListStatus = kMyJingJingListStatusYiBaoMing;
    }else if (index == 1){
        vc.myJingJiaListStatus = kMyJingJingListStatusYiCanJia;
    }else if (index == 2){
        vc.myJingJiaListStatus = kMyJingJingListStatusStarted;
    }else if (index == 3){
        vc.myJingJiaListStatus = kMyJingJingListStatusWaitingTopay;
    }else if (index == 4){
        vc.myJingJiaListStatus = kMyJingJingListStatusAlreadyPay;
    }else if (index == 5){
        vc.myJingJiaListStatus = kMyJingJingListStatusSuccess;
    }else if (index == 6){
        vc.myJingJiaListStatus = kMyJingJingListStatusFaild;
    }
    return vc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}
@end
