//
//  MyLoginViewController.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/19.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, kLoginViewType) {
    kLoginViewType_AccountPass = 0, /*账号密码登录*/
    kLoginViewType_MobileCode = 1, /*手机验证码登录*/
    kLoginViewType_ThirdLoginShow = 2, /*三方登录显示*/
};
@interface MyLoginViewController : BaseViewController
@property(assign, nonatomic)kLoginViewType loginViewType;
@end
