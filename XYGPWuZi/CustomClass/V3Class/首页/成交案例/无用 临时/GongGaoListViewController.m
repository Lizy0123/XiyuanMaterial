//
//  GongGaoListViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "GongGaoListViewController.h"
#import "TradeNoticeViewController.h"
#import "ZJScrollPageView.h"
#import "JiaoYiYuGaoViewController.h"
#import "ChengJiaoAnLiViewController.h"
@interface GongGaoListViewController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;
@property (weak, nonatomic) ZJContentView *contentView;

@end

@implementation GongGaoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.childVcs = [self setupChildVc];
    // 初始化
    [self setupSegmentView];
    [self setupContentView];
}

- (void)setupSegmentView {
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showCover = YES;
    // 不要滚动标题, 每个标题将平分宽度
    style.scrollTitle = NO;
    
    // 渐变
    style.gradualChangeTitleColor = YES;
    // 遮盖背景颜色
    style.coverBackgroundColor = [UIColor clearColor];
    //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.normalTitleColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.selectedTitleColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    
    self.titles = @[@"竞价公告", @"交易预告",@"成交案例"];
    
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight, [UIScreen mainScreen].bounds.size.width - 96, 28.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        NSLog(@"----%ld",index);
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:NO];
        
    }];
    // 自定义标题的样式
    //segment.layer.cornerRadius = 14.0;
    //segment.backgroundColor = [UIColor redColor];
    // 当然推荐直接设置背景图片的方式
    //    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    
    self.segmentView = segment;
    [self.segmentView setSelectedIndex:self.selectedPage animated:NO];
    self.navigationItem.titleView = self.segmentView;
    
}

- (void)setupContentView {
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [content setContentOffSet:CGPointMake(content.bounds.size.width * self.selectedPage, 0) animated:NO];
    [self.view addSubview:self.contentView];
    
}

- (NSArray *)setupChildVc {
    
    TradeNoticeViewController *vc1 = [TradeNoticeViewController new];
    JiaoYiYuGaoViewController *vc2 = [JiaoYiYuGaoViewController new];
    ChengJiaoAnLiViewController *vc3 = [ChengJiaoAnLiViewController new];

    NSArray *childVcs = [NSArray arrayWithObjects:vc1,vc2,vc3, nil];
    return childVcs;
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = self.childVcs[index];
    }
    
    return childVc;
}


-(CGRect)frameOfChildControllerForContainer:(UIView *)containerView {
    return  CGRectInset(containerView.bounds, 20, 20);
}
@end
