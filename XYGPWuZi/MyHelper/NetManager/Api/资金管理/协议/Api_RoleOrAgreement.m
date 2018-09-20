//
//  Api_RoleOrAgreement.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/8.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_RoleOrAgreement.h"

@implementation Api_RoleOrAgreement
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}
-(NSString *)requestUrl{
    return @"xy/ruleOrAgreemnt/showDoc";
}

@end
