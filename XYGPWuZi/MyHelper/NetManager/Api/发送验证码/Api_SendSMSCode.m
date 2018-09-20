//
//  Api_SendSMSCode.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_SendSMSCode.h"

@implementation Api_SendSMSCode{
    NSString *_mobile;
    NSString *_type;
    
}

-(NSString *)requestUrl{//4、绑定财务联系人发送验证码5、出金申请发送验证码6、支付货款验证码 7确认收获 8 验证码登录
    return [NSString stringWithFormat:@"xy/user/send/%@/%@.json",_mobile,_type];
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}
-(instancetype)initWithMobile:(NSString *)mobile type:(NSString *)type{
    if (self = [super init]) {
        _mobile = mobile;
        _type = type;
    }return self;
}

-(id)requestArgument{
    return @{
             @"phoneNumber":_mobile,
             @"phoneType":_type,
             @"token":[UserManager readUserInfo].token?[UserManager readUserInfo].token:@""
             };
}

@end
