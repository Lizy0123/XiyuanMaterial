//
//  Api_findBackPsd.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/24.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_findBackPsd.h"

@implementation Api_findBackPsd{
    NSString *_mobile;
    NSString *_password;
    NSString *_code;
}
-(instancetype)initWithMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code{
    if (self = [super init]) {
        _mobile = mobile;
        _password = password;
        _code = code;
    }return self;
}
-(NSString *)requestUrl{
    return @"xy/user/modifypwd.json";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{@"mobil":_mobile,@"password":_password,@"code":_code};
}
@end
