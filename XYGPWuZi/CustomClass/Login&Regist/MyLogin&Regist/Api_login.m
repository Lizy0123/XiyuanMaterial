//
//  Api_login.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/24.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_login.h"

@implementation Api_login{
    NSString *_mobile;
    NSString *_password;
}
-(instancetype)initWithMobile:(NSString *)mobile password:(NSString *)password{
    if (self = [super init]) {
        _mobile = mobile;
        _password = password;
    }return self;
}
-(NSString *)requestUrl{
    return @"xy/user/login.json";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{@"mobil":_mobile,@"password":_password};
}
@end
