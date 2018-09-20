//
//  Api_findPayInfo.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/15.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_findPayInfo.h"

@implementation Model_Product

@end

@implementation Model_PayForProduct

@end

@implementation Api_findPayInfo{
    NSString *_cpId;
}

-(instancetype)initWithtsId:(NSString *)cpId{
    if (self = [super init]) {
        _cpId = cpId;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/compact/token/findPayInfo";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"cpId":_cpId,
             };
}

@end
