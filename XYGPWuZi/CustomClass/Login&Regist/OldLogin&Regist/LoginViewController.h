//
//  LoginViewController.h
//  LoginDemo
//
//  Created by 河北熙元科技有限公司 on 2017/6/2.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//


#import "BaseViewController.h"
@protocol LoginViewDelegate <NSObject>
-(void)LoginViewController:(UIViewController *)loginViewController;

@end


@interface LoginViewController : BaseViewController
@property(nonatomic,weak)id<LoginViewDelegate>loginDelegate;

@end
