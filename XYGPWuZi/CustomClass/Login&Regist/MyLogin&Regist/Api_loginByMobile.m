//
//  Api_loginByMobile.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/24.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_loginByMobile.h"

@implementation Api_loginByMobile{
    NSString *_mobile;
    NSString *_password;
}
-(instancetype)initWithPhoneNum:(NSString *)phoneNum code:(NSString *)code{
    if (self = [super init]) {
        _mobile = phoneNum;
        _password = code;
    }return self;
}
-(NSString *)requestUrl{
    return @"xy/user/loginByMobile";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{@"phoneNum":_mobile,@"code":_password};
}

@end
