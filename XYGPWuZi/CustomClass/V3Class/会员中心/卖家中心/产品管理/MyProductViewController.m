//
//  XRMyProductViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "MyProductViewController.h"
#import "MyProductListViewController.h"

@interface MyProductViewController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation MyProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品管理";

    self.titles = @[@"待审核",@"已审核",@"未通过"];;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = NO;
    style.gradualChangeTitleColor = YES;
    style.autoAdjustTitlesWidth = YES;
    style.normalTitleColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    style.selectedTitleColor = kColorNav;
    style.titleFont = [UIFont boldSystemFontOfSize:16];
    
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


#pragma mark - AJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (MyProductListViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(MyProductListViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    MyProductListViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = [[MyProductListViewController alloc] init];
    }
    if (index == 0) {
        childVc.myProductAuditStatus = kMyProductAuditStatus_ToDo;
    }else if (index == 1){
        childVc.myProductAuditStatus = kMyProductAuditStatus_Success;
    }else if (index == 2){
        childVc.myProductAuditStatus = kMyProductAuditStatus_Reject;
    }
    //    NSLog(@"%ld-----%@",(long)index, childVc);
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}
@end
