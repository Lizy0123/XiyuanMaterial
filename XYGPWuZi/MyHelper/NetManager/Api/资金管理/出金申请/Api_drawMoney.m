//
//  Api_drawMoney.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_drawMoney.h"

@implementation Api_drawMoney{
    NSString *_drawMoney;
    NSString *_phoenCode;
}

-(instancetype)initWithDrawMoney:(NSString *)drawMoney phoneCode:(NSString *)phoneCode{
    if (self = [super init]) {
        _drawMoney = drawMoney;
        _phoenCode = phoneCode;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/money/token/drawMoney";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"drawMoney":_drawMoney,
             @"phoneCode":_phoenCode,
             };
}

@end
