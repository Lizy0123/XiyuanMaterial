//
//  BaseViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "BaseTabBarController.h"

#pragma mark - UIViewController (Dismiss)
@interface UIViewController (Dismiss)
- (void)dismissModalVC;
@end
@implementation UIViewController (Dismiss)
- (void)dismissModalVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationItem.leftBarButtonItem.tintColor = UIColor.whiteColor;
//    self.navigationItem.rightBarButtonItem.tintColor = UIColor.whiteColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(void)saveUserInfo:(id  _Nullable)responseObject{
    //1.创建UUseModel
    UserModel *userModel = [[UserModel alloc] initWithDictionary:responseObject[@"object"] error:nil];
    if (!userModel) {
        return ;
    }
    //2.存储UserInfo（userModel）
    userModel.codeId = responseObject[@"codeId"];
    userModel.token = responseObject[@"token"];
    [UserManager saveUserInfo:userModel];
    //3.token存储到useDefault中
    if (((NSString *)responseObject[@"token"]).length>0) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:responseObject[@"token"] forKey:kToken];
        [userDefault synchronize];
    }else{
        [UserManager clearUserInfo];
    }
}
#pragma mark - Action
+(UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[BaseTabBarController class]]) {
        result = [(BaseTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
+(void)presentVC:(UIViewController *)viewController hasNav:(BOOL)hasNav{
    if (!viewController) {
        return;
    }
    if (hasNav) {
        UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        if (!viewController.navigationItem.leftBarButtonItem) {
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:viewController action:@selector(dismissModalVC)];
        }
        [[self presentingVC] presentViewController:nav animated:YES completion:nil];
    }else{
        [[self presentingVC] presentViewController:viewController animated:YES completion:nil];
    }
}
+(void)goToVC:(UIViewController *)viewController{
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [self presentingVC].navigationController;
    if (nav) {
        [nav pushViewController:viewController animated:YES];
    }
}

-(void)goToLoginVC{
    LoginViewController *vc = [LoginViewController new];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismissModalVC)];
    vc.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

+(void)goToLoginVC{
    LoginViewController *vc = [LoginViewController new];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismissModalVC)];
    vc.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [BaseViewController presentVC:[[BaseNavigationController alloc] initWithRootViewController:vc] hasNav:NO];
}

@end
