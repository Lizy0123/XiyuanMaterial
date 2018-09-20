//
//  BaseNavigationController.m
//  Taoyi
//
//  Created by Lzy on 2018/1/27.
//  Copyright © 2018年 Lzy. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseMyNavigationController ()

@end

@implementation BaseMyNavigationController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];


    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                                 NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                 }];
//    [self.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
//    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:1]];
    
    self.navigationController.navigationItem.leftBarButtonItem.tintColor = kColorMain;
    self.navigationItem.rightBarButtonItem.tintColor = kColorMain;
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
//    [self.navigationBar setTintColor:[UIColor darkGrayColor]];
    

    
}
-(UIImage *) createImageWithColor: (UIColor *) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
