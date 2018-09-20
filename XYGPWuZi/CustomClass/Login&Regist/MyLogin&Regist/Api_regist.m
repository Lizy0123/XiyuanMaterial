//
//  Api_regist.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/25.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_regist.h"

@implementation Model_regist

@end


@implementation Api_regist{
    Model_regist *_registM;
}
-(instancetype)initWithRegistM:(Model_regist *)regidtM{
    if (self = [super init]) {
        _registM = regidtM;
    }return self;
}
-(NSString *)requestUrl{
    return @"xy/user/register.json";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{
             @"mobil":_registM.mobile,
             @"password":_registM.password,
             @"caseName":_registM.name,
             @"facUserType":_registM.type,
             @"code":_registM.code,
             @"loginName":_registM.account,
             @"unitsFull":_registM.companyName?_registM.companyName:@""
             
             };
}
@end
