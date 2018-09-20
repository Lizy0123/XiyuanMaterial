//
//  BaseTabBarController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/3/6.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseTabBarController.h"
#import "MyLoginViewController.h"
@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    if ([item isEqual:[tabBar.items objectAtIndex:1]]) {
//        if ([kStringSessionId length]==0) {
//            LoginViewController *vc = [LoginViewController new];
//            BaseNavigationController *nv = [[BaseNavigationController alloc] initWithRootViewController:vc];
//            [self presentViewController:nv animated:YES completion:^{
//            }];
//        }
//    }
//}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isEqual:[tabBarController.viewControllers objectAtIndex:0]]) {
        NSLog(@"首页");
    }
    if ([viewController isEqual:[tabBarController.viewControllers objectAtIndex:1]]) {
        NSLog(@"竞价专区");
    }
    if ([viewController isEqual:[tabBarController.viewControllers objectAtIndex:2]]) {
        NSLog(@"集团专场");
    }
    if ([viewController isEqual:[tabBarController.viewControllers objectAtIndex:3]]) {
        NSLog(@"会员中心");
    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(viewController == [tabBarController.viewControllers objectAtIndex:3]){
        if ([kStringToken length]==0) {
            MyLoginViewController *vc = [MyLoginViewController new];
            BaseNavigationController *nv = [[BaseNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nv animated:YES completion:^{
            }];
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}
@end
