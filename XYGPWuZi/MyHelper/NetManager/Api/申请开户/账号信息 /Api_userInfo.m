//
//  Api_updateDepositInfoById.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_userInfo.h"

@implementation Api_userInfo{
    NSString *_facUserid;
}

-(instancetype)initWithfacUserid:(NSString *)facUserid{
    if (self = [super init]) {
        _facUserid = facUserid;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/user/token/userInfo";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"facUserid":_facUserid,
             };
}

@end
