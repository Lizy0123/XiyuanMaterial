//
//  Api_FindUserBankInfo.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_FindUserBankInfo.h"

@implementation Model_dm

@end

@implementation Api_FindUserBankInfo
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/facBankAccount/token/findUserBankInfo";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token
             };
}
@end
