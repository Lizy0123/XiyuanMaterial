//
//  Api_bindBank.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_bindBank.h"

@implementation Model_BindBank

@end

@implementation Api_bindBank{
    Model_BindBank *_bindBankM;
}
-(instancetype)initWithModelBindBank:(Model_BindBank *)bindBankM{
    if (self = [super init]) {
        _bindBankM = bindBankM;
        
    }return self;
}
-(NSString *)requestUrl{
    return @"xy/facBankAccount/token/bindBnak";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"fbaId":_bindBankM.fbaId,
             @"fbaBankBs":_bindBankM.fbaBankBs,
             @"fbaBankHh":_bindBankM.fbaBankHh ,
             @"fbaBankHm":_bindBankM.fbaBankHm ,
             @"fbaBankName":_bindBankM.fbaBankName ,
             @"fbaBankNo":_bindBankM.fbaBankNo ,
    };
}



@end


