//
//  Api_findDepositForUpdate.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_findDepositForUpdate.h"

@implementation Model_TradeSite
@end

@implementation Model_Trade
@end

@implementation Api_findDepositForUpdate{
    NSString *_tsId;
}

-(instancetype)initWithtsId:(NSString *)tsId{
    if (self = [super init]) {
        _tsId = tsId;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/tradeSite/token/findDepositForUpdate";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"tsId":_tsId,
             };
}

@end
