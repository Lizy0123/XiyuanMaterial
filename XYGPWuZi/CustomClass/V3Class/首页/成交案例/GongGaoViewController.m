//
//  GongGaoViewController.m
//  XYGPWuZi
//
//  Created by apple on 2017/10/10.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "GongGaoViewController.h"
#import "UIViewAdditions.h"
#import "TradeNoticeViewController.h"

#import "TransactionPreviewViewController.h"
#import "SuccessCaseViewController.h"

@interface GongGaoViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *allVC;
@property (nonatomic, strong) SMPagerTabView *segmentView;
@end

@implementation GongGaoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
    
}
-(id)init{
    if (self = [super init]) {
        self.canGoBack = NO;
        self.selectIndex = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _allVC = [NSMutableArray array];
    TradeNoticeViewController *one = [[TradeNoticeViewController alloc]initWithNibName:nil bundle:nil];
    
    one.title = @"竞价公告";
   
    [_allVC addObject:one];
    
    TransactionPreviewViewController *two = [[TransactionPreviewViewController alloc]initWithNibName:nil bundle:nil];
    
    two.title = @"交易预告";
    
    [_allVC addObject:two];
    
    SuccessCaseViewController *three = [[SuccessCaseViewController alloc]initWithNibName:nil bundle:nil];
    three.title = @"成交案例";
   
    [_allVC addObject:three];
    
    self.segmentView.delegate = self;
    //可自定义背景色和tab button的文字颜色等
    self.segmentView.tabBackgroundColor = [UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:1];
    //开始构建UI
    [_segmentView buildUI];
    //起始选择一个tab
    [_segmentView selectTabWithIndex:self.selectIndex animate:NO];
    //显示红点，点击消失
    //[_segmentView showRedDotWithIndex:0];
    
    if (self.canGoBack == YES) {
        
        UIButton *canGoBackbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        canGoBackbutton.frame = CGRectMake(kMyPadding, 20, 32, 44);
        if (kDevice_iPhoneX) {
            canGoBackbutton.frame = CGRectMake(kMyPadding, 44, 32, 44);
        }
        //canGoBackbutton.backgroundColor = [UIColor magentaColor];
        [canGoBackbutton addTarget:self action:@selector(cangoBack) forControlEvents:UIControlEventTouchUpInside];
        [_segmentView addSubview:canGoBackbutton];
        
        
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(0, 12, 32, 20);
        //imageBtn.backgroundColor = [UIColor blueColor];
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"back_bt_7"] forState:UIControlStateNormal];

        [imageBtn addTarget:self action:@selector(cangoBack) forControlEvents:UIControlEventTouchUpInside];
        [canGoBackbutton addSubview:imageBtn];
    }
    
}

-(void)cangoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [_allVC count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return _allVC[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    NSLog(@"页面 %lu",(unsigned long)number);
}

#pragma mark - setter/getter
- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        self.segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
}
#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
