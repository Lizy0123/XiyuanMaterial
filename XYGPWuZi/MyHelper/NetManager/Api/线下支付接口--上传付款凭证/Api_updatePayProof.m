//
//  Api_updatePayProof.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_updatePayProof.h"

@implementation Api_updatePayProof{
    NSString *_diId;
    NSString *_payProof;
}

-(instancetype)initWithdiId:(NSString *)diId payProof:(NSString *)payProof{
    if (self = [super init]) {
        _diId = diId;
        _payProof = payProof;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"tradeSite/token/updatePayProof";
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"diId":_diId,
             @"payProof":_payProof,
             };
}


@end
