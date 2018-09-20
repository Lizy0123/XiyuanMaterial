//
//  BaseNavigationController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/5.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIButton+Common.h"
@interface BaseNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end

@implementation BaseNavigationController
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
+ (void)initialize{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    [self addSwipeRecognizer];
    self.navigationBar.barTintColor = [UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:1];
    [self.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1]}];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) { // 不是根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back_bt_7"] highImage:[UIImage imageNamed:@"back_bt_7"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
    }
    [super pushViewController:viewController animated:animated];
    [viewController.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
       viewController.navigationController.navigationBar.barTintColor = kColorNav;
    
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)popToRoot{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre{
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }else{ // 非根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        // 初始化手势并添加执行方法
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(return)];
        // 手势方向
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        // 响应的手指数
        swipeRecognizer.numberOfTouchesRequired = 1;
        // 添加手势
        [[self view] addGestureRecognizer:swipeRecognizer];
    
    }
}

#pragma mark 添加右滑手势
- (void)addSwipeRecognizer{
    // 最低控制器无需返回
    if (self.viewControllers.count <= 1) return;
    
    // pop返回上一级
    [self popViewControllerAnimated:YES];
}
#pragma mark 返回上一级
- (void)return{
    // 最低控制器无需返回
    if (self.viewControllers.count <= 1) return;
    // pop返回上一级
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
