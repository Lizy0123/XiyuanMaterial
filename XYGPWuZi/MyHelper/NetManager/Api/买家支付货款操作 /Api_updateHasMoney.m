//
//  Api_updateHasMoney.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/16.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_updateHasMoney.h"

@implementation Api_updateHasMoney
{
    NSString *_cpId;
    NSString *_phoneCode;
}

-(instancetype)initWithCpId:(NSString *)cpId phoneCode:(NSString *)phoneCode{
    if (self = [super init]) {
        _cpId = cpId;
        _phoneCode = phoneCode;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/compact/token/updateHasMoney";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"cpId":_cpId,
             @"phoneCode":_phoneCode,
             
             };
}
@end
