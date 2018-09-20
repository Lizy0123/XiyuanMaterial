//
//  Api_updateDepositInfoById.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_updateDepositInfoById.h"

@implementation Api_updateDepositInfoById{
    NSString *_phoneCode;
    NSString *_diId;
    
}

-(instancetype)initWithdiId:(NSString *)diId withPhoneCode:(NSString *)phoneCode{
    if (self = [super init]) {
        _diId = diId;
        _phoneCode = phoneCode;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/depositInfo/token/updateDepositInfoById";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"diId":_diId,
             @"phoneCode":_phoneCode,
             
             };
}


@end
